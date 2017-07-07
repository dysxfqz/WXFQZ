<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../static/inc/taglib.jsp"%>
<html>
  <head>
    <title>邮箱验证</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="description" content="User login page" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

		<link rel="stylesheet" href="${ctxPath}/static/source/style/changeace.css" />
		<script src='${ctxPath}/static/ace/js/jquery.min.js'></script>
		<script>
		//fck路径
		var fckPath="${ctxPath}/static/";
		try {
			ace.settings.check('navbar', 'fixed')
		} catch (e) {
		}
		</script>
	
  </head>
  <body>
  	<div id="navbar" class="navbar navbar-default navbar-fixed-top">

	<div class="navbar-container" id="navbar-container">
			<!-- #section:basics/sidebar.mobile.toggle -->
			<button type="button" class="navbar-toggle menu-toggler pull-left"
				id="menu-toggler" data-target="#sidebar">
				<span class="sr-only">Toggle sidebar</span> <span class="icon-bar"></span>
	
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<div class="navbar-header pull-left">
				<!-- #section:basics/navbar.layout.brand -->
				<a href="${ctxPath}" class="navbar-brand"> <small> <i
						class="fa fa-leaf"></i> 中数博阳
				</small>
				</a>
			</div>
		</div>
	</div>
	<div class="col-xs-12" style="margin-top: 50px">
		<div class="header smaller lighter blue">
			<h1>绑定邮箱</h1>
		</div>
		<div class="alert alert-info" style="text-align: center; font-size: 22px;">
			<span >${msg}</span>
		</div>
		<div style="text-align: center;">
		
			<span id="msg" ><span id="goTime">10</span>秒后自动跳回登录页面</span>
			<a href="${ctxPath}/v1/anon/user/login/goLogin.do">登录我的中数云</a>
		</div>
	</div>
	<script>
	var gt = 10;
	var golog = setInterval(function(){
		gt--;
		$("#goTime").html(gt);
	},1000);
	setTimeout(function(){
		clearInterval(golog);
		window.location.href = "${ctxPath}/";
	},10000);

	//返回登录页面
	function returnLogin () {
		window.location.href = "${ctxPath}/v1/anon/user/login/goLogin.do";
	}
	//返回系统个人信息页面
	function returnUserInfo () {
		window.location.href = "${ctxPath}/v1/anon/user/login/goLogin.do";
	}
	</script>
  </body>
</html>
