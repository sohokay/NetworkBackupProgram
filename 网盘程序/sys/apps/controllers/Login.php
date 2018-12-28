<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Login extends CI_Controller {
	function __construct(){
	    parent::__construct();
        //当前模版
		$this->load->get_templates();
	}

	public function index(){
        $this->load->view('login.tpl');
	}

	public function save(){
        $name = $this->input->post('name',true);
        $pass = $this->input->post('pass',true);
        $code = $this->input->post('code',true);
        if(empty($name) || empty($pass) || empty($code)){
        	getjson('信息不完整');
        }
        if($this->cookie->get('codes') != strtolower($code)){
        	getjson('验证码不正确');
        }
        $row = $this->csdb->get_row('user','*',array('name'=>$name));
        if(!$row) getjson('会员不存在');
        if($row->pass != md5($pass)) getjson('密码不正确');
        //写入登录记录
        $this->load->library('user_agent');
        $agent = ($this->agent->is_mobile() ? $this->agent->mobile() : $this->agent->platform()).'&nbsp;/&nbsp;'.$this->agent->browser().' v'.$this->agent->version();
        $add['uid'] = $row->id;
        $add['ip'] = getip();
        $add['addtime'] = time();
        $add['info'] = $agent;
        $this->csdb->get_insert('user_log',$add);
        //成功
        $time = time()+86400*15;
        $this->cookie->set('user_id',$row->id,$time);
        $this->cookie->set('user_login',md5($row->id.$row->name.$row->pass),$time);
        $this->cookie->set('codes');
        getjson(array('msg'=>'登录成功，请稍后...','url'=>links('vod')),1);
	}

    //退出
    public function ext(){
        //写入COOKIE
        $this->cookie->set('user_id');
        $this->cookie->set('user_login');
        header("location:".links('login'));
        exit;
    }
}