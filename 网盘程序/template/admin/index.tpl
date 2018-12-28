<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title><?=$title?></title>
		<link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/admin/css/common.css">
		<link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/font/font.css">
		<script src="<?=Web_Path?>packs/jquery/jquery.min.js"></script>
		<script src="<?=Web_Path?>packs/layui/layui.js"></script>
	</head>
	<body>
		<header>
			<a href="<?=Web_Path?>" target="_blank"><span style="padding-left:20px;">后台管理系统</span></a>
			<a style="float: right;width: 100px;height: 30px;color: #ddd;line-height: 63px;" href="<?=links('login/ext')?>"><i class="fa fa-power-off"></i>&nbsp;退出登录</a>
		</header>
		<div class="menu_left">
			<ul class="layui-nav layui-nav-tree">
			    <li class="layui-nav-item layui-nav-itemed"> <a href="javascript:;">视频管理</a>
			        <dl class="layui-nav-child">
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('vod')?>">视频列表</a></dd>
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('fav')?>">收藏列表</a></dd>
			        </dl>
			    </li>
			    <li class="layui-nav-item layui-nav-itemed"> <a href="javascript:;">分类管理</a>
			        <dl class="layui-nav-child">
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('lists')?>">系统分类</a></dd>
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('lists','index','my')?>">私人分类</a></dd>
			        </dl>
			    </li>
			    <li class="layui-nav-item layui-nav-itemed"> <a href="javascript:;">会员管理</a>
			        <dl class="layui-nav-child">
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('user')?>">会员列表</a></dd>
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('user','','','zt=2')?>">待审会员</a></dd>
			        </dl>
			    </li>
			    <li class="layui-nav-item layui-nav-itemed"> <a href="javascript:;">系统管理</a>
			        <dl class="layui-nav-child">
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('setting')?>">系统配置</a></dd>
			            <dd><a href="javascript:;" onclick="turnLink(this)" _href="<?=links('sys')?>">后台管理员</a></dd>
			        </dl>
			    </li>
			</ul>
		</div>
		<div class="main">
			<iframe name="iframe_0" id="iframe_main" src="<?=links('index/main')?>" style="border: 0px;width: 100%;height: 99.5%;"></iframe>
		</div>
		<script type="text/javascript" src="<?=Web_Path?>packs/admin/js/common.js?v=1.1"></script>
	</body>
</html>