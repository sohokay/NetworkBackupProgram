<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Sys extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//管理员列表
	public function index(){
		//数据
        $data['admin'] = $this->csdb->get_select('admin','*',array(),'id DESC',100);
        $this->load->view('sys.tpl',$data);
	}

	//修改
	public function edit($id=0){
		$id = intval($id);
		if($id == 0){
			$data['name'] = '';
			$data['nichen'] = '';
		}else{
			$row = $this->csdb->get_row('admin','*',array('id'=>$id));
			if(!$row) exit('账号不存在');
			$data['name'] = $row->name;
			$data['nichen'] = $row->nichen;
		}
		$data['id'] = $id;
		$this->load->view('sys_edit.tpl',$data);
	}

	//入库
	public function save($id=0){
		$id = intval($id);
		$name = $this->input->post('name',true);
		$pass = $this->input->post('pass',true);
		$nichen = $this->input->post('nichen',true);
		$data['name'] = $name;
		$data['nichen'] = $nichen;
		if($id==0){
			if(empty($name) || empty($pass)) getjson('账号、密码不能为空');
			$data['pass'] = md5($pass);
			$this->db->insert('admin',$data);
		}else{
			if(!empty($pass)) $data['pass'] = md5($pass);
			$this->db->update("admin",$data,array('id'=>$id));
		}
		getjson('数据操作完成',1);
	}

	//删除
	public function del(){
		$ids = $this->input->get_post('id');
		if(is_array($ids)){
			array_unique($ids);
			$ids = array_merge($ids);
			if(sizeof($ids)<1) getjson('请选择要删除的账号');
			foreach ($ids as $key => $value) {
				$id = intval($value);
				if($id<1 || $id == $this->cookie->get('admin_id')) continue;
				$this->db->delete('admin',array('id'=>$id));
			}
		}else{
			$id = intval($ids);
			if($id == $this->cookie->get('admin_id')){
				getjson('不能删除自己');
			}
			$this->db->delete('admin',array('id'=>$id));
		}
		$info['msg'] = '操作完成';
		$info['url'] = site_url('sys')."?v=".rand(0,999);
		getjson($info,1);
	}
}