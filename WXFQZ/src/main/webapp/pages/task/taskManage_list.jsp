<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>任务管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th{min-width:104px;}
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>任务管理</h1>
	</div>
	<a href="${ctxPath}/v1/html/task/predict/add.do" class=" btn btn-app btn-success newTaxBtn" style="margin-bottom:10px;">新建任务</a>
	<div style="width:100%;overflow-x:auto;">
		<div class="meuListDiv">
		<table id="menuList" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					
					<th>任务名称</th>
					<th>税种</th>
					<th>行业</th>
					<th>城市</th>
					<th>登记注册类型</th>
					<th>核算方式</th>
					<th>企业规模 </th>
					<th>时间维度</th>
					<th>任务阶段</th>
					<th>任务状态</th>
					<th class="center">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ycrwList}" var="bean" varStatus='status'>
					<tr>
						<td>${bean.mc}</td>
						<td>${bean.mx.szmc}</td>
						<td>
							<c:if test="${bean.hy==''}">全部</c:if>
								<c:if test="${bean.hy!=''}">
								<c:if test="${bean.hy.length()>30}">${fn:substring(bean.hy,0,30)} ...</c:if>
								<c:if test="${bean.hy.length()<=30}">${bean.hy}</c:if>
							</c:if>
						</td>
						<td><c:if test="${bean.mx.csmc.length()>30}">${fn:substring(bean.mx.csmc,0,30)} ...</c:if
								><c:if test="${bean.mx.csmc.length()<=30}">${bean.mx.csmc}</c:if>
						</td>
						<td><c:if test="${bean.djzclx==''}">全部</c:if
							><c:if test="${bean.djzclx!=''}"
								><c:if test="${bean.djzclx.length()>30}">${fn:substring(bean.djzclx,0,30)} ...</c:if
								><c:if test="${bean.djzclx.length()<=30}">${bean.djzclx}</c:if></c:if
						></td>
						<td>
						<c:if test="${bean.mx.hsfsmc==''}">全部</c:if> <c:if
							test="${bean.mx.hsfsmc!=''}"><c:if test="${bean.mx.hsfsmc.length()>30}">${fn:substring(bean.mx.hsfsmc,0,30)} ...</c:if>
						<c:if test="${bean.mx.hsfsmc.length()<=30}">${bean.mx.hsfsmc}</c:if></c:if>
						</td>
						<td>${bean.mx.qygm}</td>
						<td><fmt:formatDate value="${bean.sjkssj }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${bean.sjjssj }" pattern="yyyy-MM-dd"/></td>
						<td class="jieduan"><c:if test="${bean.jd == 0}">数据采集 </c:if><c:if test="${bean.jd == 1}">数据清洗</c:if><c:if test="${bean.jd == 2}">训练预测</c:if><c:if test="${bean.jd == 3}">结果处理</c:if></td>
						<td class="taskStatus"><c:if test="${bean.zt == 0}">待处理 </c:if><c:if test="${bean.zt == 1}">处理中</c:if><c:if test="${bean.zt == 2}">处理成功</c:if><c:if test="${bean.zt == 3}">处理失败</c:if></td>
						<td><a href="javascript:editTask('${bean.rwh}')">编辑</a>
						<c:if test="${bean.zt == 0 && bean.jd == 0 }">
							<a href="javascript:void(0)" onclick="deleteTask(this,'${bean.rwh}')" style="margin-left:8px;">删除</a>
						</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		</div>
	</div>
	<div class="iso_alert">
	<div class="iso_alertKuang col-xs-12 col-sm-6">
<!-- 弹出层 -->
		<div class="editTask">
			<div class="iso_alertHeader">
				<h2 class="iso_alertTitle">编辑任务</h2>
				<span id="closeEditTask" class="close_alertIso">&times;</span>
				<hr>
			</div>
			<div class="iso_alertBody">
				<form class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label no-padding-right">名称*</label>
			<div class="col-sm-9">
				<div class="input-group col-xs-12">
					<input class="form-control input-mask-date" id="taskNameInp" type="text" value="">
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
					<span class="goSubmit" id="editTaskBtn" data-rwh="">提交</span>
				</div>
			</div>
		</form>
			</div>
		</div>
	</div>
