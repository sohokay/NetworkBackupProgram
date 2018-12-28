<?php
error_reporting(0);
define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME)); // 后台文件名
define('FCPATH', str_replace("\\", DIRECTORY_SEPARATOR, dirname(__FILE__).DIRECTORY_SEPARATOR)); // 网站根目录
header('Access-Control-Allow-Origin:*');   
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");  
require_once('config.php');
require_once(FCPATH."ffmpeg.php");

$key = isset($_REQUEST["key"]) ? $_REQUEST["key"] : ''; 
$arr = json_decode(sys_auth($key,1),1);
$add['uid'] = (int)$arr['id'];
$add['cid'] = (int)$arr['cid'];
$add['mycid'] = (int)$arr['mycid'];
if($add['uid'] == 0){
	getjson('uid error');
}
//文件保存目录
if(substr(Up_Dir,0,2) == './'){
	$Video_Path = FCPATH.substr(Up_Dir,2);
}else{
	$Video_Path = Up_Dir;
}
//分片文件夹
$targetDir = $Video_Path.'/temp/';
//保存盘符路径
$uploadDir = $Video_Path.'/'.date('Ym').'/'.date('d').'/';
//上传出错
if (!empty($_REQUEST[ 'debug' ]) ) { 
	$random = rand(0, intval($_REQUEST[ 'debug' ]) ); 
	if ( $random === 0 ) { 
		getjson($_REQUEST['debug']);
	}
}
//创建目录
if (!file_exists($targetDir)) { 
	mkdirss($targetDir); 
} 
//创建目录
if (!file_exists($uploadDir)) { 
	mkdirss($uploadDir); 
}
//原文件名
if(!isset($_FILES['video']['name'])){
	//print_r($_FILES);exit;
	exit;
}
$file_name = $_FILES['video']['name'];
//文件后缀
$file_ext = strtolower(trim(substr(strrchr($file_name, '.'), 1)));
$newname = iconv("UTF-8","GBK//IGNORE",$file_name);
$video_name = str_replace('.'.$file_ext, '', $file_name);

//根据文件名生成一个唯一MD5
$fileName = md5($file_name).'.'.$file_ext;
$oldName = $fileName;
$filePath = $targetDir . DIRECTORY_SEPARATOR . $fileName; 
//分片ID
$chunk = isset($_REQUEST["chunk"]) ? intval($_REQUEST["chunk"]) : 0; 
//分片总数量
$chunks = isset($_REQUEST["chunks"]) ? intval($_REQUEST["chunks"]) : 1;  
//打开临时文件 
if (!$out = @fopen("{$filePath}_{$chunk}.parttmp", "wb")) { 
	getjson('Failed to open output stream.'); 
} 
if (!empty($_FILES)) {
	if ($_FILES["video"]["error"] || !is_uploaded_file($_FILES["video"]["tmp_name"])) { 
		getjson('Failed to move uploaded file.'); 
	} 
	//读取二进制输入流并将其附加到临时文件
	if (!$in = @fopen($_FILES["video"]["tmp_name"], "rb")) { 
		getjson('Failed to open input stream.'); 
	} 
} else { 
	if (!$in = @fopen("php://input", "rb")) { 
		getjson('Failed to open input stream.'); 
	}
} 
while ($buff = fread($in, 4096)) { 
	fwrite($out, $buff); 
} 
@fclose($out); 
@fclose($in); 
rename("{$filePath}_{$chunk}.parttmp", "{$filePath}_{$chunk}.part"); 
$index = 0; 
$done = true; 
for( $index = 0; $index < $chunks; $index++ ) { 
	if(!file_exists("{$filePath}_{$index}.part") ) { 
		$done = false; 
		break; 
	} 
}
if($done){ 
	$pathInfo = pathinfo($fileName); 
	$hashStr = substr(md5($pathInfo['basename']),8,5);
	$hashName = date('YmdHis').$hashStr.'.'.$pathInfo['extension']; 
	$uploadPath = $uploadDir.$hashName;
	if (!$out = @fopen($uploadPath, "wb")) { 
		getjson('Failed to open output stream.'); 
	} 
	if ( flock($out, LOCK_EX) ) { 
		for( $index = 0; $index < $chunks; $index++ ) { 
			if (!$in = @fopen("{$filePath}_{$index}.part", "rb")) { 
				break; 
			} 
			while ($buff = fread($in, 4096)) { 
				fwrite($out, $buff); 
			} 
			@fclose($in); 
			@unlink("{$filePath}_{$index}.part"); 
		} 
		flock($out, LOCK_UN); 
	} 
	@fclose($out);
	//video
	$add['name'] = $video_name;
	$add['filepath'] = $uploadPath;
	$add['addtime'] = time();

	$ff = new ffmpeg();
	$format = $ff->format($uploadPath);
	if(empty($format['size']) || empty($format['duration'])){
		unlink($uploadPath);
		getjson('ffmpeg error');
	}
	$add['duration'] = $format['duration'];
	$add['size'] = $format['size'];
	$add['vid'] = substr(md5(time().rand(1111,9999)),10,-10);

	//返回数据
	$ok['msg'] = '视频上传完成';
	$ok['did'] = get_api($add);
	getjson($ok,1);
}

