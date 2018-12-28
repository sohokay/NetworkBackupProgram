<!DOCTYPE html>
<html lang="zh-CN">
	<head>
	    <meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>系统配置</title>
	    <link rel="stylesheet" href="/packs/layui/css/layui.css">
		<link rel="stylesheet" type="text/css" href="/packs/admin/css/common.css?v=1.1">
		<link rel="stylesheet" type="text/css" href="/packs/font/font.css">
		<script src="/packs/jquery/jquery.min.js"></script>
		<script src="/packs/layui/layui.js"></script>
	</head>
	<body class="setting">
		<form class="layui-form layui-form-pane setting_form" method="post" action="<?=site_url('setting/save')?>">
		<div class="layui-tab layui-tab-brief" lay-filter="setting">
			<ul class="layui-tab-title">
				<li class="layui-this" lay-id="set1">网站设置</li>
				<li class="" lay-id="set2">切片设置</li>
				<li class="" lay-id="set3">截图设置</li>
				<li class="" lay-id="set4">水印设置</li>
				<li class="" lay-id="set5">上传设置</li>
				<li class="" lay-id="set6">其他设置</li>
			</ul>
			<div class="layui-tab-content">
				<!-- 网站基本设置 -->
				<div class="layui-tab-item layui-show">
					<div class="layui-form-item">
						<label class="layui-form-label">网站名称</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_Name" required  lay-verify="required" placeholder="请输入站点名称" autocomplete="off" class="layui-input" value="<?=Web_Name?>">
						</div>
						<div class="layui-form-mid layui-word-aux">如：88盘</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">站点域名</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_Url" required  lay-verify="required" placeholder="请输入站点域名" autocomplete="off" class="layui-input" value="<?=Web_Url?>">
						</div>
						<div class="layui-form-mid layui-word-aux">站点域名，不带http://</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">切片域名</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_Zm_Url" required  lay-verify="required" placeholder="请输入用于切片的域名" autocomplete="off" class="layui-input" value="<?=Web_Zm_Url?>">
						</div>
						<div class="layui-form-mid layui-word-aux">用于切片的域名，绑定到网站域名一起，不带http://</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">M3u8域名</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_M3u8_Url" placeholder="M3u8地址的域名" autocomplete="off" class="layui-input" value="<?=Web_M3u8_Url?>">
						</div>
						<div class="layui-form-mid layui-word-aux">M3u8地址的域名，域名绑定到：<?=Zm_Dir?></div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">图片域名</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_Pic_Url" placeholder="截图图片地址的域名" autocomplete="off" class="layui-input" value="<?=Web_Pic_Url?>">
						</div>
						<div class="layui-form-mid layui-word-aux">图片地址的域名，域名绑定到：<?=Zm_Dir?></div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">网站路径</label>
						<div class="layui-input-inline">
							<input type="text" name="Web_Path" required  lay-verify="required" placeholder="请输入站点路径" autocomplete="off" class="layui-input" value="/">
						</div>
						<div class="layui-form-mid layui-word-aux">站点路径，根目录如: / 二级目录如: /m3u8/</div>
					</div>
				</div>
				<!-- 视频切片设置 -->
			    <div class="layui-tab-item">
					<div class="layui-form-item">
						<label class="layui-form-label">切片保存目录</label>
						<div class="layui-input-inline">
							<input type="text" name="Zm_Dir" placeholder="切片保存目录" autocomplete="off" class="layui-input" value="<?=Zm_Dir?>">
						</div>
						<div class="layui-form-mid layui-word-aux">如：D:/m3u8/，网站目录内可以用./开头</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">切片方式</label>
						<div class="layui-input-inline">
							<select name="Zm_Preset">
								<option value="ultrafast" <?=Zm_Preset=='ultrafast'?'selected':''?> >急速切片</option>
								<option value="veryfast" <?=Zm_Preset=='veryfast'?'selected':''?> >速度优先</option>
								<option value="fast" <?=Zm_Preset=='fast'?'selected':''?> >均衡设置</option>
								<option value="medium" <?=Zm_Preset=='medium'?'selected':''?> >画质优先</option>
							</select>
						</div>
						<div class="layui-form-mid layui-word-aux">画质优先，切片速度则变慢</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">切片码率</label>
						<div class="layui-input-inline">
							<select name="Zm_Kbps">
								<option value="" <?=Zm_Kbps==''?'selected':''?> >原画</option>
								<option value="160k" <?=Zm_Kbps=='160k'?'selected':''?> >160k</option>
								<option value="240k" <?=Zm_Kbps=='240k'?'selected':''?> >240k</option>
								<option value="360k" <?=Zm_Kbps=='360k'?'selected':''?> >360k</option>
								<option value="500k" <?=Zm_Kbps=='500k'?'selected':''?> >500k</option>
								<option value="720k" <?=Zm_Kbps=='720k'?'selected':''?> >720k</option>
								<option value="1000k" <?=Zm_Kbps=='1000k'?'selected':''?> >1000k</option>
							</select>
						</div>
						<div class="layui-form-mid layui-word-aux">切片后的码率，越大越清晰</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">切片尺寸</label>
						<div class="layui-input-inline">
							<input type="text" name="Zm_Size" placeholder="请输如切片后的尺寸" autocomplete="off" class="layui-input" value="<?=Zm_Size?>">
						</div>
						<div class="layui-form-mid layui-word-aux">用于约束切片后的视频尺寸，如320x180，留空则是原画</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">TS时长</label>
						<div class="layui-input-inline">
							<input type="text" name="Zm_Time" placeholder="单个TS的时长" autocomplete="off" class="layui-input" value="<?=Zm_Time?>">
						</div>
						<div class="layui-form-mid layui-word-aux">单个TS的时长，建议设置为10左右</div>
					</div>
				</div>
			    <!-- 截图设置 -->
			    <div class="layui-tab-item">
					<div class="layui-form-item">
						<label class="layui-form-label">截图开关</label>
						<div class="layui-input-inline">
      						<input type="radio" name="Jpg_On" value="0" title="关闭" <?=Jpg_On==0?'checked':''?>>
							<input type="radio" name="Jpg_On" value="1" title="开启" <?=Jpg_On==1?'checked':''?>>
						</div>
						<div class="layui-form-mid layui-word-aux">视频生成jpg图开关设置</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">截图张数</label>
						<div class="layui-input-inline">
							<input type="text" name="Jpg_Num" placeholder="" autocomplete="off" class="layui-input" value="<?=Jpg_Num?>">
						</div>
						<div class="layui-form-mid layui-word-aux">总共截取图片张数，默认1张</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">间隔时间</label>
						<div class="layui-input-inline">
							<input type="text" name="Jpg_Time" placeholder="" autocomplete="off" class="layui-input" value="<?=Jpg_Time?>">
						</div>
						<div class="layui-form-mid layui-word-aux">截图间隔时间，秒数，几秒截取一张</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">截图尺寸</label>
						<div class="layui-input-inline">
							<input type="text" name="Jpg_Size" placeholder="截取图片的尺寸" autocomplete="off" class="layui-input" value="<?=Jpg_Size?>">
						</div>
						<div class="layui-form-mid layui-word-aux">截取图片的宽高，如320x180，留空表示跟视频保持一致</div>
					</div>
			    </div>
				<!-- 水印字幕设置 -->
			    <div class="layui-tab-item">
					<div class="layui-form-item">
						<label class="layui-form-label">水印位置</label>
						<div class="layui-input-inline">
							<select name="Zm_Sy">
	      						<option value="0" <?=Zm_Sy==0?'selected':''?>>关闭</option>
								<option value="1" <?=Zm_Sy==1?'selected':''?>>左上</option>
								<option value="2" <?=Zm_Sy==2?'selected':''?>>右上</option>
								<option value="3" <?=Zm_Sy==3?'selected':''?>>左下</option>
								<option value="4" <?=Zm_Sy==4?'selected':''?>>右下</option>
                            </select>
						</div>
						<div class="layui-form-mid layui-word-aux">视频切片水印位置</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">水印间距</label>
						<div class="layui-input-inline">
							<input type="text" name="Zm_Sylt" placeholder="" autocomplete="off" class="layui-input" value="<?=Zm_Sylt?>">
						</div>
						<div class="layui-form-mid layui-word-aux">水印间距，如：10:10</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">字幕开关</label>
						<div class="layui-input-inline">
      						<input type="radio" name="Zm_Zm" value="0" title="关闭" <?=Zm_Zm==0?'checked':''?>>
							<input type="radio" name="Zm_Zm" value="1" title="开启" <?=Zm_Zm==1?'checked':''?>>
						</div>
						<div class="layui-form-mid layui-word-aux">视频字幕开关</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">字幕内容</label>
						<div class="layui-input-inline" style="width: 500px;">
							<textarea type="text" name="Zm_Zmtxt" placeholder="字幕内容" class="layui-textarea"><?=$zimu?></textarea>
						</div>
						<div class="layui-form-mid layui-word-aux">字幕内容</div>
					</div>
			    </div>
				<!-- 上传设置 -->
			    <div class="layui-tab-item">
					<div class="layui-form-item">
						<label class="layui-form-label">上传路径</label>
						<div class="layui-input-inline">
							<input type="text" name="Up_Dir" placeholder="请输入视频上传保存的路径" autocomplete="off" class="layui-input" value="<?=Up_Dir?>">
						</div>
						<div class="layui-form-mid layui-word-aux">视频上传存储路径，如：F:/video/，网站目录请用./开头</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">支持格式</label>
						<div class="layui-input-inline">
							<input type="text" name="Up_Ext" placeholder="请输入上传支持的格式" autocomplete="off" class="layui-input" value="<?=Up_Ext?>">
						</div>
						<div class="layui-form-mid layui-word-aux">上传支持的格式，如：mp4|mkv|flv</div>
					</div>
			    </div>
				<!-- 其他设置 -->
				<div class="layui-tab-item layui-show">
					<div class="layui-form-item">
						<label class="layui-form-label">m3u8保留</label>
						<div class="layui-input-inline">
							<input type="radio" name="Del_M3u8" value="0" title="保留" <?=Del_M3u8==0?'checked':''?>>
      						<input type="radio" name="Del_M3u8" value="1" title="不保留" <?=Del_M3u8==1?'checked':''?>>
						</div>
						<div class="layui-form-mid layui-word-aux">删除视频是否保留切片后的M3U8文件</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">源文件保留</label>
						<div class="layui-input-inline">
							<input type="radio" name="Del_Mp4" value="0" title="保留" <?=Del_Mp4==0?'checked':''?>>
      						<input type="radio" name="Del_Mp4" value="1" title="不保留" <?=Del_Mp4==1?'checked':''?>>
						</div>
						<div class="layui-form-mid layui-word-aux">切片后是否保留上传源文件</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">会员注册</label>
						<div class="layui-input-inline">
							<input type="radio" name="Web_Reg" value="0" title="通过" <?=Web_Reg==0?'checked':''?>>
      						<input type="radio" name="Web_Reg" value="1" title="待审" <?=Web_Reg==1?'checked':''?>>
						</div>
						<div class="layui-form-mid layui-word-aux">默认会员注册是否需要审核</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客服QQ</label>
						<div class="layui-input-inline">
							<input type="text" name="Admin_QQ" placeholder="请输入客服QQ" autocomplete="off" class="layui-input" value="<?=Admin_QQ?>">
						</div>
						<div class="layui-form-mid layui-word-aux">请输入客服QQ，如：157503886</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">交流群号</label>
						<div class="layui-input-inline">
							<input type="text" name="Admin_Qun" placeholder="请输入交流群号" autocomplete="off" class="layui-input" value="<?=Admin_Qun?>">
						</div>
						<div class="layui-form-mid layui-word-aux">请输入交流群号</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">网站公告</label>
						<div class="layui-input-inline" style="width: 450px;">
							<textarea type="text" name="Web_Gg" placeholder="网站公告" class="layui-textarea"><?=Web_Gg?></textarea>
						</div>
						<div class="layui-form-mid layui-word-aux">网站公告</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">统计代码</label>
						<div class="layui-input-inline" style="width: 450px;">
							<textarea type="text" name="Admin_Count" placeholder="统计代码" class="layui-textarea"><?=Admin_Count?></textarea>
						</div>
						<div class="layui-form-mid layui-word-aux">请输入统计代码</div>
					</div>
				</div>
			    <div class="layui-form-item">
					<div class="layui-input-block" style="padding-top: 10px">
						<button class="layui-btn layui-btn2" lay-filter="setting" lay-submit>立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">取消重置</button>
					</div>
				</div>
			</div>
		</div>    
		</form>
		<script src="/packs/admin/js/common.js"></script>
		<script type="text/javascript">
			layui.use(['form','element'], function(){
				var form = layui.form;
				var element = layui.element;
				element.tabChange('setting', 'set1');
			});
		</script>
	</body>
</html>