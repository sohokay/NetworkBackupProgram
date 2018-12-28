# NetworkBackupProgram

1.选创建个MYSQL数据库，把根目录下的Mysql.sql导入进去

2.修改 ./sys/libs/db.php 修改数据库账号、密码、数据库名字

3.登录后台，修改网站配置（默认后台账号、密码、认证码全部是:111）

4.转码水印LOGO位置 ./packs/ffmpeg/logo.png

5.转码字幕文件位置 ./packs/ffmpeg/zimu.ass


注意：

1.所有转码服务器和网站服务器的PHP环境需要去掉exec、shell_exec这两个禁用函数

2.每增加一个转码服务器，都需要把根目录下的《上传服务器》里面的文件传到转码服务器

3.然后去后台增加服务器即可

4.转码水印LOGO位置 ./ffmpeg/logo.png

5.转码字幕文件位置 ./ffmpeg/zimu.ass