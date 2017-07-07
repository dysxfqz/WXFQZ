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
		<a href="${ctxPath}/v1/html/modelBuild/modelResult/report2.do?TASKID=${TASKID}&xh=${xh}&NSRMC=${NSRMC}"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-12">
	<div style="margin-top:20px;" class="table-header">科目重要性详情</div>
	<div id="economicsDiv">
		<table class="table table-info table-striped table-bordered table-hover" id="highRiskTableCont">
			<thead>
			<tr>
				<th>序号</th>
				<th>标识号</th>
				<th>纳税人识别号</th>
				<th>名称</th>
				<th>权重</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${mapList}" var="p" varStatus="status"> 
					<tr>
						<td>${status.index+1}</td>
						<td>${p.xh}</td>
						<td>${p.nsrsbh}</td>
						<td>${p.zbmc}</td>
						<td><fmt:formatNumber value="${p.zbqz}" pattern="#.##" minFractionDigits="2" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="tableLodaing"><span class="fa fa-spinner fa-spin bigger-150"></span></div>
	</div>
</div>	
<input type="hidden" value='${total}' id="maxCount">
<input type="hidden" value='${TASKID}' id="taskId">
<input type="hidden" value='${xh}' id="xh">
<input type="hidden" value='${NSRMC}' id="NSRMC">
<script>
var oTable1 = null;
$(function(){
	var maxCount = $("#maxCount").val();
	oTable1 =$('#highRiskTableCont').DataTable( {
		bStateSave: false,
		bAutoWidth: false,
		"bSort": true, //排序功能 
		"aoColumnDefs": [
			{
			 sDefaultContent: '',
			 aTargets: [ '_all' ]
			  }
			],
		"bMaxDataNumber":maxCount,
	});
});
var batch = 0;
var pageSize = 100;
var NoNumber = 100;
function loadNewData(el){
	if($(el).attr("class").indexOf("removeDisabled")>=0){
		batch++;
		$("#economicsDiv .tableLodaing").show();
		var  activePage = $("#economicsDiv .paginate_button.active a").html();
		var taskId = $("#taskId").val();
		var xh = $("#xh").val();
		var NSRMC = $("#NSRMC").val();
		 $.ajax({
			url:"${ctxPath}/v1/html/modelBuild/modelResult/ajaxdetail2.do",
			type:"post",
			data:{
				batch:batch,
				pageSize:pageSize,
				NSRMC:NSRMC,
				TASKID:taskId,
				xh:xh,
			},
			dataType:"json",
			success:function(data){
				if(data.result=="ok"){
					$.each(data.values,function(i,p){
						NoNumber++;
						 var tempArray = [];
						tempArray.push(NoNumber);
						tempArray.push(p.xh);
						tempArray.push(p.nsrsbh);
						tempArray.push(p.zbmc);
						tempArray.push(new Number(p.zbqz));
						oTable1.row.add(tempArray).draw(); 
					});
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
				$("#economicsDiv .tableLodaing").hide();
				oTable1.page(parseInt(activePage)).draw(false);
			},
			error:function(){
				Showbo.Msg.alert('查询失败'); 
			}
		}); 
	}
} 
</script>
</body>

</html>