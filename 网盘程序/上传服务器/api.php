<?php
error_reporting(0);
define('SELF', pathinfo(__FILE__, PATHINFO_BASENAME)); // 后台文件名
define('FCPATH', str_replace("\\", DIRECTORY_SEPARATOR, dirname(__FILE__).DIRECTORY_SEPARATOR)); // 网站根目录
require_once(FCPATH."config.php");
//写入API
if(isset($_GET['ac'])){
	if($_GET['key'] != Api_Key){
		exit('api key err');
	}
	//常量配置
	if($_GET['ac'] == 'set' && isset($_POST)){

		$strs = "<?php"."\r\n";
		foreach ($_POST as $key => $value) {
        	$strs .= "define('".$key."','".$value."');\r\n";
		}
		write_file(FCPATH.'config.php',$strs);

	}elseif($_GET['ac'] == 'zm'){ //执行转码

		require_once(FCPATH."ffmpeg.php");
		$ff = new ffmpeg();
		$mp4_path = $_POST['filepath'];
		$m3u8_path = Zm_Dir.date('Ym',$_POST['addtime']).'/'.date('d',$_POST['addtime']).'/'.$_POST['vid'].'/';
        if(substr($m3u8_path,0,2) == './') $m3u8_path = FCPATH.substr($m3u8_path,2);
		mkdirss($m3u8_path);
		$res = $ff->transcode($mp4_path,$m3u8_path);
		//修改转码状态
		if($res == 'm3u8ok'){
			$apiurl = Web_Url.'index.php/ajax/api/zm?id='.$_POST['id'].'&zt=2&key='.Api_Key;
		}else{
			$apiurl = Web_Url.'index.php/ajax/api/zm?id='.$_POST['id'].'&zt=3&key='.Api_Key;
		}
		file_get_contents($apiurl);

	}elseif($_GET['ac'] == 'del'){ //执行删除文件

		$mp4_path = $_POST['filepath'];
		$delmp4 = (int)$_POST['mp4'];
		$delm3u8 = (int)$_POST['m3u8'];
		$m3u8_path = Zm_Dir.date('Ym',$_POST['addtime']).'/'.date('d',$_POST['addtime']).'/'.$_POST['vid'].'/';
        if(substr($m3u8_path,0,2) == './') $m3u8_path = FCPATH.substr($m3u8_path,2);
        //删除源文件
		if($delmp4 == 1) unlink($mp4_path);
		//删除切片文件
		if($delm3u8 == 1) deldir($m3u8_path);
		
	}
}

//写文件
function write_file($path, $data, $mode = FOPEN_WRITE_CREATE_DESTRUCTIVE){
	if(!$fp = @fopen($path, $mode)){
		return FALSE;
	}
	flock($fp, LOCK_EX);
	fwrite($fp, $data);
	flock($fp, LOCK_UN);
	fclose($fp);
	return TRUE;
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
//删除目录和文件
function deldir($dir,$sid=1) {
	if(!is_dir($dir)){
		return true;
	}
	//先删除目录下的文件
	$dh=opendir($dir);
	while ($file=readdir($dh)) {
		if($file!="." && $file!="..") {
			$fullpath=$dir."/".$file;
			if(!is_dir($fullpath)) {
				@unlink($fullpath);
			} else {
				deldir($fullpath,$sid);
			}
		}
	}
	closedir($dh);
	//删除当前文件夹：
	if($sid==1){
		if(@rmdir($dir)) {
			return true;
		} else {
			return false;
		}
	}else{
		return true;
	}
}