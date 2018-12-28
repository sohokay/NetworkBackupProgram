<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Info extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //判断登陆
		$this->user->login();
        //当前模版
		$this->load->get_templates();
	}

	//修改资料
	public function edit(){
		$data['title'] = '修改资料 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
        $this->load->view('head.tpl',$data);
        $this->load->view('info_edit.tpl');
        $this->load->view('bottom.tpl');
	}

	//修改密码
	public function pass(){
		$data['title'] = '修改密码 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
        $this->load->view('head.tpl',$data);
        $this->load->view('info_pass.tpl');
        $this->load->view('bottom.tpl');
	}

	//帮组文档
	public function help(){
		$data['title'] = '使用说明 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
        $this->load->view('head.tpl',$data);
        $this->load->view('info_help.tpl');
        $this->load->view('bottom.tpl');
	}

	//登录日志
	public function log(){
		$data['title'] = '登录日志 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
        $data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;

		$page = (int)$this->input->get('page');
		if($page == 0) $page = 1;
		$where = array();
		$where['uid'] = $user->id;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('user_log',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['log'] = $this->csdb->get_select('user_log','*',$where,'addtime DESC',$limit);
        $data['pages'] = get_page($total,$pagejs,$page,'info','log');

        $this->load->view('head.tpl',$data);
        $this->load->view('info_log.tpl');
        $this->load->view('bottom.tpl');
	}

	//新增、修改入库
	public function save($op='edit'){

		if($op == 'pass'){
			$pass1 = $this->input->post('pass1',true);
			$pass2 = $this->input->post('pass2',true);
			$pass3 = $this->input->post('pass3',true);
			if(empty($pass1) || empty($pass2)) getjson('数据不完整');
			if($pass2 != $pass3) getjson('两次密码不一致');
			$ypass = getzd('user','pass',$this->cookie->get('user_id'));
			if($ypass != md5($pass1)) getjson('原密码不正确');
			$edit['pass'] = md5($pass3);
		}else{
			$edit['email'] = $this->input->post('email',true);
			$edit['qq'] = $this->input->post('qq',true);
			$edit['url'] = $this->input->post('url',true);
			if(empty($edit['email']) || empty($edit['url'])) getjson('数据不完整');
		}
		$this->db->update("user",$edit,array('id'=>$this->cookie->get('user_id')));
		getjson(array('msg'=>'修改更新成功','url'=>links('info',$op)),1);
	}
}