<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Play extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //当前模版
		$this->load->get_templates();
	}

	public function index($vid=''){
		$vid = safe_replace($vid);
		if(empty($vid)) exit('视频vid为空');
		$row = $this->csdb->get_row('vod','*',array('vid'=>$vid));
		if(!$row) exit('视频不存在');
		if($row->zt == 0) exit('视频未转码');
		if($row->zt == 1) exit('视频转码中...');
		if($row->zt == 3) exit('视频转码失败，无法播放');
		$rows = array();
        if($row->fid > 0){
            $rows = $this->csdb->get_row_arr('server','*',array('id'=>$row->fid));
        }
		
		//文件路径
		$data['m3u8url'] = m3u8_link($row->vid,$row->addtime,'m3u8',1,$rows);
		$data['picurl'] = m3u8_link($row->vid,$row->addtime,'pic',1,$rows);
		$data['title'] = $row->name.'在线播放';
		$this->load->view('play.tpl',$data);
	}
}