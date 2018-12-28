<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Ting extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
	}

	public function index(){
		$id = (int)$this->input->get_post('id');
		if($id == 0){
			$row = $this->csdb->get_row('vod','*',array('zt'=>0),'id ASC');
			if(!$row) exit('暂时没有需要转码的视频');
		}else{
			$row = $this->csdb->get_row('vod','*',array('id'=>$id));
			if(!$row) exit('视频不存在');
			if($row->zt > 1) exit('视频已转码');
			if($row->zt == 1) exit('视频转码中...');
		}
		$zmnum = 10;
		if($row->fid > 0){
			$rows = $this->csdb->get_row('server','*',array('id'=>$row->fid));
			if($rows) $zmnum = $rows->zmnum;
		}
		//判断转码进程数量
		$num = $this->csdb->get_nums('vod',array('fid'=>$row->fid,'zt'=>1));
		if($num >= $zmnum){
			exit('转码进程已上限，请稍后...');
		}
		if($row->fid > 0){
			//修改转码时间
			$this->csdb->get_update('vod',$row->id,array('zt'=>1,'zmtime'=>time()));
			//开始转码
			get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码开始');
			$post['filepath'] = $row->filepath;
			$post['vid'] = $row->vid;
			$post['id'] = $row->id;
			$post['addtime'] = $row->addtime;
			$apiurl = $rows->apiurl.'api.php?ac=zm&key='.$rows->apikey;
			echo geturl($apiurl,$post);
		}else{
			//文件路径
			$mp4file = $row->filepath;
			$m3u8path = m3u8_dir($row->vid,$row->addtime);
			//创建文件夹
			mkdirss($m3u8path);
			//修改转码时间
			$this->csdb->get_update('vod',$row->id,array('zt'=>1,'zmtime'=>time()));
			//开始转码
			get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码开始');
			$this->load->library('ffmpeg');
			$res = $this->ffmpeg->transcode($mp4file,$m3u8path);
			//修改转码状态
			if($res == 'm3u8ok'){
				$this->csdb->get_update('vod',$row->id,array('zt'=>2));
				get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码完成');
				echo '视频ID：'.$row->id.'--->转码完成';
			}else{
				$this->csdb->get_update('vod',$row->id,array('zt'=>3));
				get_log(date('Y-m-d H:i:s').'：视频：'.$row->name.'--->转码失败');
				echo '视频ID：'.$row->id.'--->转码失败';
			}
		}
	}
}