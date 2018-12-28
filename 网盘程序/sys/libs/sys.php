<?php
/**
 * @Ctcms open source management system
 * @copyright 2008-2016 www.chshcms.net. All rights reserved.
 * @Author:Cheng Kai Jie
 * @Dtime:2018-05-15
 */
header('Content-Type: text/html; charset=utf-8');
//装载全局配置文件
require_once 'db.php';
require_once 'config.php';
//手机客户端访问标示
if(preg_match("/(iPhone|iPad|iPod|Android|Linux)/i", strtoupper($_SERVER['HTTP_USER_AGENT']))){
    define('MOBILE', true);	
}