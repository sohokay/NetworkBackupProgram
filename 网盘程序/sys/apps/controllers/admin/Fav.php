<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Fav extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//视频收藏列表
	public function index(){
		$page = (int)$this->input->get_post('page');
		$cid = (int)$this->input->get_post('cid');
		$did = (int)$this->input->get_post('did');
		$kstime = $this->input->get_post('kstime',true);
		$jstime = $this->input->get_post('jstime',true);
		if($page == 0) $page = 1;
		$where = array();

		if($cid > 0) $where['cid'] = $cid;
		if($did > 0) $where['did'] = $did;
		if(!empty($kstime)) $where['addtime>'] = strtotime($kstime)-1;
		if(!empty($jstime)) $where['addtime<'] = strtotime($kstime)+1;

		$data['cid'] = $cid;
		$data['did'] = $did;
		$data['kstime'] = $kstime;
		$data['jstime'] = $jstime;

		//每页数量
		$per_page = 20;
		$total = $this->csdb->get_nums('fav',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('fav','*',$where,'addtime DESC',$limit);
        $base_url = site_url('fav')."?cid=".$cid."&did=".$did."&kstime=".$kstime."&jstime=".$jstime."&page=";
        $data['page_data'] = page_data($total,$page,$pagejs); //获取分页类
        $data['page_list'] = admin_page($base_url,$page,$pagejs); //获取分页类
        $data['vlist'] = $this->csdb->get_select('class','*',array(),'id DESC',100);
        $this->load->view('fav.tpl',$data);
	}

	//删除
	public function del(){
		$ids = $this->input->get_post('id');
		if(is_array($ids)){
			array_unique($ids);
			$ids = array_merge($ids);
			if(sizeof($ids)<1) getjson('请选择要删除的文件');
			foreach ($ids as $key => $value) {
				$id = intval($value);
				if($id<1) continue;
				$this->db->delete('fav',array('id'=>$id));
			}
		}else{
			$id = intval($ids);
			$this->db->delete('fav',array('id'=>$id));
		}
		$info['msg'] = '操作完成';
		$info['url'] = site_url('fav')."?v=".rand(0,999);
		getjson($info,1);
	}
}