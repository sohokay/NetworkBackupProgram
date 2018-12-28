<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {

	public function __construct(){
		parent::__construct();
        //当前模版
		$this->load->get_templates();
	}

	//后台登录
    public function index() {
		$data['title'] = '后台登录 - '.Web_Name;
        $this->load->view('login.tpl',$data);
	}

	//登录
	public function save(){
		$adminname = $this->input->get_post('adminname',true);
		$adminpass = $this->input->get_post('adminpass',true);
		if(empty($adminname) || empty($adminpass)){
			getjson('账号密码不能留空');
		}
		$row = $this->csdb->get_row('admin','*',array('name'=>$adminname));
		if(!$row){
			getjson('账号不正确');
		}
		if(md5($adminpass) != $row->pass){
			getjson('密码不正确');
		}
		//更新登录信息
		$this->csdb->get_update('admin',$row->id,array('logip'=>getip(),'logtime'=>time()));
        //写入COOKIE
        $cookietime = time()+7200;
        $this->cookie->set('admin_id',$row->id,$cookietime);
        $this->cookie->set('admin_nichen',$row->nichen,$cookietime);
        $this->cookie->set('admin_logip',$row->logip,$cookietime);
        $this->cookie->set('admin_logtime',$row->logtime,$cookietime);
        $this->cookie->set('admin_login',md5($row->id.$row->name.$row->pass),$cookietime);
        $info['url'] = links('index');
		$info['msg'] = '登录成功';
        getjson($info,1);
	}

	//退出
	public function ext(){
        //写入COOKIE
        $this->cookie->set('admin_id');
        $this->cookie->set('admin_nichen');
        $this->cookie->set('admin_logip');
        $this->cookie->set('admin_logtime');
        $this->cookie->set('admin_login');
        header("location:".links('login'));exit;
	}
}

