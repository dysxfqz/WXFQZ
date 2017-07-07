<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>权限管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
</head>
<body>
	<div class="col-xs-12">
	<input type="button" class="btn btn-info" style="margin:10px;" value="添加权限" onclick="toAddPermission()">
	<div class="table-header">权限管理</div>
	<table id="permission-list" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center">No.</th>
			
			<th>名称</th>
			<th>URL</th>
			<th>模块</th>
			<th>类型</th>
			<td>描述</td>
			<th class="center">操作</th>
		</tr>
		</thead>
		<tbody >
			<c:forEach items="${userPermissionList}" var="p" varStatus='status'>
				<tr>
					<td class="center">${status.index +1}</td>
					<td>${p.name }</td>
					<td>${p.url }</td>
					<td>
						<c:choose>
							<c:when test="${p.moduleId == null and p.moduleType == 2 }">- -</c:when>
							<c:otherwise>${p.module.name }</c:otherwise>
						</c:choose>
					</td>
					<td>${p.type }</td>
					<td>${p.description }</td>
					<td align="center">
						<span class="glyphicon glyphicon-pencil" data-toggle="tooltip" onclick="updatePermission('${p.id}')" title="编辑" style="cursor:pointer"></span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="glyphicon glyphicon-trash" onclick="rmPerm('${p.id}');" data-toggle="tooltip" title="删除权限" name="ra" style="cursor:pointer" ></span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<!-- 添加权限 -->
	<div class="alertInfo" id="addRole">
	<div class="alertInfo-content alert-content col-xs-12 col-md-4" >
		<div class="header smaller lighter">
			<h4>添加权限<span class="pull-right closeWin" onclick="closeAddRole()">&times;</span></h4>
		</div>
		<div class="alertInfo-body col-xs-12">
				<form class="form-horizontal" autocomplete="off" action="${ctxPath}/v1/html/manage/permissionManage/create/createUserPermission.do" id="submitCheck" role="form" >
					<div class="form-group"> 
						<span class="col-xs-12" id="msg" style="text-align: center;"></span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">所属模块</label>
						<div class="col-sm-9">
							<select class="col-xs-10 col-sm-10" id="module_id" name="module_id" >
								<option value="0">--请选择--</option>
								<c:forEach items="${moduleList }" var="bean">
							   		<option value="${bean.id }">${bean.description }</option>
								</c:forEach>
						    </select>
						    <span class="help-inline col-xs-2">
						<input type="button" value="添加模块" onclick="toAddModule()" style="background: #6fb3e0;border: none;color: #fff;padding: 5px;cursor: pointer;">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限名称</label>
						<div class="col-sm-9">
							<input type="text" placeholder="名称"  name="name" id="name" class="col-xs-10 col-sm-10" onblur="checkBlur('权限名称',this, 1024)"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限URL</label>
						<div class="col-sm-9">
							<input type="text" placeholder="权限URL"  name="url" id="url" class="col-xs-10 col-sm-10" onblur="checkBlur('权限URL',this, 1024)"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限类型</label>
						<div class="col-sm-9">
							<select class="col-xs-10 col-sm-10" id="type" name="type" onblur="checkBlur('权限类型',this, 32)">
						   		<option value="">--select--</option>
						    	<option value="perms">perms</option>
						    	<option value="anon">anon</option>
						    </select>
						    <span class="help-inline col-xs-12 col-sm-7">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限描述</label>
						<div class="col-sm-9">
							<input type="text" placeholder="权限描述"  name="description" id="description" class="col-xs-10 col-sm-10" onblur="checkBlur('权限描述',this, 1024)"/>
						</div>
					</div>
					<div class="alertInfo-footer" style="margin-top: 30px;">
						<input class="btn btn-info col-xs-5" type="reset" value="重置" id="reset"/>
						<input class="btn btn-info col-xs-5 pull-right" type="button" value="确认" onclick="saveObj();"/>
					</div>
				</form>
		</div>
	</div>
