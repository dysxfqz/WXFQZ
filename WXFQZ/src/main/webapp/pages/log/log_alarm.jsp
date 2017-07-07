<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>告警日志模块</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
<style>
	#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>告警日志</h1>
		</div>
		<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>用户号</th>
					<th>告警类型</th>
					<th>告警内容</th>
					<th>告警级别 </th>
					<th>告警时间</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${esAlarmLogList}" var="bean" varStatus='status'>
					<tr>
						<td>${bean.userNumber}</td>
						<td><c:if test="${bean.alarmType == 0}">解析虚拟机</c:if><c:if test="${bean.alarmType == 1}">解析物理机</c:if>
						<c:if test="${bean.alarmType == 2}">解析接口错误</c:if><c:if test="${bean.alarmType == 3}">其他</c:if>
						</td>
						<td>${bean.alarmContent}</td>
						<td style = "text-align:center">
						<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:<c:if test='${bean.alarmLevel==2}'>blue</c:if><c:if test='${bean.alarmLevel==1}'>orange</c:if><c:if test='${bean.alarmLevel==0}'>red</c:if>"></i>
						</td>
						<td><fmt:formatDate value="${bean.alarmTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center"><a href="${ctxPath}/v1/html/logManage/alarm/logDetail.do?alarmCode=${bean.alarmCode}" title="详情">详情</a></td>
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