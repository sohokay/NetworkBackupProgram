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
            <style type="text/css">
            	.layui-table td, .layui-table th{text-align: center;}
				.layui-btn+.layui-btn{margin-left: 2px;}
				.layui-btn-mini{height: 20px;line-height: 20px;padding: 0 3px;}
				.layui-table td, .layui-table th{padding: 9px 5px;}
            </style>
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <button class="layui-btn layui-btn-normal" onclick="get_open('<?=site_url('sys/edit')?>','新增分类','70%','280px');" type="button">新增管理员</button>
                </div>
            </div>
            <form class="layui-form" action="<?=site_url('sys/del')?>" method="post">
                <table class="layui-table">
                    <thead>
                        <tr>
                            <th>选</th>
                            <th>ID</th>
                            <th>账号</th>
                            <th>昵称</th>
                            <th>最后登录IP</th>
                            <th>最后登录时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        if(empty($admin)) echo '<tr><td align="center" height="50" colspan="7">没有找到相关记录</td></tr>';
                        foreach ($admin as $row) {
                            echo '
                            <tr id="row_'.$row->id.'">
                            <td><input name="id['.$row->id.']" lay-ignore class="xuan" type="checkbox" value="'.$row->id.'" /></td>
                            <td>'.$row->id.'</td>
                            <td>'.$row->name.'</td>
                            <td>'.$row->nichen.'</td>
                            <td>'.$row->logip.'</td>
                            <td>'.date('Y-m-d H:i:s',$row->logtime).'</td>
                            <td class="basedb-more">
                                <a class="layui-btn layui-btn-mini layui-btn-normal" href="javascript:get_open(\''.site_url('sys/edit/'.$row->id).'\',\'账号修改\',\'70%\',\'350px\');">修改</a>
								<a class="layui-btn layui-btn-mini layui-btn-danger" href="javascript:del_one(\''.site_url('sys/del').'\','.$row->id.');">删除</a></td>
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
        </div>
		<script src="/packs/admin/js/common.js?v=1.4"></script>
	</body>
</html>