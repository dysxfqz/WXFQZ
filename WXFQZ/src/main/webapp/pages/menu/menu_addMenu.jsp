<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>菜单添加</title>
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>菜单添加</h1>
		</div>
		<div class="col-xs-12">
			<div class="alert alert-info">
				<div class="row">
					<div class="col-xs-12">
						<form class="form-horizontal" autocomplete="off" id="addMenuForm"
							role="form" action="${ctxPath}/v1/html/manage/menuManage/create/createMenu.do"
							method="post">
							<!-- 菜单名称 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">菜单名称</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入菜单名称" name="name" id="name"
										onblur="checkLengthuser('name', '1024', '您输入长度过长')"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
							<!-- 权限 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">权限</label>
								<div class="col-sm-9">
									<select id="permission_id" name="permission_id"
										style="margin-top: 5px; min-width: 145px">
										<option value="0">--请选择--</option>
										<c:forEach items="${userPermissionList }" var="bean">
											<option value="${bean.id }">${bean.description }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<!-- 父级菜单 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">父级菜单</label>
								<div class="col-sm-9">
									<select id="pid" name="pid"
										style="margin-top: 5px; min-width: 145px">
										<option value="0">--请选择--</option>
										<c:forEach items="${fatherMenuList }" var="bean">
											<c:if test="${bean.rank != 2}"><option value="${bean.id }">${bean.name }</option></c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<!-- 标签名称(htmlId) -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">标签名称(htmlId)</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入标签名称(htmlId)" name="htmlId"
										id="htmlId"
										onblur="checkLengthuser('htmlId', '64', '您输入长度过长')"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
							<!-- 样式名称(htmlClass) -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">样式名称(htmlClass)</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入样式名称(htmlClass)"
										name="htmlClass" id="htmlClass"
										onblur="checkLengthuser('htmlClass', '64', '您输入长度过长')"
										class="col-xs-10 col-sm-5" />
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
			var htmlId = checkLengthuser('htmlId', '64', '您输入长度过长');
			var htmlClass = checkLengthuser('htmlClass', '64', '您输入长度过长');
			
			if (name && htmlId && htmlClass) {
				//锁屏图片显示
				$(".loading_chuan").show();
				var options = {
					success : function(data) {
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("保存成功", function() {
								if ($(".btnfocus").val() == "确定") {
									window.location="${ctxPath}/v1/html/manage/menuManage/query/menuList.do";
								}
							});
						} else {
							Showbo.Msg.alert(data.errormsg);
						}
					},
					error:function(){
						Showbo.Msg.alert("服务器异常");
					}
				};
				$("#addMenuForm").ajaxSubmit(options);
			}
		}
	</script>
</body>
</html>