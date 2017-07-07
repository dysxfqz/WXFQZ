<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>技术支持</title>
<style>
	.technicP{
		line-height:30px;
		margin-top:25px;
		margin-left:0;
	}
	.technicP ul li{text-align:center}
	.technicDiv{
	    width: 400px;
	    border: 1px solid #ccc;
	    text-align: center;
	    padding-bottom:20px;
	    margin: 0 auto;
	    border-radius: 10px;
	}
	.table-header{
		border-top-left-radius: 10px;
	    border-top-right-radius: 10px;
	    text-align: left;
	}
</style>
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>技术支持</h1>
	</div>
	<div class="technicDiv">
		<div class="table-header">在线客服     （周一至周五早9:00—晚6:00）</div>
		<ul class="technicP">
			<li>技术人员1：13601177082</li>
			<li>技术人员2：18911504572</li>
			<li>技术人员3：18103265296</li>
			<li>技术人员4：17346559452</li>
		</ul>
	</div>
</div>
<script>
	function technicDivP(){
		var marginT = (document.documentElement.clientHeight-$(".technicDiv").height()-100)/4;
		$(".technicDiv").css("margin-top",marginT);
	}
	$(function(){
		technicDivP();
	});
	$(window).resize(function(){
		technicDivP();
	});
</script>
</body>
</html>