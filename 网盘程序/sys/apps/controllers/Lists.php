<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Lists extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //判断登陆
		$this->user->login();
        //当前模版
		$this->load->get_templates();
	}

	//我的分类
	public function index(){
		$data['title'] = '我的分类 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));

		$where = array('fid'=>0,'uid'=>$user->id);
		//数据
        $data['myclass'] = $this->csdb->get_select('myclass','*',$where,'id ASC',100);
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
        $this->load->view('head.tpl',$data);
        $this->load->view('list.tpl');
        $this->load->view('bottom.tpl');
	}

	//新增、修改分类
	public function edit($id=0){
		$data['title'] = '分类操作 - '.Web_Name;
		$id = (int)$id;
		if($id == 0){
			$data['name'] = '';
			$data['fid'] = 0;
		}else{
			$row = $this->csdb->get_row('myclass','*',array('id'=>$id,'uid'=>$this->cookie->get('user_id')));
			if(!$row) exit('分类不存在');
			$data['name'] = $row->name;
			$data['fid'] = $row->fid;
		}
		$data['id'] = $id;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$data['user'] = $user;
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['myclass'] = $this->csdb->get_select('myclass','*',array('uid'=>$user->id,'fid'=>0),'id ASC',50);
        $this->load->view('head.tpl',$data);
        $this->load->view('list_edit.tpl');
        $this->load->view('bottom.tpl');
	}

	//新增、修改入库
	public function save($id=0){
		$id = (int)$id;
		$data['name'] = $this->input->post('name',true);
		$data['fid'] = (int)$this->input->post('fid',true);
		if(empty($data['name'])) getjson('分类名称不能为空');
		if($id == 0){
			$data['uid'] = $this->cookie->get('user_id');
			$this->csdb->get_insert('myclass',$data);
		}else{
			$row = $this->csdb->get_row('myclass','id',array('id'=>$id,'uid'=>$this->cookie->get('user_id')));
			if(!$row) getjson('分类不存在');
			$this->db->update("myclass",$data,array('id'=>$id));
		}
		getjson(array('msg'=>'分类操作成功','url'=>links('lists')),1);
	}

	//分类视频
	public function vod($cid=0){
		$data['title'] = '分类视频 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$page = (int)$this->input->get('page');
		$cid = (int)$cid;
		$class = $this->csdb->get_row('myclass','*',array('id'=>$cid,'uid'=>$this->cookie->get('user_id')));
		if(!$class) exit('分类不存在');
		if($class->fid == 0) $cid = getcid($cid);
		if($page == 0) $page = 1;
		$where = array();
		$where['uid'] = $user->id;
		if(!empty($cid)) $where['mycid'] = $cid;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('vod',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('vod','*',$where,'addtime DESC',$limit);
        $data['pages'] = get_page($total,$pagejs,$page,'lists','vod',$cid);
		$data['user'] = $user;
		$data['cid'] = $cid;
		$data['list'] = $class;
		$data['nums'] = $total;
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
        $this->load->view('head.tpl',$data);
        $this->load->view('list_vod.tpl');
        $this->load->view('bottom.tpl');
	}
}