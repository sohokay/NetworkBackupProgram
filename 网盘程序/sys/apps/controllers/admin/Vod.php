<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vod extends CI_Controller {
	function __construct(){
	    parent::__construct();
		//加载会员模型
		$this->load->model('admin');
        //判断登陆
		$this->admin->login();
        //当前模版
		$this->load->get_templates();
	}

	//视频列表
	public function index(){
		$page = (int)$this->input->get_post('page');
		$zt = (int)$this->input->get_post('zt');
		$cid = (int)$this->input->get_post('cid');
		$zd = $this->input->get_post('zd',true);
		$key = $this->input->get_post('key',true);
		$kstime = $this->input->get_post('kstime',true);
		$jstime = $this->input->get_post('jstime',true);
		if($page == 0) $page = 1;
		$where = $like = array();

		if($cid > 0) $where['cid'] = $cid;
		if($zt > 0) $where['zt'] = $zt-1;
		if(!empty($key)){
			if($zd == 'name'){
				$like['name'] = $key;
			}else{
				$where[$zd] = (int)$key;
			}
		}
		if(!empty($kstime)) $where['addtime>'] = strtotime($kstime)-1;
		if(!empty($jstime)) $where['addtime<'] = strtotime($kstime)+1;

		$data['zt'] = $zt;
		$data['cid'] = $cid;
		$data['zd'] = $zd;
		$data['key'] = $key;
		$data['kstime'] = $kstime;
		$data['jstime'] = $jstime;

		//每页数量
		$per_page = 20;
		$total = $this->csdb->get_nums('vod',$where,$like);
		$pagejs = ceil($total / $per_page); // 总页数
		if($pagejs == 0) $pagejs = 1;
		if($page > $pagejs) $page = $pagejs;
		$limit = array($per_page,$per_page*($page-1));
		//数据
        $data['vod'] = $this->csdb->get_select('vod','*',$where,'addtime DESC',$limit,$like);
        $base_url = site_url('vod')."?cid=".$cid."&zt=".$zt."&zd=".$zd."&key=".urlencode($key)."&kstime=".$kstime."&jstime=".$jstime."&page=";
        $data['page_data'] = page_data($total,$page,$pagejs); //获取分页类
        $data['page_list'] = admin_page($base_url,$page,$pagejs); //获取分页类
        $data['vlist'] = $this->csdb->get_select('class','*',array(),'id DESC',100);
        $this->load->view('vod.tpl',$data);
	}

	//详细
	public function show($id=0){
		$id = intval($id);
		if($id == 0) exit('视频不存在~');
		$vod = $this->csdb->get_row('vod','*',array('id'=>$id));
		$data['vod'] = $vod;
		$this->load->view('vod_show.tpl',$data);
	}

	//修改
	public function edit($id=0){
		$id = intval($id);
		if($id == 0){
			exit('视频不存在~');
		}
		$vod = $this->csdb->get_row('vod','*',array('id'=>$id));
		$data['vod'] = $vod;
		$data['vlist'] = $this->csdb->get_select('class','*',array(),'id DESC',100);
		$this->load->view('vod_edit.tpl',$data);
	}

	//入库
	public function save($id=0){
		$id = intval($id);
		if($id==0) getjson('视频ID为空');
		$data['name'] = $this->input->post('name',true);
		$data['cid'] = (int)$this->input->post('cid',true);
		$data['zt'] = (int)$this->input->post('zt',true);
		$data['filepath'] = $this->input->post('filepath',true);
		if(empty($data['name']) || empty($data['filepath'])) getjson('数据不完整');
		$this->db->update("vod",$data,array('id'=>$id));
		getjson('视频修改操作完成',1);
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
				$row = $this->csdb->get_row('vod','*',array('id'=>$id));
				if($row){
					$res = $this->db->delete('vod',array('id'=>$id));
					if($res){
						//删除收藏
						$this->db->delete('fav',array('did'=>$id));
						//删除原文件
						if(Del_Mp4 == 1){
							unlink($row->filepath);
						}
						//删除切片文件
						if(Del_M3u8 == 1){
							deldir(m3u8_dir($row->vid,$row->addtime),1);
						}
					}
					//减去硬盘容量
					if($row->fid > 0){
						$rows = $this->csdb->get_row('server','size',array('id'=>$row->fid));
						$this->csdb->get_update('server',$row->fid,array('size'=>($rows->size-$row->size)));
						//删除远程服务器文件
						if(Del_Mp4 == 1 || Del_M3u8 == 1){
							$apiurl = $rows->apiurl.'api.php?ac=del&key='.$rows->apikey;
							$post['m3u8'] = Del_M3u8;
							$post['mp4'] = Del_Mp4;
							$post['filepath'] = $row->filepath;
							$post['vid'] = $row->vid;
							$post['addtime'] = $row->addtime;
							geturl($apiurl,$post);
						}
					}
				}
			}
		}else{
			$id = intval($ids);
			$row = $this->csdb->get_row('vod','*',array('id'=>$id));
			if($row){
				$res = $this->db->delete('vod',array('id'=>$id));
				if($res){
					//删除收藏
					$this->db->delete('fav',array('did'=>$id));
					//删除原文件
					if(Del_Mp4 == 1){
						unlink($row->filepath);
					}
					//删除切片文件
					if(Del_M3u8 == 1){
						deldir(m3u8_dir($row->vid,$row->addtime));
					}
					//减去硬盘容量
					if($row->fid > 0){
						$rows = $this->csdb->get_row('server','*',array('id'=>$row->fid));
						$this->csdb->get_update('server',$row->fid,array('size'=>($rows->size-$row->size)));
						//删除远程服务器文件
						if(Del_Mp4 == 1 || Del_M3u8 == 1){
							$apiurl = $rows->apiurl.'api.php?ac=del&key='.$rows->apikey;
							$post['m3u8'] = Del_M3u8;
							$post['mp4'] = Del_Mp4;
							$post['filepath'] = $row->filepath;
							$post['vid'] = $row->vid;
							$post['addtime'] = $row->addtime;
							geturl($apiurl,$post);
						}
					}
				}
			}
		}
		$info['msg'] = '操作完成';
		$info['url'] = site_url('vod')."?v=".rand(0,999);
		getjson($info,1);
	}
}