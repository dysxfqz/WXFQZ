<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>参数设置修改</title>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>参数设置修改</h1>
		</div>
		<div class="col-xs-12">
			<div class="alert alert-info">
				<div class="row">
					<div class="col-xs-12">
						<form class="form-horizontal" autocomplete="off" id="addModuleForm"
							role="form" action="${ctxPath}/v1/anon/manage/systemManage/update/saveSystem.do"
							method="post">
							<input type="hidden"  name="system_logo_name" value ="system_logo"/>
							<!-- 系统参数 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">系统原名称</label>
								<div class="col-xs-10 col-sm-5"   style="margin-top: 0.5%;">${system_logo}</div>
							</div>
							<!-- 描述 -->
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">系统名称修改</label>
								<div class="col-sm-9">
									<input type="text" placeholder="请输入名称" name="system_logo_new" id="description"
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
			var description = checkLengthuser('description', '1024', '您输入长度过长');
			if (description) {
				//锁屏图片显示
				$(".loading_chuan").show();
				var options = {
					success : function(data) {
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert("保存成功", function() {
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
				};
				$("#addModuleForm").ajaxSubmit(options);
			}
		}
		
		
	</script>
</body>
</html>