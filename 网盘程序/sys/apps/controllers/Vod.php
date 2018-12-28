<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Vod extends CI_Controller {
	function __construct(){
	    parent::__construct();
	    //加载会员模型
		$this->load->model('user');
        //判断登陆
		$this->user->login();
        //当前模版
		$this->load->get_templates();
	}

	//我的视频
	public function index($op='txt',$cid=0){
		$data['title'] = '我的视频 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$page = (int)$this->input->get('page');
		$cid = (int)$cid;
		if($page == 0) $page = 1;
		$where = array();
		$where['uid'] = $user->id;
		if($cid > 0) $where['cid'] = $cid;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('vod',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('vod','*',$where,'addtime DESC',$limit);
        $ops = $cid > 0 ? $op.'/'.$cid : $op;
        $data['pages'] = get_page($total,$pagejs,$page,'vod','index',$ops);
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['myclass'] = $this->csdb->get_select('myclass','*',array('uid'=>$user->id,'fid'=>0),'id ASC',15);
		$data['user'] = $user;
		$data['cid'] = $cid;
		$data['op'] = $op;
        $this->load->view('head.tpl',$data);
        if($op == 'pic'){
        	$this->load->view('vod_my_pic.tpl');
        }else{
        	$this->load->view('vod_my.tpl');
        }
        $this->load->view('bottom.tpl');
	}

	//广场视频
	public function square($op='txt',$cid=0){
		$data['title'] = '视频广场 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$page = (int)$this->input->get('page');
		$cid = (int)$cid;
		if($page == 0) $page = 1;
		$where = array();
		//$where['uid'] = $user->id;
		if($cid > 0) $where['cid'] = $cid;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('vod',$where);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('vod','*',$where,'addtime DESC',$limit);
        $ops = $cid > 0 ? $op.'/'.$cid : $op;
        $data['pages'] = get_page($total,$pagejs,$page,'vod','square',$ops);
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['user'] = $user;
		$data['cid'] = $cid;
		$data['op'] = $op;
        $this->load->view('head.tpl',$data);
        if($op == 'pic'){
        	$this->load->view('vod_square_pic.tpl');
        }else{
        	$this->load->view('vod_square.tpl');
        }
        $this->load->view('bottom.tpl');
	}

	//视频搜素
	public function search(){
		$data['title'] = '视频搜索 - '.Web_Name;
		$user = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		$page = (int)$this->input->get('page');
		$key = $this->input->get_post('key',true);;
		if($page == 0) $page = 1;
		$like = $where = array();
		if(!empty($key)) $like['name'] = $key;
		//每页数量
		$per_page = 15;
		$total = $this->csdb->get_nums('vod',$where,$like);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('vod','*',$where,'addtime DESC',$limit,$like);
        $data['pages'] = get_page($total,$pagejs,$page,'vod','search',0,'key='.urlencode($key));
		$data['user'] = $user;
		$data['key'] = $key;
		$data['nums'] = $total;
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
        $this->load->view('head.tpl',$data);
        $this->load->view('vod_search.tpl');
        $this->load->view('bottom.tpl');
	}

	//修改视频
	public function edit($id){
		$id = (int)$id;
		if($id == 0) exit('ID为空');
		$row = $this->csdb->get_row('vod','*',array('id'=>$id));
		if(!$row || $row->uid != $this->cookie->get('user_id')){
			exit('视频不存在');
		}
		$data['title'] = '修改视频 - '.Web_Name;
		$data['vod'] = $row;
		$data['class'] = $this->csdb->get_select('class','*',array(),'id ASC',30);
		$data['myclass'] = $this->csdb->get_select('myclass','*',array('uid'=>$row->uid,'fid'=>0),'id ASC',100);
		$data['user'] = $this->csdb->get_row('user','*',array('id'=>$this->cookie->get('user_id')));
		if($row->fid > 0){
			$data['server'] = $this->csdb->get_row_arr('server','*',array('id'=>$row->fid));
		}else{
			$data['server'] = array();
		}
		$this->load->view('head.tpl',$data);
        $this->load->view('vod_edit.tpl');
        $this->load->view('bottom.tpl');
	}

	//修改视频入库
	public function save($id){
		$id = (int)$id;
		if($id == 0) getjson('视频ID为空');
		$name = $this->input->post('name',true);
		$cid = (int)$this->input->post('cid',true);
		$mycid = (int)$this->input->post('mycid',true);
		if(empty($name)) getjson('视频标题不能为空');
		$row = $this->csdb->get_row('vod','uid',array('id'=>$id));
		if(!$row || $row->uid != $this->cookie->get('user_id')){
			getjson('视频不存在');
		}
		$edit['name'] = $name;
		$edit['cid'] = $cid;
		$edit['mycid'] = $mycid;
		$this->db->update("vod",$edit,array('id'=>$id));
		getjson(array('msg'=>'视频修改操作完成','url'=>links('vod','edit',$id)),1);
	}
}