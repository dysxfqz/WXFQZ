<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>模型列表</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
#menuList th {
	min-width: 104px;
}
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>模型列表</h1>
		</div>
		<a href="${ctxPath}/v1/html/modelBuild/newMission/add.do" class=" btn btn-app btn-success newTaxBtn"
			style="margin-bottom: 10px;">新建模型</a>
		<div style="width: 100%; overflow-x: auto;">
			<div class="meuListDiv">
				<table id="menuList"
					class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>模型类型</th>
							<th>模型号</th>
							<th>模型名称</th>
							<th>适用税种</th>
							<th>适用行业</th>
							<th>城市</th>
							<th>登记注册类型</th>
							<th>核算方式</th>
							<th>企业规模</th>
							<th>版本</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${mxList}" var="bean" varStatus='status'>
							<tr>
								<td><c:if test="${bean.mxlx == 0}">系统</c:if> <c:if
										test="${bean.mxlx == 1}">自用</c:if> <c:if
										test="${bean.mxlx == 2}">开放</c:if></td>
								<td>${bean.mxh}</td>
								<td>${bean.mc}</td>
								<td>${bean.szmc}</td>
								<td style="max-width: 200px;"><c:if test="${bean.hy==''}">全部</c:if>
									<c:if test="${bean.hy!=''}">
									<c:if test="${bean.hy.length()>30}">${fn:substring(bean.hy,0,30)} ...</c:if>
									<c:if test="${bean.hy.length()<=30}">${bean.hy}</c:if>
									</c:if></td>
								<td>${bean.csmc}</td>
								<td style="max-width: 200px;">
									<c:if test="${bean.djzclx==''}">全部</c:if
									><c:if test="${bean.djzclx!=''}"
										><c:if test="${bean.djzclx.length()>30}">${fn:substring(bean.djzclx,0,30)} ...</c:if
										><c:if test="${bean.djzclx.length()<=30}">${bean.djzclx}</c:if></c:if
								></td>
								<td><c:if test="${bean.hsfsmc==''}">全部</c:if> <c:if
										test="${bean.hsfsmc!=''}"><c:if test="${bean.hsfsmc.length()>30}">${fn:substring(bean.hsfsmc,0,30)} ...</c:if>
									<c:if test="${bean.hsfsmc.length()<=30}">${bean.hsfsmc}</c:if></c:if></td>
								<td>${bean.qygm}</td>
								<td><c:if test="${bean.bb == 0}">
										<i class="fa fa-check-circle" aria-hidden="true"
											style="color: green; font-size: 16px;" title="正式版"></i>
									</c:if> <c:if test="${bean.bb == 1}">测试版本</c:if></td>
								<td><a href="javascript:editTask('${bean.mxh}')">编辑</a>
								<c:if test="${bean.bb == 1}">
									<br><a href="javascript:void(0)" class="subbtn" data="${bean.mxh}" >设为正式版本</a>
								</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	 $(".subbtn").click(function() {
		 var $a = $(this);
		 var mxh=$a.attr('data');
	        $.ajax({
	            type: 'post',
	            dataType:"json",
	            data:{modelNum:mxh},
	            url:"${ctxPath}/v1/html/model/models/updateBb.do",
	            success: function(data){
	            	if(data.result=='ok'){
	            		 window.location.reload();
	            	}else{
						Showbo.Msg.alert(data.errormsg);
		            }
	            },
	            error:function(){
					Showbo.Msg.alert("服务器异常");
				}
	       });
	    });
	
	</script>
	<div class="iso_alert">
	<div class="iso_alertKuang col-xs-12 col-sm-6">
	<!-- 弹出层 -->
		<div class="editTask">
			<div class="iso_alertHeader">
				<h2 class="iso_alertTitle">编辑模型</h2>
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
					<span class="goSubmit" id="editTaskBtn" data-mxh="">提交</span>
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
	//弹出编辑框
	function editTask(mxh){
		$(".editTask").show();
		$(".iso_alert").show();
		resizeIsoAlert();
		$.ajax({
			url:"${ctxPath}/v1/html/model/models/update.do",
			dataType:"json",
			type:"post",
			data:{modelNum:mxh},
			success:function(data){
				if(data.result=="ok"){
					$("#taskNameInp").val(data.values.mc);
					$("#taskDecInp").val(data.values.ms);
					$("#editTaskBtn").attr("data-mxh",mxh);
					
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
		var mxmc = $("#taskNameInp").val();
		var mxms = $("#taskDecInp").val();
		var mxh = $(this).attr("data-mxh");
		if(mxmc==""){
			Showbo.Msg.alert("模型名称不能为空");
		}else{
			$.ajax({
				url:"${ctxPath}/v1/html/model/models/confirmUpdate.do",
				dataType:"json",
				type:"post",
				data:{
					modelNum:mxh,
					modelName:mxmc,
					modelDesc:mxms
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