</div>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
	<script type="text/javascript">
	$(function(){
		 $("[data-toggle='tooltip']").tooltip();
		var oTable1 =$('#menuList').dataTable( {
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
			$(".meuListDiv").css("width",$("#menuList").width());
	});
	function resizeIsoAlert(){
		 var isoAlert = {height:0,width:0,left:0,top:0};
		 isoAlert.height = $(".iso_alertKuang").height();
		 isoAlert.width = $(".iso_alertKuang").width();
		 isoAlert.top = (document.documentElement.clientHeight- isoAlert.height)/2;
		 if(document.documentElement.clientWidth<768){
			 isoAlert.left = 0;
		 }else{
			 isoAlert.left = (document.documentElement.clientWidth- isoAlert.width)/2;
		 }
		 $(".iso_alertKuang").css({
			 left:isoAlert.left,
			 top:isoAlert.top
		 });
	}
	 $(window).resize(function(){
		 resizeIsoAlert();
	 });
	//删除任务
	$('.iso_alertKuang').drag();
	function deleteTask(el,rwh){
		var taskStatus = $(el).parent().parent().find(".taskStatus").html();
		var jieduan = $(el).parent().parent().find(".jieduan").html();
		Showbo.Msg.confirm("您确定要删除该任务吗",function(){
			 if($(".btnfocus").val() =="确定"){
				 if(taskStatus.indexOf("待处理")>=0&&jieduan.indexOf("数据采集")>=0){
						$.ajax({
							url:"${ctxPath}/v1/html/task/predict/delete.do",
							dataType:"json",
							type:"post",
							data:{taskId:rwh},
							success:function(data){
								if(data.result=="ok"){
									Showbo.Msg.alert("删除成功",function(){
										window.location.reload();
									});
								}else{
									Showbo.Msg.alert(data.errormsg);
								}
							},
							error:function(){
								Showbo.Msg.alert("服务器异常");
							}
						});
					}else{
						Showbo.Msg.alert("任务已经开始，无法删除");
					}
			}
		});
		
	}
	//弹出编辑框
	function editTask(rwh){
		$(".editTask").show();
		$(".iso_alert").show();
		resizeIsoAlert();
		$.ajax({
			url:"${ctxPath}/v1/html/task/predict/update.do",
			dataType:"json",
			type:"post",
			data:{taskId:rwh},
			success:function(data){
				if(data.result=="ok"){
					$("#taskNameInp").val(data.values.mc);
					$("#taskDecInp").val(data.values.ms);
					$("#editTaskBtn").attr("data-rwh",rwh);
					
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				Showbo.Msg.alert("服务器异常");
			}
		});
	}
	//关闭编辑框
	$("#closeEditTask").click(function(){
		$(".editTask").hide();
		$(".iso_alert").hide();
		$("#taskNameInp").val("");
		$("#taskDecInp").val("");
	});
	//提交修改
	$("#editTaskBtn").click(function(){
		var taskName = $("#taskNameInp").val();
		var taskDec = $("#taskDecInp").val();
		var rwh = $(this).attr("data-rwh");
		if(taskName==""){
			Showbo.Msg.alert("任务名称不能为空");
		}else{
			$.ajax({
				url:"${ctxPath}/v1/html/task/predict/confirmUpdate.do",
				dataType:"json",
				type:"post",
				data:{
					taskId:rwh,
					taskName:taskName,
					taskDesc:taskDec
				},
				success:function(data){
					if(data.result=="ok"){
						Showbo.Msg.alert("修改成功",function(){
							window.location.reload();
						});
					}else{
						Showbo.Msg.alert(data.errormsg);
					}
				},
				error:function(){
					Showbo.Msg.alert("服务器异常");
				}
			});
		}
	});
	</script>
</body>
</html>