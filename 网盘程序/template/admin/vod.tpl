<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>视频列表</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body>
		<div class="layui-tab-content" style="min-height: 360px;">
            <form class="layui-form layui-form-so" action="<?=site_url('vod')?>" method="post" style="padding-top: 10px">
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
                               <option value="name"<?php if($zd=='name') echo ' selected';?>>视频名称</option>
                               <option value="id"<?php if($zd=='id') echo ' selected';?>>视频ID</option>
                               <option value="uid"<?php if($zd=='uid') echo ' selected';?>>会员ID</option>
                               <option value="mycid"<?php if($zd=='mycid') echo ' selected';?>>私人分类ID</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <input type="text" name="key" value="<?=$key?>" class="layui-input" style="width: 250px">
                    </div>
                    <div class="layui-input-inline">
                        <div class="vocation">
                            <select  name="cid">
                               <option value="0">视频分类</option>
							<?php 
								foreach ($vlist as $row2) {
									$sel = $cid == $row2->id ? ' selected' : '';
									echo '<option value="'.$row2->id.'"'.$sel.'>'.$row2->name.'</option>';
								}
							?>
                            </select>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <div class="vocation">
                            <select  name="zt">
                               <option value="0">转码状态</option>
                               <option value="1"<?php if($zt==1) echo ' selected';?>>待转码</option>
                               <option value="2"<?php if($zt==2) echo ' selected';?>>转码中</option>
                               <option value="3"<?php if($zt==3) echo ' selected';?>>已完成</option>
                               <option value="4"<?php if($zt==4) echo ' selected';?>>已失败</option>
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
            <form class="layui-form" action="<?=site_url('vod/del')?>" method="post">
                <table class="layui-table">
                    <colgroup>
                        <col width="40">
                        <col width="100">
                        <col>
                        <col width="150">
                        <col width="150">
                        <col width="150">
                        <col width="120">
                        <col width="120">
                        <col width="100">
                        <col width="160">
                        <col width="150">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>选</th>
                            <th>ID</th>
                            <th>名称</th>
                            <th>系统分类</th>
                            <th>私人分类</th>
                            <th>会员ID</th>
                            <th>时长</th>
                            <th>大小</th>
                            <th>状态</th>
                            <th>时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        if(empty($vod)) echo '<tr><td align="center" height="50" colspan="11">没有找到相关记录</td></tr>';
                        foreach ($vod as $row) {
                            if($row->zt==1){
								$status = '<font color=#1e9fff>转码中..</font>';
							}elseif($row->zt==2){
                                $status = '<font color=green>转码完成</font>';
                            }elseif($row->zt==3){
                                $status = '<font color=red>转码失败</font>';
                            }else{
                                $status = '<font color=#f90>等待转码</font>';
                            }
                            $cname = ' -- ';
                            $sname = ' -- ';
                            if($row->cid>0) $cname = getzd('class','name',$row->cid);
                            if($row->mycid>0) $sname = getzd('myclass','name',$row->mycid);
							$playurl = links('play','index',$row->vid,'',1);
                            echo '
                            <tr id="row_'.$row->id.'">
                            <td><input name="id['.$row->id.']" lay-ignore class="xuan" type="checkbox" value="'.$row->id.'" /></td>
                            <td>'.$row->id.'</td>
                            <td style="text-align: left;"><a class="plink" sid="'.$row->zt.'" href="javascript:layer.msg(\'转码未完成...\');" _href="'.$playurl.'">'.$row->name.'</a></td>
                            <td>'.$cname.'</td>
                            <td>'.$sname.'</td>
                            <td>'.$row->uid.'</td>
                            <td>'.formattime($row->duration,1).'</td>
                            <td>'.formatsize($row->size).'</td>
                            <td id="zm_'.$row->id.'">'.$status.'</td>
                            <td>'.date('Y-m-d H:i:s',$row->addtime).'</td>
                            <td class="basedb-more">
                                <a class="layui-btn layui-btn-mini" href="javascript:get_open(\''.site_url('vod/show/'.$row->id).'\',\'视频详细信息展示\',\'80%\',\'600px\');">详情</a>
                                <a class="layui-btn layui-btn-mini layui-btn-normal" href="javascript:get_open(\''.site_url('vod/edit/'.$row->id).'\',\'视频修改\',\'60%\',\'400px\');">修改</a>
								<a class="layui-btn layui-btn-mini layui-btn-danger" href="javascript:del_one(\''.site_url('vod/del').'\','.$row->id.');">删除</a></td>
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
		<script src="/packs/admin/js/clipboard.min.js"></script>
		<script src="/packs/admin/js/common.js?v=1.4"></script>
        <script type="text/javascript">
        	var laydate;
            layui.use('laydate', function(){
                laydate = layui.laydate;
                getTime('kstime');
                getTime('jstime');
            });
            $(document).ready(function(){
                $('.plink').each(function(){
                    var sid = $(this).attr('sid');
                    var link = $(this).attr('_href');
                    if(sid == '2'){
                        $(this).attr('href',link).attr('target','play');
                    }
                });
			});
        </script>
	</body>
</html>