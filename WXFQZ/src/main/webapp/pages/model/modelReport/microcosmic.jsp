<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>微观</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>微观</h1>
		</div>
			<ul class="echartImgs">
			<li>
				<a href="${ctxPath}/v1/html/modelBuild/modelResult/list.do"><img src="${ctxPath}/static/source/img/image/echart11.png"></a>
				<div class="echartsImgTitle">一户式报告</div>
			</li>
			<li>
				<a href="${ctxPath}/v1/html/modelReport/microcosmic/picture1.do"><img src="${ctxPath}/static/source/img/image/chart6.png"></a>
				<div class="echartsImgTitle">企业关联关系网状图</div>
			</li>
			<li>
				<a href="${ctxPath}/v1/html/modelReport/microcosmic/picture2.do"><img src="${ctxPath}/static/source/img/image/chart8.png"></a>
				<div class="echartsImgTitle">中国企业发票流向图</div>
			</li>
			<li>
				<a href="#"><img src="${ctxPath}/static/source/img/image/echart10.png"></a>
				<div class="echartsImgTitle">基于不同主题下企业维度分析</div>
			</li>
		</ul>
	</div>
</body>
</html>