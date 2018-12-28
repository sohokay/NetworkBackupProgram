<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Ajax extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
	}
	//收藏视频
	public function fav($id=0){
		$id = (int)$id;
		if($id == 0) getjson('视频ID不能为空');
		if(!$this->user->login(1)) getjson('登录超时，请先登录');
		$row = $this->csdb->get_row('vod','cid',array('id'=>$id));
		if(!$row) getjson('视频不存在');
		$row2 = $this->csdb->get_row('fav','id',array('did'=>$id,'uid'=>$this->cookie->get('user_id')));
		if($row2) getjson('该视频已经收藏过了');

		$add['did'] = $id;
		$add['cid'] = $row->cid;
		$add['uid'] = $this->cookie->get('user_id');
		$add['addtime'] = time();
		$this->csdb->get_insert('fav',$add);
		getjson('视频收藏成功',1);
	}

	//删除收藏
	public function delfav($id=0){
		$id = (int)$id;
		if($id == 0) getjson('视频ID不能为空');
		if(!$this->user->login(1)) getjson('登录超时，请先登录');
		$row2 = $this->csdb->get_row('fav','id',array('id'=>$id,'uid'=>$this->cookie->get('user_id')));
		if(!$row2) getjson('该记录不存在');
		$this->db->delete('fav',array('id'=>$id));
		getjson('取消收藏成功',1);
	}

	//转码异常视频
	public function err(){
		//转码3小时未完成则设置为失败
		$time = time()-7200;
		$res = $this->csdb->get_select('vod','*',array('zt'=>1,'zmtime<'=>$time),'id ASC',100);
		foreach($res as $row){
			$this->csdb->get_update('vod',$row->id,array('zt'=>3));
		}
	}

	//执行未转码视频
	public function zm(){
		$xt = php_uname();
		if(strpos($xt, 'Windows') !== false){
			$jc = shell_exec('tasklist');
		}else{
			$jc = shell_exec('ps aux | less');
		}
		//判断转码进程数量
		$zmcount = substr_count($jc,'ffmpeg');
		if($zmcount > 9){
			exit();
		}
		$num = 10-$zmcount;
		$res = $this->csdb->get_select('vod','id',array('zt'=>0),'id ASC',$num);
		foreach($res as $row){
			$res = file_get_contents('http://'.Web_Zm_Url.Web_Path.'index.php/ting?id='.$row->id);
		}
	}

	//api
	public function api($ac){
		//新增记录
		if($ac == 'add'){
			$key = $this->input->get_post('key',true);
			$fid = (int)$this->input->get_post('fid',true);
			$row = $this->csdb->get_row('server','size,apikey',array('id'=>$fid));
			if(!$row || $row->apikey != $key) exit('0');
			unset($_GET['key']);
			$did = $this->csdb->get_insert("vod",$_GET);
			if($did){
				//修改容量
				$this->csdb->get_update('server',$fid,array('size'=>($row->size+$_GET['size'])));
			}
			echo $did;

		}elseif($ac == 'zm'){ //转码状态
			$key = $this->input->get_post('key',true);
			$id = (int)$this->input->get_post('id',true);
			$zt = (int)$this->input->get_post('zt',true);
			if($zt > 3) $zt = 3;
			if($id > 0){
				$row = $this->csdb->get_row('vod','fid,name',array('id'=>$id));
				$rows = $this->csdb->get_row('server','size,apikey',array('id'=>$row->fid));
				if(!$rows || $rows->apikey != $key) exit('0');
				if($zt == 2){
					get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码完成');
				}else{
					get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码失败');
				}
				$this->csdb->get_update('vod',$id,array('zt'=>$zt));
			}
		}
	}
}