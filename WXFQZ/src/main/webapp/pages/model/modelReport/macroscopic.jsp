<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>宏观</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>资源配置</h1>
		</div>
		<ul class="echartImgs">
			<li>
				<a href="${ctxPath}/v1/html/modelReport/macroscopic/picture1.do"><img src="${ctxPath}/static/source/img/image/chart2.png"></a>
				<div class="echartsImgTitle">内蒙地区主要地市税收征管资源禀赋</div>
			</li>
			<li>
				<a href="${ctxPath}/v1/html/modelReport/macroscopic/picture2.do"><img src="${ctxPath}/static/source/img/image/chart3.png"></a>
				<div class="echartsImgTitle">北京地区税收收入状况</div>
			</li>
			<li>
				<a href="${ctxPath}/v1/html/modelReport/macroscopic/picture3.do"><img src="${ctxPath}/static/source/img/image/echart12.png"></a>
				<div class="echartsImgTitle">北京地区各区营业收入状况</div>
			</li>
		</ul>
		
		<div class="header smaller lighter blue">
			<h1>经济增长</h1>
		</div>
		<ul class="echartImgs">
			<li>
				<a href="${ctxPath}/v1/html/modelReport/macroscopic/picture4.do"><img src="${ctxPath}/static/source/img/image/chart9.png"></a>
				<div class="echartsImgTitle">内蒙地区GDP与税收收入发展状况</div>
			</li>

		</ul>
		
		<div class="header smaller lighter blue">
			<h1>经济稳定</h1>
		</div>
		<ul class="echartImgs">
			<li>
				<a href="${ctxPath}/v1/html/modelReport/macroscopic/picture5.do"><img src="${ctxPath}/static/source/img/image/chart10.png"></a>
				<div class="echartsImgTitle">内蒙地区税收收入波动情况</div>
			</li>

		</ul>
	</div>
</body>
</html>