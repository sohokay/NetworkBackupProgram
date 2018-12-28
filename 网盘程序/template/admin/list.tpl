<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>后台管理系统</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body>
		<div class="layui-tab-content" style="min-height: 360px;">
            <form class="layui-form layui-form-so" action="<?=site_url('lists/index/'.$op)?>" method="post" style="padding-top: 10px;float: left;">
                <div class="layui-form-item">
                    <?php if($op == 'my'){ ?>
                    <label class="layui-form-label">会员ID</label>
                    <div class="layui-input-inline">
                        <input type="text" name="uid" value="<?=$uid == 0 ? '' : $uid;?>" class="layui-input" style="width: 150px">
                    </div>
                     <div class="layui-input-inline">
                        <button class="layui-btn" type="submit">查询</button>
                    </div>
                    <?php }else{ ?>
                    <div class="layui-input-inline">
                        <button class="layui-btn layui-btn-normal" onclick="get_open('<?=site_url('lists/edit')?>','新增分类','70%','280px');" type="button">新增分类</button>
                    </div>
                    <?php } ?>
                </div>
            </form>
            <style type="text/css">
				.layui-btn+.layui-btn{margin-left: 2px;}
				.layui-btn-mini{height: 20px;line-height: 20px;padding: 0 3px;}
				.layui-table td, .layui-table th{padding: 9px 5px;text-align: center;}
            </style>
            <form class="layui-form" action="<?=site_url('lists/del/'.$op)?>" method="post">
                <table class="layui-table">
                    <colgroup>
                        <col width="40">
                        <col width="150">
                        <col width="250">
                        <col width="250">
                        <col width="150">
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>选</th>
                            <th>ID</th>
                            <th>分类名称</th>
                            <th>上级分类</th>
                            <th>排序ID</th>
                            <?php if($op == 'my'){ ?>
                            <th>会员ID</th>
                            <?php } ?>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        $col = $op == 'my' ? 7 : 6;
                        if(empty($vlist)) echo '<tr><td align="center" height="50" colspan="'.$col.'">没有找到相关记录</td></tr>';
                        foreach ($vlist as $row) {
                            $sname = $row->fid > 0 ? getzd($table,'name',$row->fid) : '--';
                            $uid = $op == 'my' ? '<td>'.$row->uid.'</td>' : '';
                            echo '
                            <tr id="row_'.$row->id.'">
                            <td><input name="id['.$row->id.']" lay-ignore class="xuan" type="checkbox" value="'.$row->id.'" /></td>
                            <td>'.$row->id.'</td>
                            <td style="text-align: left;">'.$row->name.'</td>
                            <td>'.$sname.'</td>
                            <td>'.$row->xid.'</td>
                            '.$uid.'
                            <td class="basedb-more">
                                <a class="layui-btn layui-btn-mini layui-btn-normal" href="javascript:get_open(\''.site_url('lists/edit/'.$op.'/'.$row->id).'\',\'修改\',\'70%\',\'280px\');">修改</a>
								<a class="layui-btn layui-btn-mini layui-btn-danger" href="javascript:del_one(\''.site_url('lists/del/'.$op).'\','.$row->id.');">删除</a></td>
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
	</body>
</html>