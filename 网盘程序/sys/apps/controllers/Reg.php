<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Reg extends CI_Controller {
	function __construct(){
	    parent::__construct();
        //当前模版
		$this->load->get_templates();
	}

	public function index(){
        $this->load->view('reg.tpl');
	}

	public function save(){
        $name = $this->input->post('name',true);
        $pass = $this->input->post('pass',true);
        $repass = $this->input->post('repass',true);
        $email = $this->input->post('email',true);
        $code = $this->input->post('code',true);
        if(empty($name) || empty($pass) || empty($email) || empty($code)){
        	getjson('信息不完整');
        }
        if($this->cookie->get('codes') != strtolower($code)){
        	getjson('验证码不正确');
        }
        if($pass != $repass){
        	getjson('两次密码不一致');
        }
        $row = $this->csdb->get_row('user','id',array('name'=>$name));
        if($row) getjson('账号已注册');
        $row = $this->csdb->get_row('user','id',array('email'=>$email));
        if($row) getjson('邮箱已注册');
        //入库
        $add['name'] = $name;
        $add['pass'] = md5($pass);
        $add['email'] = $email;
        $add['zt'] = Web_Reg;
        $add['addtime'] = time();
        $res = $this->csdb->get_insert('user',$add);
        if(!$res) getjson('注册失败，稍后再试');
        //写入登录记录
        $this->load->library('user_agent');
        $agent = ($this->agent->is_mobile() ? $this->agent->mobile() : $this->agent->platform()).'&nbsp;/&nbsp;'.$this->agent->browser().' v'.$this->agent->version();
        $add2['uid'] = $res;
        $add2['ip'] = getip();
        $add2['addtime'] = time();
        $add2['info'] = $agent;
        $this->csdb->get_insert('user_log',$add2);

        //成功
        $time = time()+86400*15;
        $this->cookie->set('user_id',$res,$time);
        $this->cookie->set('user_login',md5($res.$name.md5($pass)),$time);
        $this->cookie->set('codes');
        getjson(array('msg'=>'注册成功，请稍后...','url'=>links('vod')),1);
	}
}