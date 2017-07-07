<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>权限编辑</title>
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>权限编辑</h1>
		</div>
		<div class="col-xs-12">
			<div class="alert alert-info">
				<div class="row">
					<div class="col-xs-12">
						<form class="form-horizontal" autocomplete="off" id="updatePermissionForm"
							role="form" action="${ctxPath}/v1/html/manage/permissionManage/update/updatePermission.do"
							method="post">
							<!-- 所属模块 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">所属模块</label>
								<div class="col-sm-9">
									<select name="module_id">
										<option value="1" <c:if test="${userPermission.moduleType == 1 } or ${userPermission.moduleId == '- -' }">selected=true</c:if>>--请选择--</option>
										<%-- <option value="2" <c:if test="${userPermission.module_type == 2 } && ${userPermission.module_id }.equals(null)">selected=true</c:if>>- -</option> --%>
										<c:forEach items="${moduleList }" var="bean">
											<option value="${bean.id }" <c:if test="${bean.id == userPermission.moduleId }">selected=true</c:if>>${bean.description }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<!-- 名称 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">权限名称</label>
								<div class="col-sm-9">
									<input type="hidden" name="id" value="${userPermission.id }" />
									<input type="text" placeholder="请输入菜单名称" name="name" id="name" value="${userPermission.name }"
										onblur="checkLengthuser('name', '1024', '您输入长度过长')"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
							<!-- URL -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">URL</label>
								<div class="col-sm-9">
									<input type="text" name="url" id="url" value="${userPermission.url }" 
									onblur="checkLengthuser('url', '1024', '您输入长度过长')" />
								</div>
							</div>
							<!-- 权限类型 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">权限类型</label>
								<div class="col-sm-9">
									<select name="type">
										<option value="perms" >perms</option>
										<option value="anon" <c:if test="${userPermission.type ==  'anon'}">selected=true</c:if>>anon</option>
									</select>
								</div>
							</div>
							<!-- 权限描述 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">权限描述</label>
								<div class="col-sm-9">
									<input type="text" name="description" id="description" value="${userPermission.description }" 
									onblur="checkLengthuser('description', '1024', '您输入长度过长')" />
								</div>
							</div>
						</form>
						<!-- 提交 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right"></label>
							<div class="col-sm-9">
								<input class="btn btn-warning" type="button"
									onclick="submitForm()" value="确认" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script type="text/javascript">
		//输入文本框长度校验
		function checkLengthuser(id, length, msg) {
			var temp = $("#" + id).val();
			if (temp == "" || temp == null) {
				$("#" + id).css("border", "1px solid red");
			} else {
				if ($("#" + id).val().length < length) {
					$("#" + id).css("border", "1px solid #ccc");
					return true;
				} else {
					$("#" + id).css("border", "1px solid red");
					$("#" + id).val("");
					$("#" + id).attr("placeholder", msg);
					return false;
				}
			}
		}
		//提交
		
		function submitForm(number) {
			var name = checkLengthuser('name', '1024', '您输入长度过长');
			var url = checkLengthuser('url', '1024', '您输入长度过长');
			var description = checkLengthuser('description', '1024', '您输入长度过长');
			/* if (name && htmlId && htmlClass) {
				$('#addMenuForm').submit();
			} */
			if (name && url && description) {
				//锁屏图片显示
				$(".loading_chuan").show();
				var options = {
					success : function(data) {
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("编辑成功", function() {
								if ($(".btnfocus").val() == "确定") {
									window.location="${ctxPath}/v1/html/manage/permissionManage/query/permissionList.do";
								}
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
					}
				};
				$("#updatePermissionForm").ajaxSubmit(options);
			}
		}
	</script>
</body>
</html>