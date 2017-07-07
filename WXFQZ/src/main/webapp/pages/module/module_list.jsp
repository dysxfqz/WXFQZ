<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>模块管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
<style>
	#oper span{
		margin-left:10px;	
	}
</style>
</head>
<body>
	<div class="col-xs-12">
		<input type="button" class="btn btn-info" style="margin:10px;" value="添加模块" onclick="toAddModule()">
		<div class="table-header">模块管理</div>
		<table id="moduleList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>模块名称</th>
					<th>排序</th>
					<th>描述</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${moduleList }" var="bean" varStatus='status'>
					<tr>
						<input type="hidden" value="${bean.id }" name="id">
						<td class="center">${status.index +1 }</td>
						<td>${bean.name }</td>
						<td>${bean.sort }</td>
						<td>${bean.description }</td>
						<td align="center">
							<span class="glyphicon glyphicon-trash" data-toggle="tooltip" onclick="delModule('${bean.id}')" title="删除" style="cursor:pointer" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script type="text/javascript">
	$(function(){
		var oTable1 =$('#moduleList').dataTable( {
				bStateSave: true,
				bAutoWidth: false,
				"aoColumns": [
				  { "bSortable": true },
				  null, null, null,
				  { "bSortable": false }
				],
				"aaSorting": [],
				"aoColumnDefs": [
					{
					 sDefaultContent: '',
					 aTargets: [ '_all' ]
					  }
					],
		    } );
	});
	
	function toAddModule() {
		location.href = "${ctxPath}//v1/html/manage/moduleManage/create/toModule.do";
	}
	
	function delModule(moduleId) {
		Showbo.Msg.confirm("您确认要删除吗? ",function() {
			$(".loading_chuan").show();
			if ($(".btnfocus").val() == "确定") {
				$.ajax({
					type : "post",
					url:"${ctxPath}/v1/html/manage/moduleManage/delete/deleteModule.do",
					data : {
							moduleId : moduleId,
					      },
					dataType : "json",
					success : function(data){
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("删除成功", function() {
								if ($(".btnfocus").val() == "确定") {
									window.location.reload();
								}
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
					},
					error:function(){
						Showbo.Msg.alert("服务器异常");
					}
				});
			}
			if ($(".btnfocus").val() == "取消") {
				$(".loading_chuan").hide();
				return;
			}
		});
	}
	</script>
</body>
</html>