<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>主题目录</title>
<link rel="stylesheet"
	href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th {
	min-width: 104px;
}
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>主题目录</h1>
		</div>
		<shiro:hasPermission name="theme:addTheme">
			<a href="javascript:addTask();"
				class=" btn btn-app btn-success newTaxBtn"
				style="margin-bottom: 10px;">新建主题</a>
		</shiro:hasPermission>
		<div style="width: 100%; overflow-x: auto;">
			<div class="meuListDiv">
				<table id="menuList"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>

							<th>任务名称</th>
							<th>序号</th>
							<th>备注</th>
							<th>创建时间</th>
							<th class="center">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${mxflList}" var="bean" varStatus='status'>
							<tr>
								<td>${bean.mc}</td>
								<td>${bean.xh}</td>
								<td>${bean.bz}</td>
								<td><fmt:formatDate value="${bean.cjsj }"
										pattern="yyyy-MM-dd" /></td>
								<td><a href="javascript:editTask('${bean.id}')">编辑</a> <a
									href="javascript:void(0)"
									onclick="deleteTask(this,'${bean.id}')"
									style="margin-left: 8px;">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="iso_alert">
		<div class="iso_alertKuang col-xs-12 col-sm-6">
			<!-- 修改模型分类弹出层 -->
			<div class="editTask">
				<div class="iso_alertHeader">
					<h2 class="iso_alertTitle">编辑模型分类</h2>
					<span id="closeEditTask" class="close_alertIso">&times;</span>
					<hr>
				</div>
				<div class="iso_alertBody">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">名称*</label>
							<div class="col-sm-9">
								<div class="input-group col-xs-12">
									<input class="form-control input-mask-date" id="taskNameInp"
										type="text" value="">
									<div class="errorTip"></div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">描述</label>
							<div class="col-sm-9">
								<textarea class="col-xs-12" rows="4" id="taskDecInp"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right"></label>
							<div class="col-sm-9">
								<span class="goSubmit" id="editTaskBtn" data-id="">提交</span>
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- 添加模型分类弹出层 -->
			<div class="addTask">
				<div class="iso_alertHeader">
					<h2 class="iso_alertTitle">添加模型分类</h2>
					<span id="closeAddTask" class="close_alertIso">&times;</span>
					<hr>
				</div>
				<div class="iso_alertBody">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">名称*</label>
							<div class="col-sm-9">
								<div class="input-group col-xs-12">
									<input class="form-control input-mask-date" id="mxflNameInp"
										type="text" value="">
									<div class="errorTip"></div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">描述</label>
							<div class="col-sm-9">
								<textarea class="col-xs-12" rows="4" id="mxflDecInp"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right"></label>
							<div class="col-sm-9">
								<span class="goSubmit" id="addTaskBtn" data-id="">提交</span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
	<script type="text/javascript">
		$(function() {
			$("[data-toggle='tooltip']").tooltip();
			var oTable1 = $('#menuList').dataTable({
				bStateSave : true,
				bAutoWidth : false,
				"aaSorting" : [],
				"aoColumnDefs" : [ {
					sDefaultContent : '',
					aTargets : [ '_all' ]
				} ],
			});
			$(".meuListDiv").css("width", $("#menuList").width());
		});
		function resizeIsoAlert() {
			var isoAlert = {
				height : 0,
				width : 0,
				left : 0,
				top : 0
			};
			isoAlert.height = $(".iso_alertKuang").height();
			isoAlert.width = $(".iso_alertKuang").width();
			isoAlert.top = (document.documentElement.clientHeight - isoAlert.height) / 2;
			if (document.documentElement.clientWidth < 768) {
				isoAlert.left = 0;
			} else {
				isoAlert.left = (document.documentElement.clientWidth - isoAlert.width) / 2;
			}
			$(".iso_alertKuang").css({
				left : isoAlert.left,
				top : isoAlert.top
			});
		}
		$(window).resize(function() {
			resizeIsoAlert();
		});
		//删除任务
		$('.iso_alertKuang').drag();
		function deleteTask(el, mxflId) {
			var taskStatus = $(el).parent().parent().find(".taskStatus").html();
			var jieduan = $(el).parent().parent().find(".jieduan").html();
			Showbo.Msg.confirm("您确定要删除该类模型吗", function() {
				if ($(".btnfocus").val() == "确定") {
					$.ajax({
						url : "${ctxPath}/v1/html/model/theme/delete.do",
						dataType : "json",
						type : "post",
						data : {
							id: mxflId
						},
						success : function(data) {
							if (data.result == "ok") {
								Showbo.Msg.alert("删除成功", function() {
									window.location.reload();
								});
							}
							else {
								Showbo.Msg.alert(data.errormsg);
							}
						},
						error : function() {
							Showbo.Msg.alert("服务器异常");
						}
					});
				}
			});

		}
		//弹出编辑框
		function editTask(mxflId) {
			$(".editTask").show();
			$(".iso_alert").show();
			$(".addTask").hide();
			resizeIsoAlert();
			$.ajax({
				url : "${ctxPath}/v1/html/model/theme/updateTheme.do",
				dataType : "json",
				type : "post",
				data : {
					id : mxflId
				},
				success : function(data) {
					if (data.result == "ok") {
						$("#taskNameInp").val(data.values.mc);
						$("#taskDecInp").val(data.values.bz);
						$("#editTaskBtn").attr("data-id", mxflId);

					} else {
						Showbo.Msg.alert(data.errormsg);
					}
				},
				error : function() {
					Showbo.Msg.alert("服务器异常");
				}
			});
		}
		//关闭编辑框
		$("#closeEditTask").click(function() {
			$(".editTask").hide();
			$(".addTask").hide();
			$(".iso_alert").hide();
			$("#taskNameInp").val("");
			$("#taskDecInp").val("");
		});
		//提交修改
		$("#editTaskBtn").click(function() {
			var mxflName = $("#taskNameInp").val();
			var mxflDec = $("#taskDecInp").val();
			var mxflId = $(this).attr("data-id");
			if (mxflName == "") {
				Showbo.Msg.alert("模型分类名称不能为空");
			} else {
				$.ajax({
					url : "${ctxPath}/v1/html/model/theme/confirmTheme.do",
					dataType : "json",
					type : "post",
					data : {
						id : mxflId,
						mc : mxflName,
						bz : mxflDec
					},
					success : function(data) {
						if (data.result == "ok") {
							Showbo.Msg.alert("修改成功", function() {
								window.location.reload();
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
					},
					error : function() {
						Showbo.Msg.alert("服务器异常");
					}
				});
			}
		});
		//弹出添加框
		function addTask() {
			$(".addTask").show();
			$(".iso_alert").show();
			$(".editTask").hide();
			resizeIsoAlert();
		};
		//提交添加
		$("#addTaskBtn").click(function() {
			var mxflName = $("#mxflNameInp").val();
			var mxflDec = $("#mxflDecInp").val();
			if (mxflName == "") {
				Showbo.Msg.alert("模型分类名称不能为空");
			} else {
				$.ajax({
					url : "${ctxPath}/v1/html/model/theme/addTheme.do",
					dataType : "json",
					type : "post",
					data : {
						mc : mxflName,
						bz : mxflDec
					},
					success : function(data) {
						if (data.result == "ok") {
							Showbo.Msg.alert("提交成功", function() {
								window.location.reload();
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
					},
					error : function() {
						Showbo.Msg.alert("服务器异常");
					}
				});
			}
		});
		//关闭添加框
		$("#closeAddTask").click(function() {
			$(".editTask").hide();
			$(".addTask").hide();
			$(".iso_alert").hide();
			$("#taskNameInp").val("");
			$("#taskDecInp").val("");
		});
	</script>
</body>
</html>