<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=9">
		<title>视频详情页</title>
		<link rel="stylesheet" type="text/css" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body style="padding: 10px">
        <style type="text/css">a{color: #333;}a:hover{color:#ff5722;}</style>
        <table class="layui-table">
            <colgroup>
                <col width="120">
                <col>
            </colgroup>
            <?php
                $status = '<font color=#1e9fff>等待转码</font>';
                if($vod->zt==1) $status = '<font color=#f60>转码中</font>';
                if($vod->zt==2) $status = '<font color=green>转码完成</font>';
                if($vod->zt==3) $status = '<font color=red>转码失败</font>';
                $rows = array();
                if($vod->fid > 0){
                    $rows = $this->csdb->get_row_arr('server','*',array('id'=>$vod->fid));
                }
            ?>
            <tbody>
                <tr><td align="center">视频名称</td><td><?=$vod->name?></td></tr>
                <tr><td align="center">转码状态</td><td><?=$status?></td></tr>
                <tr><td align="center">播放地址</td><td><a href="<?=links('play','index',$vod->vid,'',1)?>" target="_blank"><?=links('play','index',$vod->vid,'',1)?></a></td></tr>
				<?php 
                if(Jpg_On == 1){
                    for($i=1;$i<=Jpg_Num;$i++){ 
                        $piclink = m3u8_link($vod->vid,$vod->addtime,'pic',$i,$rows);
                        echo '<tr><td align="center">图片地址'.$i.'</td><td><a href="'.$piclink.'" target="_blank">'.$piclink.'</a></td></tr>';
                    }
				}
                $m3u8link = m3u8_link($vod->vid,$vod->addtime,'m3u8',1,$rows);
                ?>
                <tr><td align="center">M3U8地址</td><td><a href="<?=$m3u8link?>" target="_blank"><?=$m3u8link?></a></td></tr>
            </tbody>
        </table>
		<script src="/packs/admin/js/common.js"></script>
	</body>
</html>