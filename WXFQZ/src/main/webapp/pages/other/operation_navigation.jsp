<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>操作导航</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>操作导航</h1>
	</div>
	<div class="widgetDiv">
		
			<div class="row" style="min-width:auto;text-align:center">
	            <span class="rightCirContent">
	           		<span class="proCircle">
<%-- 	           			<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 0 && fxrw.zt<2)||(fxrw.jd+1== 0 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span> --%>
			           	<span class="progessCircle active">1</span><br>
			           <span class="progessTitle"><a href="${ctxPath}/v1/html/analyse/task/add.do">新建任务</a></span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars" style="height:6px">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >1 ||(fxrw.zt==2&&fxrw.jd>0)}'>default</c:if><c:if test='${(fxrw.jd== 1 && fxrw.zt<2)||(fxrw.jd+1== 1 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >1 ||(fxrw.zt==2&&fxrw.jd>0)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
<%-- 		           		<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 1 && fxrw.zt<2)||(fxrw.jd+1== 1 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span> --%>
		          	 	<span class="progessCircle active">2</span><br>
		           		<span class="progessTitle"><a href="javascript:void(0)">执行任务</a></span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >2  ||(fxrw.zt==2&&fxrw.jd>1)}'>default</c:if><c:if test='${(fxrw.jd== 2 && fxrw.zt<2)||(fxrw.jd+1== 2 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >2  ||(fxrw.zt==2&&fxrw.jd>1)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
<%-- 		           	<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 2 && fxrw.zt<2)||(fxrw.jd+1== 2 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span> --%>
			           	<span class="progessCircle active">3</span><br>
			           	<span class="progessTitle"><a href="${ctxPath}/v1/html/analyse/result/resultList.do">分析结果</a></span>
		           	</span>
		           	<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >3  ||(fxrw.zt==2&&fxrw.jd>2)}'>default</c:if> <c:if test='${(fxrw.jd== 3 && fxrw.zt<2)||(fxrw.jd+1== 3 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >3  ||(fxrw.zt==2&&fxrw.jd>2)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
<%-- 		           		<span class="progessCircle zhuan <c:if test='${fxrw.jd== 3 && fxrw.zt<2}'>active</c:if>" style="position:absolute"></span> --%>
		           		<span class="progessCircle active">4</span><br>
		           		<span class="progessTitle"><a href="${ctxPath}/v1/html/analyse/result/resultList.do">生成报告</a></span>
		           	</span>
	           	</span>
			</div> 
			</div>
</div>
</body>
</html>