</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	
	<script>
	$(function () { $("[data-toggle='tooltip']").tooltip(); });
	function shipei(){
		var logindiv_width = $(".alert-content").css("width").replace("px", "");
	    var logindiv_height = $(".alert-content").css("height").replace("px", "");
		$(".alert-content").css({
	        "margin-left": (document.documentElement.clientWidth - logindiv_width) / 2,
	        "margin-top": (document.documentElement.clientHeight - logindiv_height) / 3,
	    });
	}
	shipei();
	$(window).resize(function () {
		shipei();
	});
	$(function(){
		var oTable1 =$('#permission-list').dataTable( {
				bStateSave: true,
				bAutoWidth: false,
				"aoColumns": [
				  { "bSortable": true },
				  null, null,null, null, null,
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
	
	function rmPerm(el){
		var ss = "";
		if (el != null) {
			ss = el;
		} else {
			var persIdList = document.getElementsByName("persId");
			for (k in persIdList) {
				if (persIdList[k].checked)
					ss += persIdList[k].value + ",";
			}
		}
		if (ss.length != 0) {
			Showbo.Msg.confirm("您确认要删除吗? ",function() {
				if ($(".btnfocus").val() == "确定") {
					$(".loading_chuan").show();
					$.ajax({
						url : "${ctxPath}/v1/html/manage/permissionManage/delete/deletePermission.do",
						type : "post",
						data : {
							persIdList : ss,
						},
						datatype : "json",
						success : function(data) {
							$(".loading_chuan").hide();
							if (data.result == 'ok') {
								Showbo.Msg.alert("删除成功",function(){
									if ($(".btnfocus").val() == "确定") {
										window.location.reload();
									}
								});
							} else {
								Showbo.Msg.alert(data.errormsg);
								$(".loading_chuan").hide();
							}
						},
						error : function() {
							Showbo.Msg.alert("删除失败");
							$(".loading_chuan").hide();
							return;
						}
					});
				}
				if ($(".btnfocus").val() == "取消") {
					return;
				}
			});
		} else {
			Showbo.Msg.alert("请选择您要删除的记录！");
		}
	}
	//校验空和长度-->zxj
	function checkBlur(name,el,length){
		var value = $(el).val();
		var str="";
		if(value==""){
			str = "<span style='color:red'>* "+name+"不能为空</span>";
			$("#msg").html(str);
			$(el).attr("flag","false");
			$(el).css("border","1px solid red");
		}else if(value.length>length){
			str = "<span style='color:red'>* "+name+"长度不能大于"+length+"个字符</span>"
			$("#msg").html(str);
			$(el).attr("flag","false");
			$(el).css("border","1px solid red");
		}else{
			$(el).attr("flag","true");
			$("#msg").html("");
			$(el).css("border","1px solid #ccc");
		}
	}
	//添加权限-->zxj
	function toAddPermission(){
		$("#addRole").show();
		shipei();
	}
	//添加权限窗口关闭-->zxj
	function closeAddRole(){
		window.location.href = "${ctxPath}/v1/html/manage/permissionManage/query/permissionList.do";
		$("#addRole").hide();
	}
	//表单提交-->zyz
	function saveObj(number){
		$("#msg").html("");
		$("#name").blur();
		$("#url").blur();
		$("#type").blur();
		$("#description").blur();
		if ($("#name").attr('flag') == "true" && $("#description").attr('flag') == "true" && $("#url").attr('flag') == "true" && $("#type").attr('flag') == "true") {
			//锁屏图片显示
			$(".loading_chuan").show();
			var options = {
					success : function(data) {
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						$("#addRole").hide()
						if (data.result == 'ok') {
							Showbo.Msg.alert("保存成功",function(){
								if ($(".btnfocus").val() == "确定") {
									window.location.reload();
								}
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
						setTimeout(function(){ 
							$("#msg").html("");
						},3000);
					}
				};
				$("#submitCheck").ajaxSubmit(options);
		}else{
			$("#msg").html("<span style='color:red'>* 请检查填写有误的信息</span>");
		}
	}
	
	function toAddModule() {
		location.href = "${ctxPath}//v1/html/manage/moduleManage/create/toModule.do";
	}
	
	function updatePermission(permissionId) {
		location.href = "${ctxPath}/v1/html/manage/permissionManage/update/toUpdatePermission.do?permissionId="+permissionId;
	}
	</script>
</body>

</html>
