<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Lists extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//视频分类列表
	public function index($op='xt'){
		$page = (int)$this->input->get_post('page');
		$uid = (int)$this->input->get_post('uid');
		if($page == 0) $page = 1;
		$per_page = 20;
		$where = array();
		$table = $op=='my' ? 'myclass' : 'class';

		if($op=='my' && $uid > 0){
			$where['uid'] = $uid;
		}

		$total = $this->csdb->get_nums($table,$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vlist'] = $this->csdb->get_select($table,'*',$where,'id DESC',$limit);
        $base_url = site_url('lists/index/'.$op)."?uid=".$uid."&page=";
        $data['page_data'] = page_data($total,$page,$pagejs); //获取分页类
        $data['page_list'] = admin_page($base_url,$page,$pagejs); //获取分页类
        $data['uid'] = $uid;
        $data['op'] = $op;
        $data['table'] = $table;
        $this->load->view('list.tpl',$data);
	}

	//新增修改
	public function edit($op='xt',$id=0){
		$table = $op=='my' ? 'myclass' : 'class';
		$id = intval($id);
		if($id > 0){
			$vod = $this->csdb->get_row($table,'*',array('id'=>$id));
			$data['name'] = $vod->name;
			$data['xid'] = $vod->xid;
			$data['fid'] = $vod->fid;
			$data['id'] = $vod->id;
		}else{
			$data['name'] = '';
			$data['xid'] = 10;
			$data['fid'] = 0;
			$data['id'] = 0;
		}
		$data['op'] = $op;
		$this->load->view('list_edit.tpl',$data);
	}

	//入库
	public function save($op='xt',$id=0){
		$table = $op=='my' ? 'myclass' : 'class';
		$id = intval($id);
		$data['name'] = $this->input->post('name',true);
		$data['xid'] = (int)$this->input->post('xid',true);
		$data['fid'] = (int)$this->input->post('fid',true);
		if(empty($data['name'])) getjson('分类名字不能为空');
		if($id == 0){
			$this->db->insert($table,$data);
		}else{
			$this->db->update($table,$data,array('id'=>$id));
		}
		getjson('分类操作完成',1);
	}

	//删除分类
	public function del($op=''){
		$table = $op=='my' ? 'myclass' : 'class';
		$ids = $this->input->get_post('id');
		if(is_array($ids)){
			array_unique($ids);
			$ids = array_merge($ids);
			if(sizeof($ids)<1) getjson('请选择要删除的文件');
			foreach ($ids as $key => $value) {
				$id = intval($value);
				if($id<1) continue;
				$this->db->delete($table,array('id'=>$id));
			}
		}else{
			$id = intval($ids);
			$this->db->delete($table,array('id'=>$id));
		}
		$info['msg'] = '操作完成';
		$info['url'] = site_url('lists/index/'.$op)."?v=".rand(0,999);
		getjson($info,1);
	}
}