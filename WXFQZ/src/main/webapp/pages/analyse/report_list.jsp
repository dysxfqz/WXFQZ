<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>分析结果</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
	#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>分析结果</h1>
		</div>
			<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<div class="table-header">
			<span>&nbsp;</span>
			<span class="export exportPL" onclick="exportPL()">导出</span>
		</div>
		<table id="menuList" class="table table-striped table-bordered table-hover danHTable">
			<thead>
				<tr>
					<th style="min-width:80px;width:80px;">
						<label><input class="ace ace-checkbox-1" name="resultAllExport"  type="checkbox"/><span class="lbl">选择</span></label>
					</th>
					<th>任务名称</th>
					<th>税款所属期</th>
					<th>主管税务机关</th>
					<th>行业</th>
					<th class="homeShui">税种</th>
					<th>登记注册类型</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${fxrwList}" var="bean" varStatus='status'>
					<tr>
						<td style="text-align:center">
							<label><input class="ace ace-checkbox-1" name="resultExport" data-taskid="${bean.rwh}" type="checkbox"/><span class="lbl"></span></label>
						</td>
					<td><div>${bean.mc}</div></td>
						<td title="<fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM"/>"><div><fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM"/></div></td>
						<td><div>${bean.swjgCjMc}</div></td>
						<td><div>
							<c:if test="${bean.hy==''}">全部</c:if>
							<c:if test="${bean.hy!=''}">${bean.hy}</c:if>
						</div></td>
						<td><div>${bean.sz}</div></td>
						<td><div><c:if test="${bean.djzclx==''}">全部</c:if><c:if test="${bean.djzclx!=''}">${bean.djzclx}</c:if></div></td>
						<td class="center operateAc">
							<a href="${ctxPath}/v1/html/analyse/taskManage/detail.do?taskId=${bean.rwh}">详情 </a>
							<c:if test="${bean.jd == 4&&bean.zt==2}">/<a href="${ctxPath}/v1/html/analyse/result/detail.do?TASKID=${bean.rwh}" title="结果概览">概览</a>/</c:if>
							<c:if test="${bean.jd == 4&&bean.zt==2}"><a href="${ctxPath}/v1/html/analyse/result/taxpayerList.do?TASKID=${bean.rwh}" title="测算报告">报告</a></c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
	</div>
 <div id="loadingState">
	<div>
		<div><img class="load_img" src="${ctxPath}/static/source/img/loading.gif" style="width:50px;"/></div>
	</div>
</div>
	<script type="text/javascript">
	$(function(){
		var oTable1 =$('#menuList').dataTable( {
				bStateSave: false,
				bAutoWidth: false,
				"aaSorting": [],
				"aoColumns": [
				    		  { "bSortable": false },
				    		  null, null, null,null, null, null,
				    		  { "bSortable": false }
				    		],
				"aoColumnDefs": [
					{
					 sDefaultContent: '',
					 aTargets: [ '_all' ]
					  }
					],
		    } );
	});
	$("input[name=resultAllExport]").click(function(){
		if($(this).is(":checked")){
			$("input[name=resultExport]").attr("checked",true);
			$("input[name=resultExport]").prop("checked",true);
		}else{
			$("input[name=resultExport]").attr("checked",false);
			$("input[name=resultExport]").prop("checked",false);
		}
	});
	$("input[name=resultExport]").click(function(){
		if($("input[name=resultExport]").length==$("input[name=resultExport]:checked").length){
			$("input[name=resultAllExport]").attr("checked",true);
			$("input[name=resultAllExport]").prop("checked",true);
		}else{
			$("input[name=resultAllExport]").attr("checked",false);
			$("input[name=resultAllExport]").prop("checked",false);
		}
	});
	//导出
	function exportPL(){
		var TASKID="";
		$("input[name=resultExport]:checked").each(function(i,p){
			TASKID += $(p).attr("data-taskid")+",";
		});
		if(TASKID==""){
			Showbo.Msg.alert("请选择需要导出的结果");
			return;
		}
		TASKID = TASKID.substring(0,TASKID.length-1);
		xh = xh.substring(0,xh.length-1);
		$("#loadingState").show();
		$.ajax({
			url:"${ctxPath}/v1/html/modelBuild/modelResult/excelList.do",
			dataType:"json",
			type:"post",
			data:{
				TASKID:TASKID,
			},
			success:function(data){
				$("#loadingState").hide();
				if(data.result=="ok"){
					downloadFile(data.values);
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				$("#loadingState").hide();
				Showbo.Msg.alert("服务器异常");
			}
		});
	}
	//文件下载
	function downloadFile(url) {   
	    try{ 
	        var elemIF = document.createElement("iframe");   
	        elemIF.src = url;   
	        elemIF.style.display = "none";   
	        document.body.appendChild(elemIF);   
	    }catch(e){ 
			console.log(e);
	    } 
	}
	</script>
</body>
</html>