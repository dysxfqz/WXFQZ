<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<c:if test="${type=='tax'}">
		<title>税务机关详情</title>
	</c:if>
	<c:if test="${type=='comp'}">
		<title>企业类型详情</title>
	</c:if>
	<c:if test="${type=='risk'}">
		<title>风险级别详情</title>
	</c:if>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<c:if test="${type=='tax'}">
				<h1>税务机关详情</h1>
			</c:if>
			<c:if test="${type=='comp'}">
				<h1>企业类型详情</h1>
			</c:if>
			<c:if test="${type=='risk'}">
				<h1>风险级别详情</h1>
			</c:if>
			<span class="detailGoBack">返回</span>
		</div>
		<!-- <div class="detailCondition">
			<ul>
				<li><span class="Releft_word">经济类型：</span>
					<span style="padding-left:4px;">
						<select>
							<option value="0">所有经济类型</option>
							<option value="1">甲经济类型</option>
							<option value="2">乙经济类型</option>
						</select>
					</span>
				</li>
				<li><span class="Releft_word">风险级别：</span>
					<span>
						<select>
							<option value="0">所有风险级别</option>
							<option value="1">甲经风险级别</option>
							<option value="2">乙风险级别</option>
						</select>
					</span>
				</li>
				<li><span class="Releft_word">税务机关名称：</span><span><input type="text" value=""></span></li>
				<br>
				<li style="width:520px;"><span class="Releft_word">差额：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li>
				<li><a href="#" class="detailConditionCheck">查询</a></li>
			</ul>
		</div> -->
		<!-- <div class="detailCondition">
			<table class="table table-info table-striped table-bordered">
				<tbody>
					<tr>
						<td>经济类型</td>
						<td style="width:250px;">
							<select>
								<option value="0">所有经济类型</option>
								<option value="1">甲经济类型</option>
								<option value="2">乙经济类型</option>
							</select>
						</td>
						<td>风险级别</td>
						<td style="width:250px;">
							<select>
								<option value="0">所有风险级别</option>
								<option value="1">甲经风险级别</option>
								<option value="2">乙风险级别</option>
							</select>
						</td>
						<td>税务机关名称</td>
						<td style="width:250px;"><input type="text" value=""></td>
						<td>流失金额</td>
						<td>
							<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
						</td>
					</tr>
					<tr>
						<td colspan="8" style="text-align:right"><a href="#" class="detailConditionCheck">查询</a></td>
					</tr>
				</tbody>
			</table>
		</div> -->
		<table class="resultTable table table-info table-striped table-bordered table-hover" id="resultDetailList">
			<thead>
				<tr>
					<th>选择</th>
					<c:if test="${type=='risk'}">
						<th>风险排序</th>
					</c:if>
					<c:if test="${type=='tax'}">
						<th>税务机关</th>
					</c:if>
					<c:if test="${type=='comp'}">
						<th>企业类型</th>
					</c:if>
					<c:if test="${type=='risk'}">
						<th>风险级别</th>
					</c:if>
					<th>预测申报</th>
					<th>实际申报</th>
					<th>差额</th>
					<th>差额占比</th>
					<th>总户数</th>
					<th>嫌疑户</th>
					<th>嫌疑户占总户数比</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${taxDetailResultList}" var="taxDetail" varStatus='status'>
					<tr>
						<td style="text-align:center;">
							<input class="ace ace-checkbox-1"  type="checkbox" />
							<span class="lbl"></span>
						</td>
					<c:if test="${type=='risk'}">
						<td>${taxDetail.fxpx}</td>
					</c:if>
						<td>${taxDetail.name}</td>
						<td><fmt:formatNumber value="${taxDetail.zygsb}" pattern="#.##" minFractionDigits="2" /></td>
						<td><fmt:formatNumber value="${taxDetail.zyjsb}" pattern="#.##" minFractionDigits="2" /></td>
						<c:if test="${type=='risk'}">
							<td><fmt:formatNumber value="${taxDetail.lsje}" pattern="#.##" minFractionDigits="2" /></td>
						</c:if>
						<c:if test="${type!='risk'}">
							<td><fmt:formatNumber value="${taxDetail.zlsje}" pattern="#.##" minFractionDigits="2" /></td>
						</c:if>
						<td><fmt:formatNumber value="${taxDetail.zlsjezb*100}" pattern="#.##" minFractionDigits="2" />%</td>
						<td>${taxDetail.zhs}</td>
						<td>${taxDetail.zlshs}</td>
						<td><fmt:formatNumber value="${taxDetail.zlshszb*100}" pattern="#.##" minFractionDigits="2" />%</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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
	window.location.href="${ctxPath}/v1/html/analyse/result/detail.do?TASKID="+zs_getUrlParameter("taskId");
});
</script>
</body>

</html>
