<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
<head>
    <meta charset=utf-8>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
     <title><?=$title?></title>
		<link rel='stylesheet' href='/packs/layui/css/layui.css'>
		<script type='text/javascript' src='/packs/layui/layui.js'></script>
		<script type='text/javascript' src='/packs/jquery/jquery.min.js'></script>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="/packs/assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="/packs/assets/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="/packs/assets/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="/packs/assets/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="/packs/assets/layouts/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/layouts/light.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <!-- END THEME LAYOUT STYLES --> 
        <link href="/packs/assets/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css" />
        <link href="/packs/assets/css/bootstrap-modal.css" rel="stylesheet" type="text/css" />
        <style>
        .table th, .table td { 
            text-align: center;
            vertical-align: middle!important;
        }
        .modal-body img{
        	float:left;
        	display:block;
        	width:180px;
        	height:100px;
        	margin: 3px;
        }
        .clear{clear:both}
        #show0{display:none;}
        #show1{}
        </style>
    </head>
    <body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
            <div class="page-header navbar navbar-fixed-top">
            <div class="page-header-inner ">
                <div class="page-logo">
                    <a href="<?=links('vod')?>"><img src="/packs/assets/img/logo.png" alt="logo" class="logo-default" /></a>
                    <div class="menu-toggler sidebar-toggler"></div>
                </div>
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                <div class="page-actions">
                    <div class="btn-group">
                        <button type="button" class="btn red-haze btn-sm dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <span class="hidden-sm hidden-xs">快捷操作&nbsp;</span>
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="<?=links('upload')?>"><i class="fa fa-cloud-upload"></i> 上传视频 </a>
                            </li>
                            <li>
                                <a href="<?=links('lists','edit')?>"><i class="fa fa-plus"></i> 添加分类 </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="<?=links('vod')?>">
                                    <i class="fa fa-folder-open"></i> 我的视频
                                    <span class="badge badge-success">
                                        <?php
                                        $vodcount = $this->csdb->get_nums('vod',array('uid'=>$user->id));
                                        echo $vodcount;
                                        ?>
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="<?=links('fav')?>">
                                  <i class="fa fa-heart"></i> 我的收藏 
                                       <span class="badge badge-success">
                                        <?php
                                        $favcount = $this->csdb->get_nums('fav',array('uid'=>$user->id));
                                        echo $favcount;
                                        ?>
                                       </span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <?=str_decode(Web_Gg)?>
                </div>
                <div class="page-top">
                    <div class="layui-form search-form open" action="">
                        <div class="input-group">
                        	<input type="text" name="key" id="key" class="form-control input-sm" placeholder="请输入视频标题..." value="">
                            <span class="input-group-btn">
                                <a href="javascript:;" class="btn submit searchbut" link="<?=links('vod','search')?>">
                                    <i class="icon-magnifier"></i>
                                </a>
                            </span>
                        </div>
                    </div>
               		<div id="cscms_login" class="top-menu"> 
                        <ul class="nav navbar-nav pull-right">
                            <li class="dropdown dropdown-user dropdown-dark">
                                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <span class="username username-hide-on-mobile"><?=$user->name?></span>
                                <img alt="<?=$user->name?>" src="/packs/assets/img/nan_nopic.jpg" class="img-circle"></a>
                            </li>
                          <li class="dropdown dropdown-extended dropdown-notification dropdown-dark">
                                <a href="<?=links('login','ext')?>" class="dropdown-toggle">
                                    <i class="icon-logout"></i>
                                </a>
                            </li>
                        </ul>
                   </div>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
        <div class="page-container">
 <div class="page-sidebar-wrapper">
	<div class="page-sidebar navbar-collapse collapse">
		<ul class="page-sidebar-menu" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200">
			<li class="nav-item start active open" id="a0">
			<a href="javascript:;" class="nav-link nav-toggle">
			<i class="fa fa-file-video-o"></i>
			<span class="title">视频网盘</span>
			<span class="arrow"></span>
			</a>
			<ul class="sub-menu">
                <li class="nav-item" id="a1">
                <a href="<?=links('upload')?>"  class="nav-link ">
                <i class="fa fa-cloud-upload"></i>
                <span class="title">上传视频</span>
                </a>
                </li>
                <li class="nav-item" id="a2">
				<a href="<?=links('lists','edit')?>"  class="nav-link ">
				<i class="fa fa-plus"></i>
				<span class="title">添加分类</span>
				</a>
				</li>
				<li class="nav-item" id="a3">
				<a href="<?=links('vod')?>" class="nav-link ">
				<span class="title">我的视频</span>
				<span class="badge badge-success"><?=$vodcount?></span>
				</a>
				</li>
				<li class="nav-item " id="a4">
				<a href="<?=links('lists')?>" class="nav-link ">
				    <span class="title">我的分类</span>
		            <span class="badge badge-success"> <?=$this->csdb->get_nums('myclass',array('uid'=>$user->id))?>  </span>
				</a>
				</li>
				<li class="nav-item " id="a5">
				<a href="<?=links('fav')?>" class="nav-link ">
				<span class="title">我的收藏</span>
				<span class="badge badge-success"> <?=$favcount?></span>
				</a>
				</li>
			    <li class="nav-item" id="vall">
    				<a href="javascript:;" class="nav-link nav-toggle">
        				<i class="fa fa-folder-open"></i>
        				<span class="title">视频广场</span>
        				<span class="arrow"></span>
    				</a>
    				<ul class="sub-menu" id="vodlist">
                    <?php 
                    foreach($class as $row){
                        echo '<li class="nav-item" id="vlist_'.$row->id.'"><a href="'.links('vod','square','txt',$row->id).'" class="nav-link"> <span class="title">'.$row->name.'</span></a></li>';
                    }
                    ?>
    				</ul>
				</li>
			</ul>
			</li>
			<li class="nav-item start active open" id="b0">
    			<a href="javascript:;" class="nav-link nav-toggle">
        			<i class="fa fa-user"></i>
        			<span class="title">会员中心</span>
        			<span class="selected"></span>
        			<span class="arrow open"></span>
    			</a>
			<ul class="sub-menu">
				<li class="nav-item" id="b2">
				<a href="javascript:;" class="nav-link nav-toggle">
				<i class="fa fa-cog"></i>
				<span class="title">个人设置</span>
				<span class="arrow"></span>
				</a>
				<ul class="sub-menu active" id="idall">
					<li class="nav-item"  id="b3">
					<a href="<?=links('info','edit')?>" class="nav-link">
					<span class="title">账号设置</span>
					</a>
					</li>
					<li class="nav-item" id="b4">
					<a href="<?=links('info','pass')?>" class="nav-link ">
					<span class="title">修改密码</span>
					</a>
					</li>
				 	<li class="nav-item" id="b5">
					<a href="<?=links('info','log')?>" class="nav-link ">
					<span class="title">登录日志</span>
					</a>
					</li>
				</ul>
				</li>
				 <li class="nav-item"  id="b6">
				<a href="<?=links('info','help')?>" class="nav-link">
				<i class="fa fa-flag"></i>
				<span class="title"> 使用说明</span>
				</a>
				</li>
				<li class="heading"></li>
			</ul>
			</li>
		</ul>
	</div>
</div>