<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>企业关联关系网状图</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>科目重要性详情</h1>
		<a href="${ctxPath}/v1/html/task/result/report2.do?TASKID=${TASKID}&xh=${xh}&NSRMC=${NSRMC}"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10">
	<div style="margin-top:20px;" class="table-header">科目重要性详情</div>
	<table class="table table-info table-striped table-bordered table-hover">
		<tbody id="highRiskTableCont">
			<tr>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>	
<input type="hidden" value="${kmzyxArray}" id="kmzyxArray">
<script>
	function creatHighRisk(){
		var kmzyxArray = $("#kmzyxArray").val().split(",");
		var tableContent = '<tr>';
		$.each(kmzyxArray,function(i,p){
			tableContent+='<td>'+p+'</td>';
			if(i%5==0&&i!=0){
				tableContent += '</tr><tr>';
			}
		});
		$("#highRiskTableCont").html(tableContent);
	}
	creatHighRisk();    
</script>
</body>

</html>