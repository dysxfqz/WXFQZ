<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue" style="position:relative">
			<h1>任务列表</h1>
			<div class="goSearchD">
				<span class="input-group">
					<input class="form-control" type="text">
					<span class="input-group-addon" id="goSearch">查询</span>
				</span>
			</div>
	</div>
	<div class="table-header">
		<span>已完成的任务</span>
		<a href="${ctxPath}/v1/html/analyse/result/resultList.do" class="export">更多</a>
	</div>
	<div id="overTaskD">
		<table class="table table-striped table-bordered table-hover" id="overTask">
			<thead>
				<tr>
					<th>任务名称</th>
					<th>税款所属期</th>
					<th>地区</th>
					<th>行业</th>
					<th>税种</th>
					<th>企业规模</th>
					<th>核算方式</th>
					<th>登记类型</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<div class="table-header" style="margin-top:25px;">
		<span>正在执行的任务</span>
		<a href="${ctxPath}/v1/html/analyse/taskManage/list.do?sourceType=1" class="export">更多</a>
	</div>
	<div id="OnTaskD">
		<table class="table table-striped table-bordered table-hover" id="OnTask">
			<thead>
				<tr>
					<th>任务名称</th>
					<th>税款所属期</th>
					<th>主管税务机关</th>
					<th>行业</th>
					<th>税种</th>
					<th>企业规模</th>
					<th>登记类型</th>
					<th>阶段</th>
					<th>状态</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
	<div class="LinkBtn">
		<a href="${ctxPath}/v1/html/navigat.do">操作导航</a>
		<a href="${ctxPath}/v1/html/support.do">技术支持</a>
	</div>
	</div>
	<script src="${ctxPath}/static/source/js/timeReversal.js"></script>
	<script type="text/javascript">
	var oTable2 = null;
	var oTable1 = null;
	
	$(function(){
		 $("[data-toggle='tooltip']").tooltip();
	//搜索功能
	$("#goSearch").click(function(){
		var searchName = $(this).prev().val();
		var jieduanArray = ['数据采集','数据清洗','训练预测','结果处理',"生成报告"];
		var statusArray=['待处理','处理中','处理成功','处理失败'];
		var biaoji = ['','','','style="color:red"'];
		$.ajax({
			url:"${ctxPath}/v1/html/fxrw/home/ajaxHome.do",
			type:"post",
			dataType:"json",
			data:{searchName:searchName},
			success:function(data){
				if(data.result=="ok"){
					var temp1 ='<table class="table table-striped table-bordered table-hover" id="overTask"><thead>'+
					'<tr><th>任务名称</th><th>税款所属期</th><th>主管税务机关</th><th>行业</th><th class="homeShui">税种</th><th>登记类型</th><th>操作</th></tr></thead><tbody>';
					var temp2 = '<table class="table table-striped table-bordered table-hover" id="OnTask"><thead>'+
					'<tr><th>任务名称</th><th>税款所属期</th><th>主管税务机关</th><th>行业</th><th class="homeShui">税种</th><th>登记类型</th><th class="homecaozo">阶段</th><th class="homecaozo">状态</th></tr></thead><tbody>';
					$.each(data.values.notExecuteList,function(i,p){
						temp1+='<tr><td><div title="'+p.mc+'">'+p.mc+'</div></td>'+
						'<td><div>'+getFormatDateByLong(p.sjkssj,"yyyy-MM")+'~'+getFormatDateByLong(p.sjjssj,"yyyy-MM")+'</div></td>'+
						'<td><div>'+p.swjgCjMc+'</div></td>'+
						'<td><div>'+p.hy+'</div></td>'+
						'<td><div>'+p.sz+'</div></td>'+
						'<td><div>'+p.djzclx+'</div></td>'+
						'<td class="center operateAc"><a href="${ctxPath}/v1/html/analyse/taskManage/detail.do?taskId='+p.rwh+'" title="任务详情">详情</a>/'+
						'<a href="${ctxPath}/v1/html/analyse/result/detail.do?TASKID='+p.rwh+'" title="结果概览">概览</a>/'+
						'<a href="${ctxPath}/v1/html/analyse/result/taxpayerList.do?TASKID='+p.rwh+'" title="测算报告">报告</a></td></tr>';
					});
					temp1+='</tbody></table>';
					$.each(data.values.executeList,function(i,p){
						temp2+='<tr><td><div title="'+p.mc+'">'+p.mc+'</div></td>'+
						'<td><div>'+getFormatDateByLong(p.sjkssj,"yyyy-MM")+'~'+getFormatDateByLong(p.sjjssj,"yyyy-MM")+'</div></td>'+
						'<td><div>'+p.swjgCjMc+'</div></td>'+
						'<td><div>'+p.hy+'</div></td>'+
						'<td><div>'+p.sz+'</div></td>'+
						'<td><div>'+p.djzclx+'</div></td>'+
						'<td><div>'+jieduanArray[p.jd]+'</div></td>'+
						'<td><div '+biaoji[p.zt]+'>'+statusArray[p.zt]+'</div></td></tr>';
					});
					temp2+='</tbody></table>';
					$("#overTaskD").html(temp1);
					$("#OnTaskD").html(temp2);
					oTable2 =$('#overTask').dataTable( {
						bStateSave: false,
						bAutoWidth: false,
						"aaSorting": [],
						bFilter:false
				    });
					oTable1 =$('#OnTask').dataTable( {
						bStateSave: true,
						bAutoWidth: false,
						"aaSorting": [],
						bFilter:false
				    });
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				Showbo.Msg.alert("服务器异常");
			}
		});
	});
	$("#goSearch").click();
	});
	</script>
</body>
</html>