//json输出
function getjson($arr,$code=0,$callback='') {
	if(!is_array($arr)){
		$data['msg'] = $arr;
	}else{
		$data = $arr;
	}
	$data['code'] = $code;
	$json = json_encode($data);
	if(!empty($callback)){
		echo $callback."(".$json.")";
	}else{
		echo $json;
	}
	exit;
}
//递归创建文件夹
function mkdirss($dir) {
    if (!$dir) {
        return FALSE;
    }
    if (!is_dir($dir)) {
        mkdirss(dirname($dir));
        if (!file_exists($dir)) {
            mkdir($dir, 0777);
        }
    }
    return true;
}
//访问api
function get_api($params = array()) {
	$params['fid'] = Web_ID;
	$params['key'] = Api_Key;
	$apiurl = Web_Url.'index.php/ajax/api/add?'.http_build_query($params);
	$did = (int)file_get_contents($apiurl);
	return $did;
}
//字符加密、解密
function sys_auth($string, $type = 1, $key = '', $expiry = 0) { 
	if($type == 1) $string = str_replace('-','+',$string);
	$ckey_length = 4;
	$key = md5($key ? $key : Api_Key);   
	$keya = md5(substr($key, 0, 16));     
	$keyb = md5(substr($key, 16, 16));     
	$keyc = $ckey_length ? ($type == 1 ? substr($string, 0, $ckey_length): substr(md5(microtime()), -$ckey_length)) : ''; 
	$cryptkey = $keya.md5($keya.$keyc);   
	$key_length = strlen($cryptkey);     
	$string = $type == 1 ? base64_decode(substr($string, $ckey_length)) :  sprintf('%010d', $expiry ? $expiry + time() : 0).substr(md5($string.$keyb), 0, 16).$string;   
	$string_length = strlen($string);   
	$result = '';   
	$box = range(0, 255);   
	$rndkey = array();     
	for($i = 0; $i <= 255; $i++) {   
		$rndkey[$i] = ord($cryptkey[$i % $key_length]);   
	}     
	for($j = $i = 0; $i < 256; $i++) {   
		$j = ($j + $box[$i] + $rndkey[$i]) % 256;   
		$tmp = $box[$i];   
		$box[$i] = $box[$j];   
		$box[$j] = $tmp;   
	}   
	for($a = $j = $i = 0; $i < $string_length; $i++) {   
		$a = ($a + 1) % 256;   
		$j = ($j + $box[$a]) % 256;   
		$tmp = $box[$a];   
		$box[$a] = $box[$j];   
		$box[$j] = $tmp;   
		$result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));   
	}   
	if($type == 1) {    
		if((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16)) {   
			return substr($result, 26);   
		} else {   
			return '';   
		}   
	} else {    
		return str_replace('+', '-', $keyc.str_replace('=', '', base64_encode($result)));   
	}
}