<!doctype html>
<html>
<head>
	<meta charset=utf-8>
	<title><?=$title?></title>
	<meta name="robots" content="noindex,nofollow">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="<?=Web_Path?>packs/font/font.css">
	<link rel="stylesheet" href="<?=Web_Path?>packs/layui/css/layui.css">
	<link type="text/css" rel="stylesheet" href="<?=Web_Path?>packs/admin/css/login.css?v=1" />
	<script src="<?=Web_Path?>packs/layui/layui.js"></script>
	<script src="<?=Web_Path?>packs/jquery/jquery.min.js"></script>
</head>
<body class="login">
<div class="login-title">后台管理登录</div>
<form class="layui-form login-form" action="<?=links('login/save')?>" method="post">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="adminname" required lay-verify="required" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="password" name="adminpass" required lay-verify="required" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="login">登 录</button>
        </div>
    </div>
</form>
<script src="<?=Web_Path?>packs/admin/js/common.js"></script>
</body>
</html>