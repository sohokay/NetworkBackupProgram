<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//会员列表
	public function index(){
		$page = (int)$this->input->get_post('page');
		$zt = (int)$this->input->get_post('zt');
		$zd = $this->input->get_post('zd',true);
		$key = $this->input->get_post('key',true);
		$kstime = $this->input->get_post('kstime',true);
		$jstime = $this->input->get_post('jstime',true);
		if($page == 0) $page = 1;
		$where = $like = array();

		if($zt > 0) $where['zt'] = $zt-1;
		if(!empty($key)){
			if($zd == 'id'){
				$where[$zd] = (int)$key;
			}else{
				$like[$zd] = $key;
			}
		}
		if(!empty($kstime)) $where['addtime>'] = strtotime($kstime)-1;
		if(!empty($jstime)) $where['addtime<'] = strtotime($kstime)+1;

		$data['zt'] = $zt;
		$data['zd'] = $zd;
		$data['key'] = $key;
		$data['kstime'] = $kstime;
		$data['jstime'] = $jstime;

		//每页数量
		$per_page = 20;
		$total = $this->csdb->get_nums('user',$where,$like);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['user'] = $this->csdb->get_select('user','*',$where,'addtime DESC',$limit,$like);
        $base_url = site_url('user')."?zt=".$zt."&zd=".$zd."&key=".urlencode($key)."&kstime=".$kstime."&jstime=".$jstime."&page=";
        $data['page_data'] = page_data($total,$page,$pagejs); //获取分页类
        $data['page_list'] = admin_page($base_url,$page,$pagejs); //获取分页类
        $this->load->view('user.tpl',$data);
	}

	//修改
	public function edit($id=0){
		$id = intval($id);
		if($id == 0){
			exit('会员不存在~');
		}
		$data['user'] = $this->csdb->get_row('user','*',array('id'=>$id));
		$this->load->view('user_edit.tpl',$data);
	}

	//入库
	public function save($id=0){
		$id = intval($id);
		if($id==0) getjson('会员ID为空');
		$pass = $this->input->post('pass',true);
		$data['name'] = $this->input->post('name',true);
		$data['qq'] = $this->input->post('qq',true);
		$data['email'] = $this->input->post('email',true);
		$data['url'] = $this->input->post('url',true);
		$data['zt'] = (int)$this->input->post('zt',true);
		if(!empty($pass)) $data['pass'] = md5($pass);
		if(empty($data['name'])) getjson('账号不能为空');
		$this->db->update("user",$data,array('id'=>$id));
		getjson('会员修改操作完成',1);
	}

	//删除
	public function del(){
		$ids = $this->input->get_post('id');
		if(is_array($ids)){
			array_unique($ids);
			$ids = array_merge($ids);
			if(sizeof($ids)<1) getjson('请选择要删除的会员');
			foreach ($ids as $key => $value) {
				$id = intval($value);
				if($id<1) continue;
				$this->db->delete('user',array('id'=>$id));
			}
		}else{
			$id = intval($ids);
			$this->db->delete('user',array('id'=>$id));
		}
		$info['msg'] = '操作完成';
		$info['url'] = site_url('user')."?v=".rand(0,999);
		getjson($info,1);
	}
}