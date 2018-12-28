<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>会员修改</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body style="padding: 10px">
	<form class="layui-form" action="<?=site_url('sys/save/'.$id)?>" method="post">
        <table class="layui-table">
            <colgroup>
                <col width="120">
                <col>
            </colgroup>
            <tbody>
                <tr><td align="center">账号</td><td><input type="text" name="name" placeholder="请输入分类名称" value="<?=$name?>" class="layui-input"></td></tr>
                <tr><td align="center">密码</td><td><input type="text" name="pass" placeholder="不修改请留空" value="" class="layui-input"></td></tr>
                <tr><td align="center">昵称</td><td><input type="text" name="nichen" placeholder="请输入昵称" value="<?=$nichen?>" class="layui-input"></td></tr>
                <tr><td align="center" colspan="2"><button class="layui-btn" lay-submit lay-filter="edit">提交</button></td></tr>
            </tbody>
        </table>
	</form>
	<script src="/packs/admin/js/common.js"></script>
	</body>
</html>