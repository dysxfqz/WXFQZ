<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../static/inc/taglib.jsp"%>
<html>
<head>
<title>欢迎</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="description" content="User login page" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="shortcut icon" type="image/x-icon" href="${ctxPath}/static/source/img/favicon.ico">

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap.css" />
<link rel="stylesheet" href="${ctxPath}/static/ace/css/font-awesome.css" />

<!-- text fonts -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace.css" />



<!--[if lte IE 9]>
	<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-part2.css" />
<![endif]-->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-rtl.css" />

<!--[if lte IE 9]>
  <link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-ie.css" />
<![endif]-->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="${ctxPath}/static/ace/js/html5shiv.js"></script>
<script src="${ctxPath}/static/ace/js/respond.js"></script>
<![endif]-->
<!-- change ace style-->
<link rel="stylesheet" href="${ctxPath}/static/source/style/changeace.css" />
<!-- this page styles -->
<link rel="stylesheet" href="${ctxPath}/static/source/style/login.css" />
<style>
	.welcomeDiv{
	    width: 900px;
	    margin: 0 auto;
	    position: absolute;
	    left: 0;
	    right: 0;
	}
	.welcomeDiv .alert{
	    display: inline-block;
	    width: 210px;
	    background: #3879D9;
	    color: #fff;
	    margin-bottom: 4px;
	    height: 150px;
	    vertical-align: middle;
	    font-size: 16px;
	    font-weight: bold;
	    cursor: pointer;
	}
</style>
</head>
<body >
	<div class="col-xs-12 welcomeDiv">
	    <span class="alert">基于大数据的高风险纳税人定向稽查引擎</span>
		<span class="alert">基于大数据的税收征管数据质量评级与分析引擎</span>	
		<span class="alert">基于大数据的大企业纳税遵从智能分析引擎</span>
		<span class="alert">基于大数据的税收收入能力预测引擎</span>
		<span class="alert">基于大数据的税收收入能力估算引擎</span>
		<span class="alert">基于大数据的税收经济政策效应引擎</span>
		<span class="alert">基于大数据的税收分类分级管理引擎</span>
		<span class="alert">基于大数据的纳税信用智能评定引擎</span>
		<span class="alert">基于大数据的税收征管质量评价引擎</span>		
		<span class="alert">基于大数据的企业所得税税鉴引擎</span>
		<span class="alert">基于大数据增值税防伪分析引擎</span>
		<span class="alert">基于大数据的税源智能分析引擎</span>

	
	</div>
	 <!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
	<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script src="${ctxPath}/static/ace/js/bootbox.js"></script>

<script src='${ctxPath}/static/source/js/cookie.js'></script>
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='${ctxPath}/static/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>
	<script>
	$(function(){
		$(".welcomeDiv").css({ "margin-top": (document.documentElement.clientHeight - $(".welcomeDiv").height())/2});
	});
	$(".welcomeDiv span").click(function(){
		var system_logo_new = $(this).html();
		if(system_logo_new.length>16){
			system_logo_new = system_logo_new.substring(6,system_logo_new.length);
		}
		var system_logo_name ='system_logo';
		$.ajax({
			url:"${ctxPath}/v1/anon/manage/systemManage/update/saveSystem.do",
			type:"post",
			dataType:"json",
			data:{
				system_logo_new:system_logo_new,
				system_logo_name:system_logo_name
			},
			success:function(data){
				if(data.result=="ok"){
					window.location.href="${ctxPath}/v1/anon/user/login/goLogin.do";
				}else{
					window.location.reload();
				}
			},
			error:function(){
				window.location.reload();
			}
		});
	});
	
	</script>	
</body>
</html>
