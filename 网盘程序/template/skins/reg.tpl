<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<title>会员注册 - <?=Web_Name?> - 永久免费的CDN多媒体网盘 - <?=Web_Url?></title>
<link rel='stylesheet' href='/packs/layui/css/layui.css'>
<link rel="stylesheet" href="/packs/assets/login/css/login.css">
<script type='text/javascript' src='/packs/layui/layui.js'></script>
<script type='text/javascript' src="/packs/jquery/jquery.min.js"></script>
<style>
	.b-title{
		overflow: hidden;
	}
	.regist-last-txt{
		float: right;
		padding-top: 10px;
	}
	.regist-last-txt a{
		color: #2277da;
	}
	.regist-last-txt a:hover{
		text-decoration: underline;
	}
	@media screen and (max-width: 768px){
		.regist-last-txt{
			display: none;
		}
	}
</style>
</head>
<body>
<div class="body">
	<div class="regist-wrapper">
		<div class="regist-header ">
		<a href="#" class="logo zh"></a>
		</div>
		<div class="regist-content ">
			<div class="ct-inner">
				<div class="tab">
				<form class="layui-form layui-form-pane" action="<?=links('reg','save')?>" method="post">
					<div class="regist-form" data-formtype="mail">
						<ul class="form-list">
							<li>
							<div class="form-input">
								<div class="form-unit tip-unit">
									<label class="input-tips J-placeholder">账号</label>
                   					<input type="text" id="username" name="name" required lay-verify="required" autocomplete="off" placeholder="请填写账号" value="" class="qc-log-input-text lg">
								</div>
							</div>
							</li>
							<li>
							<div class="form-input">
								<div class="form-unit">
								<label class="input-tips J-placeholder">密码</label>
								 <input type="password" id="userpass" name="pass" required lay-verify="required" autocomplete="off" placeholder="请填写一个6-20位的密码" value="" class="qc-log-input-text lg">
								</div>
							</div>
							</li>
							<li>
							<div class="form-input">
								<div class="form-unit">
									<label class="input-tips J-placeholder">确认密码</label>
							  		<input type="password" name="repass" required lay-verify="required" autocomplete="off" placeholder="请确认填写的密码" value="" class="qc-log-input-text lg">
								</div>
							</div>
							</li>
							<li>
							<div class="form-input">
								<div class="form-unit tip-unit">
									<label class="input-tips J-placeholder">请填写正确的邮箱地址</label>
									<input type="text" name="email" required lay-verify="email" autocomplete="off" placeholder="请填写正确的邮箱地址" value="" class="qc-log-input-text lg"">
								</div>
							</div>
							</li>
							<li>
							<div class="form-input fm-verify">
								<div class="form-unit">
									<label class="input-tips J-placeholder">验证码</label>
                  					<input type="text" name="code" required lay-verify="required" autocomplete="off" placeholder="请填写右侧的验证码" value="" class="qc-log-input-text">
               						<a style="float:right;margin-right:30px;width: 180px;height: 50px;" href="javascript:reloadCodes();" title="看不清楚？点击更换验证码" style="height: 36px;display: block;float: left;border: 1px solid #e2e2e2;"><img src="<?=links('code')?>" class="verifyimg"></a>
								</div>
							</div>
							</li>
						</ul>
					</div>
					<div class="op-btn">
						<button class="qc-log-btn lg" lay-submit lay-filter="*">确认注册</button>
          			</div>
					</form>
					<div class="sp-line">
						<span class="line"></span>
						<a href="#" class="title links">QQ交流①群：<?=Admin_Qun?></a>
					</div>
				</div>
			</div>
		</div>
		<div class="regist">
			<p class="tag-line">
				已有账号？
				<a class="link" href="<?=links('login')?>">立即登录</a>
			</p>
		</div>
	</div>
	<div class="lg-footer J-loginLanguage">
		<div class="copyright">
			<p class="tag-line">
				<script>document.write(new Date().getFullYear());</script>&copy; 版权所有
     			<span><?=Web_Url?></span> &nbsp;|&nbsp;永久免费的CDN多媒体网盘
			</p>
		</div>
	</div>
	<script src="/packs/assets/js/common.js"></script>
	<div style="display:none;"><?=str_decode(Admin_Count)?></div>
</body>
</html>