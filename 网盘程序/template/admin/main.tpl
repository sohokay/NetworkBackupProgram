<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <meta http-equiv="X-UA-Compatible" content="IE=9">
        <title>后台管理</title>
        <link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/layui/css/layui.css">
        <link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/admin/css/common.css?v=1.1">
        <link rel="stylesheet" type="text/css" href="<?=Web_Path?>packs/font/font.css">
        <script src="<?=Web_Path?>packs/jquery/jquery.min.js"></script>
        <script src="<?=Web_Path?>packs/layui/layui.js"></script>
    </head>
    <body style="padding: 10px;">
        <table class="layui-table">
            <thead>
                <tr>
                    <th colspan="2">登录信息</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="2">管理员 <?=$admin?>,上次登录时间:<?=date('Y-m-d H:i:s',$logtime)?> 上次登录IP:<?=$logip?></td>
                </tr>
            </tbody>
            <thead>
                <tr>
                    <th colspan="2">视频统计信息</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="2">今日数量:<?=$jcount?>个  昨日数量:<?=$zcount?>个  本月数量:<?=$bcount?>个  上月数量:<?=$scount?>个  总数量:<?=$count?>个  待转码数量:<?=$dzcount?>个</td>
                </tr>
            </tbody>
            <colgroup>
                <col width="140">
            </colgroup>
            <thead>
                <tr>
                    <th colspan="2">网站基本信息</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>软件名称</td>
                    <td>崇胜网盘云存储系统V1.0</td>
                </tr>
                <tr>
                    <td>允许上传最大值</td>
                    <td><?=get_cfg_var("upload_max_filesize")?></td>
                </tr>
                <tr>
                    <td>POST提交最大值</td>
                    <td><?=get_cfg_var("post_max_size")?></td>
                </tr>
                <tr>
                    <td>服务器IP</td>
                    <td><?php if('/'==DIRECTORY_SEPARATOR){echo $_SERVER['SERVER_ADDR'];}else{echo gethostbyname($_SERVER['SERVER_NAME']);} ?></td>
                </tr>
                <tr>
                    <td>软件开发</td>
                    <td>桂林崇胜网络科技有限公司</td>
                </tr>
                <tr>
                    <td>官方网站</td>
                    <td>www.chshcms.net</td>
                </tr>
            </tbody>
        </table>
    </body>
</html>