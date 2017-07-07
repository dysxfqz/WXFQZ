<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>告警日志详情</title>
<style>
	th,td{max-width:none !important}
	#logTable tr td{
		padding: 8px;
		word-break: break-all;
	}
	#logTable tr td:first-child{
		width:200px;
		text-align: right;
		min-width:150px;
	}
</style>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>告警日志</h1>
			<a href="${ctxPath}/v1/html/logManage/alarm/log.do"class="detailGoBack">返回</a>
		</div>
			<div class="alert alert-info">
				<table id="logTable">
					<tr>
						<td>用户号：</td>
						<td>${esAlarmLog.userNumber}</td>
					</tr>
					<tr>
						<td>请求内容：</td>
						<td>${esAlarmLog.reqContent}</td>
					</tr>
					<tr>
						<td>告警类型：</td>
						<td><c:if test="${esAlarmLog.alarmType == 0}">解析虚拟机</c:if><c:if test="${esAlarmLog.alarmType == 1}">解析物理机</c:if
						><c:if test="${esAlarmLog.alarmType == 2}">解析接口错误</c:if><c:if test="${esAlarmLog.alarmType == 3}">其他</c:if></td>
					</tr>
					<tr>
						<td>告警Code：</td>
						<td>${esAlarmLog.alarmCode}</td>
					</tr>
					<tr>
						<td>告警来源：</td>
						<td>${esAlarmLog.alarmSource}</td>
					</tr>
					<tr>
						<td>告警内容：</td>
						<td>${esAlarmLog.alarmContent}</td>
					</tr>
					<tr>
						<td>告警级别：</td>
						<td><i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:<c:if test='${esAlarmLog.alarmLevel==2}'>blue</c:if><c:if test='${esAlarmLog.alarmLevel==1}'>orange</c:if><c:if test='${esAlarmLog.alarmLevel==0}'>red</c:if>"></i></td>
					</tr>
					<tr>
						<td>告警时间：</td>
						<td><fmt:formatDate value="${esAlarmLog.alarmTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<td>处理人：</td>
						<td>${esAlarmLog.processUser}</td>
					</tr>
					<tr>
						<td>请求url：</td>
						<td>${esAlarmLog.reqUrl}</td>
					</tr>
					<tr>
						<td>返回值内容：</td>
						<td>${esAlarmLog.respContent}</td>
					</tr>
				</table>
		</div>
	</div>
</body>
</html>