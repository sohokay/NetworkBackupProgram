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
	<form class="layui-form" action="<?=site_url('user/save/'.$user->id)?>" method="post">
        <table class="layui-table">
            <colgroup>
                <col width="120">
                <col>
            </colgroup>
            <tbody>
                <tr><td align="center">会员账号</td><td><input type="text" name="name" placeholder="请输入分类名称" value="<?=$user->name?>" class="layui-input"></td></tr>
                <tr><td align="center">登录密码</td><td><input type="text" name="pass" placeholder="不修改请留空" value="" class="layui-input"></td></tr>
                <tr><td align="center">联系邮箱</td><td><input type="text" name="email" placeholder="请输入联系邮箱" value="<?=$user->email?>" class="layui-input"></td></tr>
                <tr><td align="center">联系QQ</td><td><input type="text" name="qq" placeholder="请输入联系QQ" value="<?=$user->qq?>" class="layui-input"></td></tr>
                <tr><td align="center">网站地址</td><td><input type="text" name="url" placeholder="请输入网站地址" value="<?=$user->url?>" class="layui-input"></td></tr>
                <tr><td align="center">会员状态</td><td>
                            <select name="zt">
                               <option value="0">已审核</option>
                               <option value="1"<?php if($user->zt==1) echo ' selected';?>>待审核</option>
                            </select>
                </td></tr>
                <tr><td align="center" colspan="2"><button class="layui-btn" lay-submit lay-filter="edit">提交</button></td></tr>
            </tbody>
        </table>
	</form>
	<script src="/packs/admin/js/common.js"></script>
	</body>
</html>