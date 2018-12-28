<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Index extends CI_Controller {

	public function __construct(){
		parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//后台首页
    public function index() {
    	$id = (int)$this->cookie->get('admin_id');
		$admin = $this->csdb->get_row('admin','*',array('id'=>$id));
		$data['title'] = '后台首页 - '.Web_Name;
		$data['admin'] = $admin;
        $this->load->view('index.tpl',$data);
	}

    public function main() {
    	$data['logip'] = $this->cookie->get('admin_logip');
    	$data['admin'] = $this->cookie->get('admin_nichen');
    	$data['logtime'] = $this->cookie->get('admin_logtime');
    	//视频统计
    	$jtime = strtotime(date('Y-m-d'))-1;
    	$data['jcount'] = $this->csdb->get_nums('vod',array('addtime>'=>$jtime));
    	//昨天
    	$jtime = strtotime(date('Y-m-d'));
    	$ztime = strtotime(date('Y-m-d'))-86401;
    	$data['zcount'] = $this->csdb->get_nums('vod',array('addtime>'=>$ztime,'addtime<'=>$jtime));
    	//本月
    	$jtime = strtotime(date('Y-m-1'))-1;
    	$data['bcount'] = $this->csdb->get_nums('vod',array('addtime>'=>$jtime));
    	//上月
    	$time = strtotime('-1 month');
    	$jtime = strtotime(date('Y-m-1',$time));
    	$ztime = strtotime(date('Y-m-1'));
    	$data['scount'] = $this->csdb->get_nums('vod',array('addtime>'=>$ztime,'addtime<'=>$jtime));
    	//总数
    	$data['count'] = $this->csdb->get_nums('vod');
    	//待转码
    	$data['dzcount'] = $this->csdb->get_nums('vod',array('zt'=>0));
        $this->load->view('main.tpl',$data);
	}
}

