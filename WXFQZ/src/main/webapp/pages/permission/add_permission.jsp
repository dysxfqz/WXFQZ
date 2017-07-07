<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>添加权限</title>
<script type="text/javascript">
//提交审核
function submitPermission() {
	var options = {
		beforeSubmit:  function(){
			$(".loading_chuan").show();
		},
		success : function(data) {
			$(".loading_chuan").hide();
			if (data.result == 'ok') {
				alert("Saved Successfully");
				window.location.href = "${ctxPath}/v1/html/manage/permissionManage/query/permissionList.do";
			} else {
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			$(".loading_chuan").hide();
			alert("服务器异常");
			window.location.reload();//刷新当前页面.
		},
	};
	$("#submitPermission").ajaxSubmit(options);
} 	
</script>
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>增加权限</h1>
	</div>
	<div class="alert alert-info">
		<div class="row">
			<div class="col-xs-12">
			<form class="form-horizontal" id="submitPermission" autocomplete="off" role="form" action="${ctxPath}/v1/html/manage/permissionManage/create/createUserPermission.do" method="post">
					<!-- 权限名 -->
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限名</label>
							<div class="col-sm-9">
								<input type="text" name="name"  class="col-xs-10 col-sm-5"/>
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
					</div>
					
					<!-- 权限URL -->
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限URL</label>
						<div class="col-sm-9">
							<input type="text" name="url"  class="col-xs-10 col-sm-5"/>
							<span class="help-inline col-xs-12 col-sm-7">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<!-- 权限类型 -->
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限类型</label>
						<div class="col-sm-9">
							<select class="col-xs-10 col-sm-5" id="type" name="type">
						   		<option>--select</option>
						    	<option value="perms">perms</option>
						    	<option value="anon">anon</option>
						    </select>
							<span class="help-inline col-xs-12 col-sm-7">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<!-- 权限描述 -->
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">权限描述</label>
						<div class="col-sm-9">
							<input type="text" name="description"  class="col-xs-10 col-sm-5"/>
							<span class="help-inline col-xs-12 col-sm-7">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<!-- 所属模块 -->
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">所属模块</label>
						<div class="col-sm-9">
							<select class="col-xs-10 col-sm-5" id="type" name="type">
						   		<option>--select</option>
						    	<option value="perms">perms</option>
						    	<option value="anon">anon</option>
						    </select>
							<span class="help-inline col-xs-12 col-sm-7">
								<span class="middle" style="line-height:30px"></span>
							</span>
						</div>
					</div>
				</form>
			</div>
			<!-- 提交信息 -->
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right"></label>
				<div class="col-sm-9">
					<span class="btn btn-primary"  onclick="submitPermission()" style="width:200px;">确认
					</span>
				</div>
			</div>
		</div>
	</div>
</div>
 <div class="loading_chuan"><img class="load_img" <%-- src="${ctxPath}/static/source/img/75a5dba66839ad424b4dfafc9b707eb7.gif" --%>/></div> 
</body>

</html>
