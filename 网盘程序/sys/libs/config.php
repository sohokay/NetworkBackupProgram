<?php
define('Web_Name','云盘存储'); //站点名称
define('Web_Url','www.pan.com'); //站点域名
define('Web_Zm_Url','zm.pan.com'); //转码域名
define('Web_M3u8_Url',''); //M3u8域名
define('Web_Pic_Url',''); //图片域名
define('Web_Path','/'); //站点路径
define('Web_Reg',0);  //会员注册状态，0审核，1待审
define('Web_Gg','&lt;a target=&quot;_blank&quot; href=&quot;http:///&quot;&gt;&lt;span class=&quot;caption-subject font-red sbold uppercase&quot;&gt;85盘官方广告收量，全网最高价包站网址：ad.27pan.com  &lt;/span&gt;&lt;/a&gt;');  //网站公告
define('Up_Dir','./video/data/'); //上传源文件保存路径
define('Up_Ext','avi|wmv|mpeg|mp4|mov|mkv|flv|f4v|m4v|rmvb|rm|mpg'); //支持的上传格式
define('Del_Mp4',1); //删除视频是否删除源文件
define('Del_M3u8',1); //删除视频是否删除切片资源
define('Zm_Dir','./video/m3u8/');  //切片保存目录
define('Zm_Preset','veryfast'); //切片优先方式
define('Zm_Time',1);  //每个TS的时长秒数
define('Zm_Kbps','500k');  //切片码率
define('Zm_Size','');  //切片尺寸
define('Zm_Zm',0);  //是否启用字幕。0关闭，1启用
define('Zm_Sy',0);  //水印开关，0关闭1左上2右上3左下4右下
define('Zm_Sylt','1:1');  //左上距离边界位置
define('Jpg_On',1);  //截图开关，1打开0关闭
define('Jpg_Num',9);  //截图张数
define('Jpg_Time',2);  //间隔秒数
define('Jpg_Size','350x240');  //截图尺寸
define('Admin_QQ','157503886'); //联系QQ
define('Admin_Qun','157503886'); //联系群
define('Admin_Count','统计代码'); //统计代码