<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>智能导入列表</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>智能导入列表</h1>
		</div>
		<a href="${ctxPath}/v1/html/data/dataCollect/cleverImport/add.do" class=" btn btn-app btn-success newTaxBtn" style="margin-bottom:10px;">新建</a>
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>数据源号</th>
					<th>名称</th>
					<th>描述</th>
					<th>状态 </th>
					<th>时间维度</th>
					<th>创建时间</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${xlsjyList}" var="bean" varStatus='status'>
					<tr>
						<td class="center">${status.index +1 }</td>
						<td>${bean.sjyh}</td>
						<td>${bean.mc}</td>
						<td>${bean.ms}</td>
						<td><c:if test="${bean.zt == 0}">待处理</c:if>
						<c:if test="${bean.zt == 1}">处理中</c:if>
						<c:if test="${bean.zt == 2}">处理成功</c:if>
						<c:if test="${bean.zt == 3}">处理失败</c:if>
						</td>
						<td class="center"><fmt:formatDate value="${bean.sjkssj}" pattern="yyyy-MM"/> ~ <fmt:formatDate value="${bean.sjjssj}" pattern="yyyy-MM"/></td>
						<td><fmt:formatDate value="${bean.cjsj}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center">
						<c:if test="${bean.zt == 2}"><a href="${ctxPath}/v1/html/data/sampleData/cleverImport/detail.do?sjyId=${bean.id}" title="详情">详情</a></c:if>
							<c:if test="${bean.zt == 2}"><a href="${ctxPath}/v1/html/data/sampleData/cleverImport/overview.do?sjyId=${bean.id}" title="概览">概览</a></c:if>
							<c:if test="${bean.zt == 0}">--</c:if><c:if test="${bean.zt == 1}">--</c:if><c:if test="${bean.zt == 3}">--</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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
	});
	
	</script>
</body>
</html>