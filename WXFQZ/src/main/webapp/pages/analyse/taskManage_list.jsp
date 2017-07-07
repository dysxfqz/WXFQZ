<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>任务管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>任务管理</h1>
	</div>
	<a href="${ctxPath}/v1/html/analyse/task/add.do" class="btn btn-app btn-success newTaxBtn" style="margin-bottom:10px;">新建任务</a>
	<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table id="menuList" class="table table-striped table-bordered table-hover danHTable">
			<thead>
				<tr>
					<th>任务名称</th>
					<th style="width:104px">税款所属期</th>
					<th style="width:104px">主管税务机关</th>
					<th>行业</th>
					<th>税种</th>
					<th>登记类型</th>
					<th>任务阶段</th>
					<th>任务状态</th>
					<th class="center" style="width:120px">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${fxrwList}" var="bean" varStatus='status'>
					<tr>
						<td><div title="${bean.mc}">${bean.mc}</div></td>
						<td title="<fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM"/>"><div><fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM"/></div></td>
						<td><div>${bean.swjgCjMc}</div></td>
						<td><div>
							<c:if test="${bean.hy==''}">全部</c:if>
							<c:if test="${bean.hy!=''}">${bean.hy}</c:if>
						</div></td>
						<td><div>${bean.sz}</div></td>
						<td><div><c:if test="${bean.djzclx==''}">全部</c:if><c:if test="${bean.djzclx!=''}">${bean.djzclx}</c:if></div></td>
						<td class="jieduan"><c:if test="${bean.jd == 0}">数据采集 </c:if><c:if test="${bean.jd == 1}">数据清洗</c:if><c:if test="${bean.jd == 2}">训练预测</c:if><c:if test="${bean.jd == 3}">结果处理</c:if><c:if test="${bean.jd == 4}">生成报告</c:if></td>
						<td class="taskStatus" <c:if test="${bean.zt == 3}">style="color:red"</c:if>><c:if test="${bean.zt == 0}">待处理 </c:if><c:if test="${bean.zt == 1}">处理中</c:if><c:if test="${bean.zt == 2}">处理成功</c:if><c:if test="${bean.zt == 3}">处理失败</c:if>
						<td class="center operateAc">
						<a href="${ctxPath}/v1/html/analyse/taskManage/detail.do?taskId=${bean.rwh}">详情 </a>
						<c:if test="${bean.zt == 2 && bean.jd == 4 }">
							/<a href="${ctxPath}/v1/html/analyse/result/detail.do?TASKID=${bean.rwh}" title="结果概览">概览</a>/
							<a href="${ctxPath}/v1/html/analyse/result/taxpayerList.do?TASKID=${bean.rwh}" title="测算报告">报告</a>
						</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		</div>
	</div>
	<div class="iso_alert">
	<div class="iso_alertKuang col-xs-12 col-sm-6">
<!-- 弹出层 -->
		<div class="editTask">
			<div class="iso_alertHeader">
				<h2 class="iso_alertTitle">编辑任务</h2>
				<span id="closeEditTask" class="close_alertIso">&times;</span>
				<hr>
			</div>
			<div class="iso_alertBody">
				<form class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label no-padding-right">名称*</label>
			<div class="col-sm-9">
				<div class="input-group col-xs-12">
					<input class="form-control input-mask-date" id="taskNameInp" type="text" value="">
					<div class="errorTip"></div>
				</div>
			</div>
		</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right">描述</label>
				<div class="col-sm-9">
					<textarea class="col-xs-12" rows="4" id="taskDecInp"></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right"></label>
				<div class="col-sm-9">
					<span class="goSubmit" id="editTaskBtn" data-rwh="">提交</span>
				</div>
			</div>
		</form>
			</div>
		</div>
	</div>
</div>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
	<script type="text/javascript">
	$(function(){
		 $("[data-toggle='tooltip']").tooltip();
		var oTable1 =$('#menuList').dataTable( {
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
			//$(".meuListDiv").css("width",$("#menuList").width());
	});
	function resizeIsoAlert(){
		 var isoAlert = {height:0,width:0,left:0,top:0};
		 isoAlert.height = $(".iso_alertKuang").height();
		 isoAlert.width = $(".iso_alertKuang").width();
		 isoAlert.top = (document.documentElement.clientHeight- isoAlert.height)/2;
		 if(document.documentElement.clientWidth<768){
			 isoAlert.left = 0;
		 }else{
			 isoAlert.left = (document.documentElement.clientWidth- isoAlert.width)/2;
		 }
		 $(".iso_alertKuang").css({
			 left:isoAlert.left,
			 top:isoAlert.top
		 });
	}
	 $(window).resize(function(){
		 resizeIsoAlert();
	 });
	
	</script>
</body>
</html>