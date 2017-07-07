<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>结果列表</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
<style>
	#resultDetailList th{min-width:104px;}
</style>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>结果列表</h1>
			<span class="detailGoBack">返回</span>
		</div>
		<div class="detailCondition">
			<ul>
				<li><span>纳税人识别号：</span><span><input type="text" value=""></span></li>
				<li><span>纳税人名称：</span><span><input type="text" value=""></span></li>
				<li><span>税务机关：</span>
					<span>
						<select>
							<option value="0">所有税务机关</option>
							<option value="1">甲税务</option>
							<option value="2">乙税务</option>
						</select>
					</span>
				</li>
				<li><span>经济类型：</span>
					<span>
						<select>
								<option value="0">所有经济类型</option>
								<option value="1">私营有限公司</option>
								<option value="2">国有有限公司</option>
							</select>
					</span>
				</li><br>
				<li style="width:454px;"><span>应申报税款：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li>
				<li style="width:454px;"><span>已申报税款：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li>
				<li style="width:454px;"><span>流失金额：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li>
				<li><a href="#" class="detailConditionCheck">查询</a></li>
			</ul>
		</div>
		<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table class="resultTable table table-info table-striped table-bordered table-hover" id="resultDetailList">
			<thead>
				<tr>
					<th>选择</th>
					<th>纳税人名称</th>
					<th>总已申报</th>
					<th>地区维度</th>
					<th>行业维度</th>
					<th>税种维度</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${taxPeopleList}" var="map">
				<tr>
					<td style="text-align:center;">
						<input class="ace ace-checkbox-1"  type="checkbox" />
						<span class="lbl"></span>
					</td>
					<td><a href="${ctxPath}/v1/html/task/result/report1.do?TASKID=${map.TASKID}&xh=${map.xh}&NSRMC=${map.NSRMC}">${map.NSRMC}</a></td>
					<td>${map.YSBSKZE}</td>
					<td>
					<c:if test="${map.DQ != '' }">${map.DQ}</c:if>
					<c:if test="${map.DQ == '' || map.DQ == null}">所有</c:if>
					</td>
					<td>${map.HY}</td>
					<td>${map.SZ}</td>
					<td><a href="${ctxPath}/v1/html/task/result/report1.do?TASKID=${map.TASKID}&xh=${map.xh}&NSRMC=${map.NSRMC}">一户式报告</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
			<div class="tableLodaing"><span class="fa fa-spinner fa-spin bigger-150"></span></div>
	</div>
	</div>
	</div>
</div>
<input type="hidden" value="${RwInfo.CJR}" id="cjr">
<input type="hidden" value="${RwInfo.CJSJ}" id="cjsj">
<input type="hidden" value="${maxCount}" id="maxCount">
<script>
var oTable1 = null;
$(function(){
	var maxCount =  $("#maxCount").val();
	oTable1 =$('#resultDetailList').DataTable( {
			bAutoWidth: false,
			"aaSorting": [],
			"aoColumnDefs": [
				{
				 sDefaultContent: '',
				 aTargets: [ '_all' ]
				  }
				],
				"bMaxDataNumber":maxCount,
	    } );
		$(".meuListDiv").css("width",$("#resultDetailList").width());
});
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/task/result/reportList.do";
});
var TASKID = zs_getUrlParameter("TASKID");
var batch = 0;
var pageSize = 50;
var cjr = $("#cjr").val();
var cjsj = $("#cjsj").val();
function loadNewData(el){
	if($(el).attr("class").indexOf("removeDisabled")>=0){
		batch++;
		$(".meuListDiv .tableLodaing").show();
		var taskid = $("#taskid").val();
		var taxid = $("#taxid").val();
		var  activePage = $(".meuListDiv .paginate_button.active a").html();
		 $.ajax({
			url:"${ctxPath}/v1/html/task/result/getBatchData.do",
			type:"post",
			data:{
				TASKID:TASKID,
				batch:batch,
				pageSize:pageSize,
			},
			dataType:"json",
			success:function(data){
				if(data.result=="ok"){
					$.each(data.values,function(i,p){
						var tempArray = [];
						tempArray.push('<input class="ace ace-checkbox-1"  type="checkbox" /><span class="lbl"></span>');
						tempArray.push('<a href="${ctxPath}/v1/html/task/result/report1.do?TASKID='+p.TASKID+'&TAXID='+p.TAXID+'&NSRMC='+p.NSRMC+'">'+p.NSRMC+'</a>');
						tempArray.push(p.YSBSKZE);
						tempArray.push(p.DQ);
						tempArray.push(p.HY);
						tempArray.push(p.SZ);
						tempArray.push(cjr);
						tempArray.push(cjsj);
						tempArray.push('<a href="${ctxPath}/v1/html/task/result/report1.do?TASKID='+p.TASKID+'&TAXID='+p.TAXID+'&NSRMC='+p.NSRMC+'">查看报告</a>');
						oTable1.row.add(tempArray).draw(); 
					});
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
				$(".meuListDiv .tableLodaing").hide();
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
