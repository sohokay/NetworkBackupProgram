<?php
/**
 * @Ctcms open source management system
 * @copyright 2016-2017 ctcms.cn. All rights reserved.
 * @Author:Chi Tu
 * @Dtime:2016-08-11
 */
//获取连接URL
function links($ac,$op='',$id=0,$where='',$admin=0){ 
   if(!empty($op)) $ac.='/'.$op;
   if(empty($where)){
	   if(empty($id)){
			$url=site_url($ac);
	   }else{
			$url=site_url($ac.'/'.$id);
	   }
   }else{
	   if(empty($id)){
			$url=is_numeric($where) ? site_url($ac.'/'.$where) : site_url($ac).'?'.$where;
	   }else{
			$url=is_numeric($where) ? site_url($ac.'/'.$id.'/'.$where) : site_url($ac.'/'.$id).'?'.$where;
	   }
   }
   //下面是去掉index.php ，需要支持伪静态规则
   $url=str_replace("index.php/","",$url);
   $url=str_replace("?&","?",$url);
   //后台跳转前台
   if($admin==1) $url=str_replace(SELF,"index.php",$url);
   return 'http://'.Web_Url.$url; 
}

//获取图片
function getpic($pic){ 
   if(empty($pic)){
		$url=base_url('attachment/nopic.png');
   }else{
		$url=$pic;
		if(substr($pic,0,7)!='http://' && substr($pic,0,8)!='https://'){
			 if(Ftp_Is==1) $url=Ftp_Url.$url;
		}
   }
   return $url; 
}
//分页
function admin_page($url,$page,$pages){
	$phtml = '<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-0">';
	if($page > 1){
		$phtml .= '<a href="'.$url.($page-1).'" class="layui-laypage-prev" data-page="'.($page-1).'">上一页</a>';
	}
	if($pages<6 || $page<4){
		if($pages < 2){
			return '';
		}
		if($pages<6){
			$len = $pages;
		}else{
			$len = 5;
		}
		for($i=1;$i<$len+1;$i++){
			$phtml .= page_curr($url,$page,$i);
		}
		if($pages>5){
			$phtml .= '<span>…</span><a href="'.$url.$pages.'" class="layui-laypage-last" title="尾页" data-page="'.$pages.'">末页</a>';
		}
	}else{//pages>$nums
		if($pages<$page+2){
			$phtml .= '<a href="'.$url.'1" class="laypage_first" data-page="1" title="首页">首页</a><span>…</span>';
			for($i=$pages-4;$i<$pages+1;$i++){
				$phtml .= page_curr($url,$page,$i);
			}
		}else{
			$phtml .='<a href="'.$url.'1" class="laypage_first" data-page="1" title="首页">首页</a><span>…</span>';
			for($i=$page-2;$i<$page+3;$i++){
				$phtml .= page_curr($url,$page,$i);
			}
			$phtml .= '<span>…</span><a href="'.$url.$pages.'" class="layui-laypage-last" title="尾页" data-page="'.$pages.'">末页</a>';
		}
	}
	if($page < $pages){
		$phtml .= '<a href="'.$url.($page+1).'" class="layui-laypage-next" data-page="'.($page+1).'">下一页</a>';
	}
	$phtml .= '<span class="layui-laypage-total phide">到第 <input id="goto_page" type="number" min="1" onkeyup="this.value=this.value.replace(/\D/, \'\')" value="'.$page.'" class="layui-laypage-skip"> 页 <button type="button" onclick="goto_page(\''.$url.'\')" class="layui-laypage-btn">确定</button></span></div>';
	return $phtml;
}
function page_curr($url,$page,$i){
	$phtml = '';
	if($page==$i){
		$phtml .= '<span class="layui-laypage-curr"><em class="layui-laypage-em"></em><em>'.$page.'</em></span>';
	}else{
		$phtml .= '<a href="'.$url.$i.'" data-page="'.$i.'">'.$i.'</a>';
	}
	return $phtml;
}
function page_data($nums,$page,$pages){
	if($pages<2){
		return '';
	}else{
		return '共'.$nums.'条记录'.$pages.'页,当前显示第'.$page.'页';
	}
}
//前台分页
function get_page($num,$pages,$page=1,$ac,$op='',$id=0,$where=''){
	$phtml = '<li><a href="'.links($ac,$op,$id,$where.'&page='.($page-1)).'"><i class="fa fa-angle-left"></i></a></li>';
	if($pages<6 || $page<4){
		if($pages < 2){
			return '';
		}
		if($pages<6){
			$len = $pages;
		}else{
			$len = 5;
		}
		for($i=1;$i<$len+1;$i++){
			$clas = $page == $i ? 'active' : '';
			$phtml .= "<li class='".$clas."'><a href='".links($ac,$op,$id,$where.'&page='.$i)."'>".$i."</a></li>";
		}
		if($pages>5){
			$phtml .= '<li><a href="'.links($ac,$op,$id,$where.'&page='.$pages).'" title="尾页">尾页</a></li>';
		}
	}else{//pages>$nums
		if($pages<$page+2){
			$phtml .= '<li><a href="'.links($ac,$op,$id,$where.'&page=1').'" title="首页">首页</a></li>';
			for($i=$pages-4;$i<$pages+1;$i++){
				$clas = $page == $i ? 'active' : '';
				$phtml .= "<li class='".$clas."'><a href='".links($ac,$op,$id,$where.'&page='.$i)."'>".$i."</a></li>";
			}
		}else{
			$phtml .='<li><a href="'.links($ac,$op,$id,$where.'&page=1').'" title="首页">首页</a></li>';
			for($i=$page-2;$i<$page+3;$i++){
				$clas = $page == $i ? 'active' : '';
				$phtml .= "<li class='".$clas."'><a href='".links($ac,$op,$id,$where.'&page='.$i)."'>".$i."</a></li>";
			}
			$phtml .= '<li><a href="'.links($ac,$op,$id,$where.'&page='.$pages).'" title="尾页">尾页</a></li>';
		}
	}
	if($page < $pages){
		$phtml .= '<li><a href="'.links($ac,$op,$id,$where.'&page='.($page+1)).'"><i class="fa fa-angle-right"></i></a></li>';
	}
	return $phtml;
}