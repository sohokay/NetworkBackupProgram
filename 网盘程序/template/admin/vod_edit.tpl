<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>视频修改</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body style="padding: 10px">
	<form class="layui-form" action="<?=site_url('vod/save/'.$vod->id)?>" method="post">
        <table class="layui-table">
            <colgroup>
                <col width="120">
                <col>
            </colgroup>
            <tbody>
                <tr><td align="center">视频名称</td><td><input type="text" name="name" placeholder="请输入分类名称" value="<?=$vod->name?>" class="layui-input"></td></tr>
                <tr><td align="center">原文件地址</td><td><input type="text" name="filepath" placeholder="请输入分类排序ID" value="<?=$vod->filepath?>" class="layui-input"></td></tr>
                <tr><td align="center">系统分类</td><td>
                            <select name="cid">
                               <option value="0">视频分类</option>
							<?php 
								foreach ($vlist as $row2) {
									$sel = $vod->cid == $row2->id ? ' selected' : '';
									echo '<option value="'.$row2->id.'"'.$sel.'>'.$row2->name.'</option>';
								}
							?>
                            </select>
                </td></tr>
                <tr><td align="center">转码状态</td><td>
                            <select name="zt">
                               <option value="0">待转码</option>
                               <option value="1"<?php if($vod->zt==1) echo ' selected';?>>转码中</option>
                               <option value="2"<?php if($vod->zt==2) echo ' selected';?>>已完成</option>
                               <option value="3"<?php if($vod->zt==3) echo ' selected';?>>已失败</option>
                            </select>
                </td></tr>
                <tr><td align="center" colspan="2"><button class="layui-btn" lay-submit lay-filter="edit">提交</button></td></tr>
            </tbody>
        </table>
	</form>
	<script src="/packs/admin/js/common.js"></script>
	</body>
</html>