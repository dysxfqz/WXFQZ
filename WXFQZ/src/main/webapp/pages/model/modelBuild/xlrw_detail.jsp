<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>详情</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>详情</h1>
			<span class="detailGoBack">返回</span>
		</div>
		<div class="widgetDiv">
		
			<div class="row">
	           	<span class="widgetMc">${xlrw.mc}</span>
	            <span class="rightCirContent">
	           		<span class="proCircle">
	           			<span class="progessCircle zhuan <c:if test='${(xlrw.jd== 0 && xlrw.zt<2)||(xlrw.jd+1== 0 && xlrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${xlrw.jd >0 || (xlrw.zt==2 && xlrw.jd ==0)}'>active</c:if> <c:if test="${xlrw.zt==3 && xlrw.jd ==0}"> circleError</c:if>">1</span><br>
			           	<span class="progessTitle">数据采集</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars" style="height:6px">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${xlrw.jd >1 ||(xlrw.zt==2&&xlrw.jd>0)}'>default</c:if><c:if test='${(xlrw.jd== 1 && xlrw.zt<2)||(xlrw.jd+1== 1 && xlrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${xlrw.jd >1 ||(xlrw.zt==2&&xlrw.jd>0)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${(xlrw.jd== 1 && xlrw.zt<2)||(xlrw.jd+1== 1 && xlrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
		          	 	<span class="progessCircle <c:if test='${xlrw.jd >1 || (xlrw.zt==2 && xlrw.jd ==1)}'>active</c:if><c:if test="${xlrw.zt==3 && xlrw.jd ==1}"> circleError</c:if>">2</span><br>
		           		<span class="progessTitle">数据清洗</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${xlrw.jd >2  ||(xlrw.zt==2&&xlrw.jd>1)}'>default</c:if><c:if test='${(xlrw.jd== 2 && xlrw.zt<2)||(xlrw.jd+1== 2 && xlrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${xlrw.jd >2  ||(xlrw.zt==2&&xlrw.jd>1)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           	<span class="progessCircle zhuan <c:if test='${(xlrw.jd== 2 && xlrw.zt<2)||(xlrw.jd+1== 2 && xlrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${xlrw.jd >2 || (xlrw.zt==2 && xlrw.jd ==2)}'>active</c:if><c:if test="${xlrw.zt==3 && xlrw.jd ==2}"> circleError</c:if>">3</span><br>
			           		<span class="progessTitle">训练预测</span>
		           	</span>
		           	<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${xlrw.jd >3  ||(xlrw.zt==2&&xlrw.jd>2)}'>default</c:if> <c:if test='${(xlrw.jd== 3 && xlrw.zt<2)||(xlrw.jd+1== 3 && xlrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${xlrw.jd >3  ||(xlrw.zt==2&&xlrw.jd>2)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${xlrw.jd== 3 && xlrw.zt<2}'>active</c:if>" style="position:absolute"></span>
		           		<span class="progessCircle <c:if test='${xlrw.jd >3 || (xlrw.zt==2 && xlrw.jd ==3)}'>active</c:if> <c:if test="${xlrw.zt==3 && xlrw.jd ==3}"> circleError</c:if>">4</span><br>
		           		<span class="progessTitle">结果处理</span>
		           	</span>
	           	</span>
			</div>
		
			<table class="table table-info table-striped table-bordered">
				<tbody>
					<tr>
						<td>任务名称:</td>
						<td>${xlrw.mc}</td>
					</tr>
					<tr>
						<td>税种:</td>
						<td>${xlrw.mx.szmc}</td>
					</tr>
					<tr>
						<td>行业:</td>
						<td>
							<c:if test="${xlrw.hy==''}">全部</c:if>
							<c:if test="${xlrw.hy!=''}">${xlrw.hy}</c:if>
						</td>
					</tr>
					<tr>
						<td>城市:</td>
						<td>${xlrw.mx.csmc}</td>
					</tr>
					<tr>
						<td>登记注册类型:</td>
						<td>
							<c:if test="${xlrw.djzclx==''}">全部</c:if>
							<c:if test="${xlrw.djzclx!=''}">${xlrw.djzclx}</c:if>
						</td>
					</tr>
					<tr>
						<td>核算方式:</td>
						<td>
							<c:if test="${xlrw.mx.hsfsmc==''}">全部</c:if>
							<c:if test="${xlrw.mx.hsfsmc!=''}">${xlrw.mx.hsfsmc}</c:if>
						</td>
					</tr>
					<tr>
						<td>企业规模:</td>
						<td>${xlrw.mx.qygm}</td>
					</tr>
					<tr>
						<td>时间维度:</td>
						<td>
							<c:if test="${(xlrw.sjkssj == '' || xlrw.sjkssj == null) && (xlrw.sjjssj == '' || xlrw.sjjssj == null)}">所有 </c:if>
							<c:if test="${(xlrw.sjkssj != null && xlrw.sjkssj != '') || (xlrw.sjjssj != null && xlrw.sjjssj != '')}">
								<fmt:formatDate value="${xlrw.sjkssj }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${xlrw.sjjssj }" pattern="yyyy-MM-dd"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>任务阶段:</td>
						<td class="jieduan"><c:if test="${xlrw.jd == 0}">数据采集 </c:if><c:if test="${xlrw.jd == 1}">数据清洗</c:if><c:if test="${xlrw.jd == 2}">训练预测</c:if><c:if test="${xlrw.jd == 3}">结果处理</c:if></td>
					</tr>
					<tr>
						<td>任务状态:</td>
						<td class="taskStatus"><c:if test="${xlrw.zt == 0}">待处理 </c:if><c:if test="${xlrw.zt == 1}">处理中</c:if><c:if test="${xlrw.zt == 2}">处理成功</c:if><c:if test="${xlrw.zt == 3}">处理失败</c:if></td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
$(function(){
	var oTable1 =$('#resultDetailList').dataTable( {
			bStateSave: true,
			bAutoWidth: false,
			"aaSorting": [],
			"aoColumnDefs": [
				{
				 sDefaultContent: '',
				 aTargets: [ '_all' ]
				  }
				],
	    } );
});
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/modelBuild/taskManage/list.do";
});
</script>
</body>

</html>
