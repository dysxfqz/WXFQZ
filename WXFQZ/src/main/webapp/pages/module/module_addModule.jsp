<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>模块添加</title>
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>模块添加</h1>
		</div>
		<div class="col-xs-12">
			<div class="alert alert-info">
				<div class="row">
					<div class="col-xs-12">
						<form class="form-horizontal" autocomplete="off" id="addModuleForm"
							role="form" action="${ctxPath}/v1/html/manage/moduleManage/create/createModule.do"
							method="post">
							<!-- 菜单名称 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">所属菜单</label>
								<div class="col-sm-9">
									<select name="menuId">
										<c:forEach items="${menuList }" var="bean">
											<c:if test="${bean.rank != 2}"><option value="${bean.id }">${bean.name }</option></c:if>
										</c:forEach>
									</select>
									<input type="button" value="添加菜单" onclick="toAddMenu()" style="background: #6fb3e0;border: none;color: #fff;padding: 5px;cursor: pointer;">
								</div>
							</div>
							<!-- 模块名称 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">模块名称</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入模块名称" name="name" id="name"
										onblur="checkLengthuser('name', '1024', '您输入长度过长')"
										class="col-xs-10 col-sm-5" />
								</div>
							</div>
							<!-- 描述 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">描述</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入描述" name="description" id="description"
										onblur="checkLengthuser('description', '1024', '您输入长度过长')"
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
			var description = checkLengthuser('description', '1024', '您输入长度过长');
			if (name && description) {
				//锁屏图片显示
				$(".loading_chuan").show();
				var options = {
					success : function(data) {
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("保存成功", function() {
								if ($(".btnfocus").val() == "确定") {
									window.location="${ctxPath}/v1/html/manage/moduleManage/query/moduleList.do";
								}
							});
						} else {
							Showbo.Msg.alert(data.errormsg);						}
					}
				};
				$("#addModuleForm").ajaxSubmit(options);
			}
		}
		
		function toAddMenu() {
			location.href = "${ctxPath}/v1/html/manage/menuManage/create/toMenu.do";
		}
	</script>
</body>
</html>