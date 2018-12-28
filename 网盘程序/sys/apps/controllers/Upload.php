<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Upload extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //当前模版
		$this->load->get_templates();
	}

	public function index(){
		//判断登陆
		$this->user->login();
		$cid = (int)$this->input->get_post('cid');
		$mycid = (int)$this->input->get_post('mycid');
		$fid = (int)$this->input->get_post('fid');
		$apikey = '';
		if($fid > 0){
			$rows = $this->csdb->get_row('server','*',array('id'=>$fid));
			if(!$rows) exit('该服务器不存在~');
			if($rows->zsize < $rows->size) exit('该服务器硬盘已满，请选择其他服务器');
			$data['saveurl'] = $rows->apiurl.'upload.php';
			$apikey = $rows->apikey;
		}else{
			$data['saveurl'] = links('upload','save');
		}
		$data['title'] = '上传视频 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
        $data['myclass'] = $this->csdb->get_select('myclass','*',array('uid'=>$user->id,'fid'=>0),'id ASC',30);
        $data['server'] = $this->csdb->get_select('server','*',array(),'id ASC',100);
		$data['user'] = $user;
		$row = $this->csdb->get_row('myclass','id',array('id'=>$mycid,'uid'=>$this->cookie->get('user_id')));
		if(!$row) $mycid = 0;
		$row = $this->csdb->get_row('class','id',array('id'=>$cid));
		if(!$row) $cid = 0;
		$data['cid'] = $cid;
		$data['fid'] = $fid;
		$data['mycid'] = $mycid;

		$str['cid'] = $cid;
		$str['mycid'] = $mycid;
		$str['id'] = $this->cookie->get('user_id');
		$str['login'] = md5($user->id.$user->name.$user->pass);
        $key = sys_auth(json_encode($str),0,$apikey);

		$data['key'] = $key;
        $this->load->view('head.tpl',$data);
        $this->load->view('upload.tpl');
        $this->load->view('bottom.tpl');
	}

	public function save($cid=0,$mycid=0){
		set_time_limit(0);
		$key = $this->input->get_post('key');
		$login = $this->user->login(1,$key);
		if(!$login) getjson('登录超时，请重新登录');
		$arr = json_decode(sys_auth($key,1),1);
		$add['uid'] = $arr['id'];
		$add['cid'] = $arr['cid'];
		$add['mycid'] = $arr['mycid'];

		if(substr(Up_Dir,0,2) == './'){
			$Video_Path = FCPATH.substr(Up_Dir,2);
		}else{
			$Video_Path = Up_Dir;
		}
		//分片文件夹
		$targetDir = $Video_Path.'/temp/'.date('Ymd').'/';
		//保存盘符路径
		$uploadDir = $Video_Path.'/'.date('Ym').'/'.date('d').'/';
		$uploadStr = date('Ym').'/'.date('d').'/';
		//定义允许上传的文件扩展名
		$ext_arr = array_filter(explode('|', Up_Ext));
		//防止外部跨站提交
		if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') { 
			getjson('提交方式不正确');
		}
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
			getjson('No FILES');
		}
		$file_name = $_FILES['video']['name'];
		//文件后缀
		$file_ext = strtolower(trim(substr(strrchr($file_name, '.'), 1)));
		$newname = iconv("UTF-8","GBK//IGNORE",$file_name);
		$video_name = safe_replace(str_replace('.'.$file_ext, '', $file_name));
		//判断文件后缀
		if(in_array($file_ext, $ext_arr) == false)  getjson("不支持的视频格式");
		//判断歌曲是否存在
		$res = $this->csdb->get_row('vod','id',array('name'=>$video_name,'uid'=>$add['uid']));
		if($res) getjson("视频已经存在，不用重复上传");
		//根据文件名和会员ID生成一个唯一MD5
		$fileName = md5($file_name.$add['uid']).'.'.$file_ext;
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
			$this->load->library('ffmpeg');
			$format = $this->ffmpeg->format($uploadPath);
			if(empty($format['size']) || empty($format['duration'])){
				unlink($uploadPath);
				getjson('ffmpeg error'); 
			}
			$add['duration'] = $format['duration'];
			$add['size'] = $format['size'];
			$add['vid'] = get_vid(rand(1111,9999));
			$did = $this->csdb->get_insert("vod",$add);
        	//返回数据
        	$ok['msg'] = '视频上传完成';
        	$ok['did'] = $did;
        	getjson($ok,1);
		}
	}
}