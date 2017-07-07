<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>角色管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/role_list.css">
</head>
<body>
<div class="col-xs-12">
<input type="button" class="btn btn-info" style="margin:10px;" value="添加角色" onclick="toAddRole()">
<h3></h3>
<div class="table-header">角色管理</div>
	<table id="role-list" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center">
				<div class="checkbox">
					<label>
						<input value="" name="deleteRoleAll" type="checkbox" class="ace" >
						<span class="lbl"></span>
					</label>
				</div>
			</th>
			<th class="center">No.</th>
			<th>名称</th>
			<th>描述</th>
			<td>操作</td>
			<td class="center">
				<span onclick="deleteRole()" class="glyphicon glyphicon-trash" data-toggle="tooltip" title="删除角色" style="cursor:pointer"></span>
			</td>
		</tr>
		</thead>
		<c:forEach items="${userRoleList}" var="p" varStatus='status'>
			<tr>
				<td class="center">
				<c:if test="${p.defaultRole == 0}">
					<div class="checkbox">
					<label>
						<input value="${p.id }" name="deleteRole" type="checkbox" class="ace" >
						<span class="lbl"></span>
					</label>
				</div>
				</c:if>
				</td>
				<td class="center">${status.index +1}</td>
				<td>${p.name }</td>
				<td>${p.description }</td>
				<td>
					<a href="${ctxPath}/v1/html/manage/roleManage/create/toRolePermission.do?id=${p.id }">给角色添加权限</a>
				</td>
				<td class="center">
					<c:if test="${p.defaultRole == 0}">
						<span onclick="deleteRole('${p.id}')" class="glyphicon glyphicon-trash" data-toggle="tooltip" title="删除角色" style="cursor:pointer"></span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	<!-- 添加角色 -->
	<div class="alertInfo" id="addRole">
	<div class="alertInfo-content alert-content col-xs-12 col-md-4" >
		<div class="header smaller lighter">
			<h4>添加角色<span class="pull-right closeWin" onclick="closeAddRole()">&times;</span></h4>
		</div>
		<div class="alertInfo-body col-xs-12">
				<form class="form-horizontal" autocomplete="off" action="${ctxPath}/v1/html/manage/roleManage/create/createRole.do" id="submitCheck" role="form" >
					<div class="form-group"> 
						<span class="col-xs-12" id="msg" style="text-align: center;"></span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">名称</label>
						<div class="col-sm-9">
							<input type="text" placeholder="名称"  name="name" id="name" class="col-xs-10 col-sm-10" onblur="checkBlur('名称',this,32)"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">描述</label>
						<div class="col-sm-9">
							<input type="text" placeholder="描述"  name="description" id="description" class="col-xs-10 col-sm-10" onblur="checkBlur('描述',this,1024)"/>
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
		var oTable1 =$('#role-list').dataTable( {
				bStateSave: true,
				bAutoWidth: false,
				"aoColumns": [
				 { "bSortable": false },
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
	//添加角色窗口显示-->zxj
	function toAddRole(){
		$("#addRole").show();
		shipei();
	}
	//添加角色窗口关闭-->zxj
	function closeAddRole(){
		$("#addRole").hide();
		window.location.href = "${ctxPath}/v1/html/manage/roleManage/query/roleList.do";
		//$("#addRole").css("z-index","-9999");
	}
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
	//表单提交-->zyz
	function saveObj(number){
		$("#msg").html("");
		$("#name").blur();
		$("#description").blur();
		
		if ($("#name").attr('flag') == "true" && $("#description").attr('flag') == "true") {
			//锁屏图片显示
			$(".loading_chuan").show();
			var options = {
					success : function(data) {
						$("#addRole").hide()
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("保存成功",function(){
								if ($(".btnfocus").val() == "确定") {
									window.location.reload();
								}
							});
						}else{
							Showbo.Msg.alert(data.errormsg);
						}
// 						if (data.result == 'ok') {
// 							$("#msg").html("保存成功");
// 							$("#reset").click();//清空表单
// 						} else {
// 							$("#msg").html("保存失败");
// 						}
// 						setTimeout(function(){ 
// 							$("#msg").html("");
// 						},3000);
					}
				};
				$("#submitCheck").ajaxSubmit(options);
		}else{
			$("#msg").html("<span style='color:red'>* 请检查填写有误的信息</span>");
		}
	}

	//角色删除(可多选)-->zyz
	function deleteRole(el) {
		var ss = "";
		if (el != null) {
			ss = el;
		} else {
			var rolesIdList = document.getElementsByName("deleteRole");
			for (k in rolesIdList) {
				if (rolesIdList[k].checked)
					ss += rolesIdList[k].value + ",";
			}
		}
		if (ss.length != 0) {
			Showbo.Msg.confirm("您确认要删除吗? ",function() {
				$(".loading_chuan").show();
				if ($(".btnfocus").val() == "确定") {
					$.ajax({
								url : "${ctxPath}/v1/html/manage/roleManage/delete/deleteRole.do",
								type : "post",   
								data : {
									userRoleIdList : ss,
								},
								datatype : "json",
								success : function(data) {
									$(".loading_chuan").hide();
									if (data.result == 'ok') {
										window.location.href = "${ctxPath}/v1/html/manage/roleManage/query/roleList.do";
									} else {
										Showbo.Msg.alert(data.errormsg);
										$(".loading_chuan").hide();
									}
								},
								error : function() {
									Showbo.Msg.alert("服务器异常");
									$(".loading_chuan").hide();
									return;
								}
							});
				}
				if ($(".btnfocus").val() == "取消") {
					window.location.href = "${ctxPath}/v1/html/manage/roleManage/query/roleList.do";
					return;
				}
			});
		} else {
			Showbo.Msg.alert("请选择您要删除的记录！");
		}
	}
	$("input[name=deleteRoleAll]").click(function(){
		if($(this).is(":checked")){
			$("input[name=deleteRole]").attr("checked",true);
			$("input[name=deleteRole]").prop("checked",true);
		}else{
			$("input[name=deleteRole]").attr("checked",false);
			$("input[name=deleteRole]").prop("checked",false);
		}
	});
	$("input[name=deleteRole]").click(function(){
		if($("input[name=deleteRole]").length==$("input[name=deleteRole]:checked").length){
			$("input[name=deleteRoleAll]").attr("checked",true);
			$("input[name=deleteRoleAll]").prop("checked",true);
		}else{
			$("input[name=deleteRoleAll]").attr("checked",false);
			$("input[name=deleteRoleAll]").prop("checked",false);
		}
	});
</script>
</body>
</html>
