<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Fav extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //判断登陆
		$this->user->login();
        //当前模版
		$this->load->get_templates();
	}

	//我的视频
	public function index($cid=0){
		$data['title'] = '我收藏的视频 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$page = (int)$this->input->get('page');
		$cid = (int)$cid;
		if($page == 0) $page = 1;
		$where = array();
		$where['uid'] = $user->id;
		if($cid > 0) $where['cid'] = $cid;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('fav',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('fav','*',$where,'addtime DESC',$limit);
        $data['pages'] = get_page($total,$pagejs,$page,'fav','index',$cid);
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
		$data['cid'] = $cid;
        $this->load->view('head.tpl',$data);
        $this->load->view('fav.tpl');
        $this->load->view('bottom.tpl');
	}
}