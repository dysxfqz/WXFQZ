<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>结果概览</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
<style>
	#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>结果概览</h1>
		</div>
		<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>任务名称</th>
					<th>税种</th>
					<th>行业</th>
					<th>城市</th>
					<th>登记注册类型</th>
					<th>核算方式</th>
					<th>企业规模 </th>
					<th>时间维度</th>
					<th>任务阶段</th>
					<th>任务状态</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ycjgList}" var="bean" varStatus='status'>
					<tr>
						<td>${bean.mc}</td>
						<td>${bean.mx.szmc}</td>
						<td>${bean.hy}</td>
						<td>${bean.mx.csmc}</td>
						<td>${bean.djzclx}</td>
						<td>${bean.mx.hsfsmc}</td>
						<td>${bean.mx.qygm }</td>
						<td><fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM-dd"/></td>
						<td><c:if test="${bean.jd == 0}">数据采集 </c:if><c:if test="${bean.jd == 1}">数据清洗</c:if><c:if test="${bean.jd == 2}">训练预测</c:if><c:if test="${bean.jd == 3}">结果处理</c:if></td>
						<td><c:if test="${bean.zt == 0}">待处理 </c:if><c:if test="${bean.zt == 1}">处理中</c:if><c:if test="${bean.zt == 2}">处理成功</c:if><c:if test="${bean.zt == 3}">处理失败</c:if></td>
						<td align="center">
							<a href="" title="模型评价">模型评价</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(function(){
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
			$(".meuListDiv").css("width",$("#menuList").width());
	});
	</script>
</body>
</html>