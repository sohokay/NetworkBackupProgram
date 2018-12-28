<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="UTF-8">
<title>会员登录 - <?=Web_Name?> - 永久免费的CDN多媒体网盘 - <?=Web_Url?></title>
<link rel='stylesheet' href='/packs/layui/css/layui.css'>
<script type='text/javascript' src='/packs/layui/layui.js'></script>
<link rel="stylesheet" href="/packs/assets/login/css/login.css">
<script src="/packs/jquery/jquery.min.js"></script>
</head>
<body class="">
<div class="login-body">
	<div class="login-wrapper" style="background-image:url(/packs/assets/login/images/qcloud-login-bg.jpg)">
		<div class="login-inner">
			<div class="lg-aside">
				<div class="lg-logo">
					<a href="#" hotrep="login.index.header.logo"><i class="lg-logo-icon"></i></a>
				</div>
				<div class="lg-aside-event">
					<div class="lg-aside-event-tit">
						<div class="lg-aside-event-icon">
							<img src="/packs/assets/login/images/icon.svg" alt="">
						</div>
						<h2>免费多媒体云盘系统</h2>
					</div>
					<div class="lg-aside-event-con">
						<div class="lg-aside-event-txt">
							<icon class="lg-aside-event-txt-icon"></icon><span>全球领先的云转码服务平台</span>
						</div>
						<div class="lg-aside-event-txt">
							<icon class="lg-aside-event-txt-icon"></icon><span>高质量、高稳定性的CDN服务</span>
						</div>
						<div class="lg-aside-event-txt">
							<icon class="lg-aside-event-txt-icon"></icon><span>永久免费的网盘解决方案</span>
						</div>
					</div>
				</div>
			</div>
 			<form class="layui-form layui-form-pane" action="<?=links('login','save')?>" method="post">
			<div class="lg-content">
				<div class="qc-pt-login-content" id="loginBox">
					<div class="qc-pt-login-content J-commonLoginContent">
						<div class="login-tab">
							<h1 class="login-tab-title J-txtLoginTitle">会员登录</h1>
							<div class="login-box J-loginContentBox J-qcloginBox" style="">
								<div class="login-form">
									<ul class="form-list">
										<li>
										<div class="form-input">
											<div class="form-unit tip-unit">
												  <input type="text" name="name" required lay-verify="required" autocomplete="off" placeholder="注册帐号" value="" class="qc-log-input-text lg J-username">
											</div>
										</div>
										</li>
										<li>
										<div class="form-input">
											<div class="form-unit">
												<label class="input-tips" style="display:none">密码</label><input class="qc-log-input-text lg J-password" type="password" name="pass" required lay-verify="required" autocomplete="off" placeholder="请输入您的密码" value="">
											</div>
										</div>
										</li>
										<li  class="J-vcodeArea">
										<div class="form-input fm-security">
											<div class="form-unit">
												<label class="input-tips" style="display:none">验证码</label>
												<input type="text" name="code" required lay-verify="required" autocomplete="off  value="" class="qc-log-input-text J-vcodeInput" placeholder="验证码" style="width:124px"><a href="javascript:reloadCodes();" title="看不清楚？点击更换验证码" class="verifyimg security-num J-changeVCode"><img src="<?=links('code')?>" class="security-img J-vcodeImg verifyimg"></a>
											</div>
										</div>
										</li>
									</ul>
								</div>
								<div class="op-btn">
					 				<button class="qc-log-btn J-loginBtn" lay-submit lay-filter="*" ><input type="button"  value="登 录"  class="qc-log-btn J-loginBtn">	</button>
									<div class="psw-info">
										<a href="<?=links('reg')?>" class="forgot-psw J-link" >还没有帐号？立即注册</a>
										<!--a class="forgot-psw J-link" >&nbsp;审核联系群管理员&nbsp;</a-->	
									</div>
								</div>
             				</form>
							</div>
							<div class="outside-login">
								<div class="outside-login-tit">
									<span class="J-txtMoreLoginType">QQ交流②群：<?=Admin_Qun?></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>      
	  	<div id="main">
		    <div class="biank" style=" margin-top:35px;">
		    	<h2>推广合作</h2>
		        <div class="link">
		        <a href="tencent://message/?uin=<?=Admin_QQ?>&amp;Site=在线客服&amp;Menu" target="_blank"> <font color="#f00">官方收量，全网最高价包站➕  qq: <?=Admin_QQ?> </font></a>
		        <a href=" http://www.ctcms.cn/" target="_blank"> 赤兔CMS影视 </a>
		        <a href="http://www.seacms.net/" target="_blank"> 海洋CMS影视 </a>
		        <a href="#" target="_blank">QQ交流群：<?=Admin_Qun?></a>
		        </div>
		    </div>
		</div>                                           
		<div class="lg-footer">
			<div class="lg-footer-inner">
				<div class="copyright">
					<p class="tag-line">
						<script>document.write(new Date().getFullYear());</script>&copy; 版权所有
             			<span><?=Web_Url?></span> &nbsp;|&nbsp;永久免费的CDN多媒体网盘
					</p>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="/packs/assets/js/common.js"></script>
<div style="display:none;"><?=str_decode(Admin_Count)?></div>                                           
</body>
</html>
