<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>菜单管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
<style>
	#oper span{
		margin-left:10px;	
	}
</style>
</head>
<body>
	<div class="col-xs-12">
		<input type="button" class="btn btn-info" style="margin:10px;" value="添加菜单" onclick="toAddMenu()">
		<div class="table-header">菜单管理</div>
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>No.</th>
					<th>菜单名称</th>
					<th>父级菜单</th>
					<th>排序</th>
					<td>等级</td>
					<th>标签名称(htmlId)</th>
					<th>样式名称(htmlClass)</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${menu}" var="bean" varStatus='status'>
					<tr>
						<input type="hidden" value="${bean.id }" name="id">
						<td class="center">${status.index +1 }</td>
						<td>${bean.name }</td>
						<td>${bean.father.name }</td>
						<td>${bean.sort }</td>
						<td>
							<c:choose>
								<c:when test="${bean.rank == 0 }">
									一级
								</c:when>
								<c:when test="${bean.rank == 1 }">
									二级
								</c:when>
								<c:otherwise>
									三级
								</c:otherwise>
							</c:choose>
						</td>
						<td>${bean.htmlId }</td>
						<td>${bean.htmlClass }</td>
						<td align="center">
							<span class="glyphicon glyphicon-pencil" data-toggle="tooltip" onclick="updateMenu('${bean.id}')" title="编辑" style="cursor:pointer"></span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span class="glyphicon glyphicon-trash" data-toggle="tooltip" onclick="delMenu('${bean.id}')" title="删除" style="cursor:pointer" ></span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script type="text/javascript">
	$(function(){
		var oTable1 =$('#menuList').dataTable( {
				bStateSave: true,
				bAutoWidth: false,
				"aoColumns": [
				  { "bSortable": true },
				  null, null, null, null, null, null,
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
	
	function toAddMenu() {
		location.href = "${ctxPath}/v1/html/manage/menuManage/create/toMenu.do";
	}
	
	function updateMenu(menuId) {
		location.href = "${ctxPath}/v1/html/manage/menuManage/update/toUpdateMenu.do?menuId="+menuId;
	}
	
	function delMenu(menuId) {
		Showbo.Msg.confirm("您确认要删除吗? ",function() {
			//锁屏图片显示
			$(".loading_chuan").show();
			if ($(".btnfocus").val() == "确定") {
				$.ajax({
					type : "post",
					url:"${ctxPath}/v1/html/manage/menuManage/delete/deleteMenu.do",
					data : {
							id : menuId,
					      },
					dataType : "json",
					success : function(data){
						//锁屏图片隐藏
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