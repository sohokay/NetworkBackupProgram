<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>会员列表</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body>
		<div class="layui-tab-content" style="min-height: 360px;">
            <form class="layui-form layui-form-so" action="<?=site_url('user')?>" method="post" style="padding-top: 10px">
                <div class="layui-form-item">
                    <label class="layui-form-label">日期</label>
                    <div class="layui-input-inline">
                        <input style="width:120px;" name="kstime" id="kstime" type="text" value="<?=$kstime?>" class="layui-input" /> 
                    </div>
                    <div class="layui-input-inline">-</div>
                    <div class="layui-input-inline">
                        <input style="width:120px;" name="jstime" id="jstime" value="<?=$jstime?>" type="text" class="layui-input" />
                    </div>
                    <div class="layui-input-inline">
                        <div class="vocation">
                            <select name="zd">
                               <option value="name"<?php if($zd=='name') echo ' selected';?>>会员账号</option>
                               <option value="email"<?php if($zd=='email') echo ' selected';?>>联系邮箱</option>
                               <option value="id"<?php if($zd=='id') echo ' selected';?>>会员ID</option>
                               <option value="qq"<?php if($zd=='qq') echo ' selected';?>>联系QQ</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" name="key" value="<?=$key?>" class="layui-input" style="width: 250px">
                    </div>
                    <div class="layui-input-inline">
                        <div class="vocation">
                            <select  name="zt">
                               <option value="0">状态</option>
                               <option value="1"<?php if($zt==1) echo ' selected';?>>已审核</option>
                               <option value="2"<?php if($zt==2) echo ' selected';?>>待审核</option>
                            </select>
                        </div>
                    </div>
                     <div class="layui-input-inline">
                        <button class="layui-btn" type="submit">查询</button>
                    </div>
                </div>
            </form>
            <style type="text/css">
            	.layui-table td, .layui-table th{text-align: center;}
				.layui-btn+.layui-btn{margin-left: 2px;}
				.layui-btn-mini{height: 20px;line-height: 20px;padding: 0 3px;}
				.layui-table td, .layui-table th{padding: 9px 5px;}
            </style>
            <form class="layui-form" action="<?=site_url('user/del')?>" method="post">
                <table class="layui-table">
                    <colgroup>
                        <col width="40">
                        <col width="100">
                        <col>
                        <col width="250">
                        <col width="150">
                        <col width="250">
                        <col width="100">
                        <col width="160">
                        <col width="150">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>选</th>
                            <th>ID</th>
                            <th>账号</th>
                            <th>联系邮箱</th>
                            <th>联系QQ</th>
                            <th>网站地址</th>
                            <th>状态</th>
                            <th>时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        if(empty($user)) echo '<tr><td align="center" height="50" colspan="9">没有找到相关记录</td></tr>';
                        foreach ($user as $row) {
                            $status = '<font color=#080>已审核</font>';
                            if($row->zt==1){
								$status = '<font color=#f60>待审核</font>';
							}
                            echo '
                            <tr id="row_'.$row->id.'">
                            <td><input name="id['.$row->id.']" lay-ignore class="xuan" type="checkbox" value="'.$row->id.'" /></td>
                            <td>'.$row->id.'</td>
                            <td>'.$row->name.'</td>
                            <td>'.$row->email.'</td>
                            <td>'.$row->qq.'</td>
                            <td>'.$row->url.'</td>
                            <td>'.$status.'</td>
                            <td>'.date('Y-m-d H:i:s',$row->addtime).'</td>
                            <td class="basedb-more">
                                <a class="layui-btn layui-btn-mini layui-btn-normal" href="javascript:get_open(\''.site_url('user/edit/'.$row->id).'\',\'会员修改\',\'70%\',\'500px\');">修改</a>
								<a class="layui-btn layui-btn-mini layui-btn-danger" href="javascript:del_one(\''.site_url('user/del').'\','.$row->id.');">删除</a></td>
                            </tr> ';
                        }
                    ?>
                    </tbody>
                </table>
                <div class="more_func">
                    <a class="layui-btn layui-btn-primary layui-btn-small" href="javascript:select_all();"><i class="fa fa-check colorl" ></i>全选/反选</a>
                    <a class="layui-btn layui-btn-primary layui-btn-small" lay-submit lay-filter="del_pl"><i class="fa fa-close " style="color: red" ></i>删除选中</a>
                </div>
            </form>
            <div id="page">
                <div class="data_nums phide"><?=$page_data?></div>
                <div class="data_page"><?=$page_list?></div>
            </div>
        </div>
		<script src="/packs/admin/js/common.js?v=1.4"></script>
        <script type="text/javascript">
        	var laydate;
            layui.use('laydate', function(){
                laydate = layui.laydate;
                getTime('kstime');
                getTime('jstime');
            });
        </script>
	</body>
</html>