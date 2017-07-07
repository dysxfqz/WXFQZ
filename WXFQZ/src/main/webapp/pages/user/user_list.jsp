<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>用户管理</h1>
		</div>
		<span class="addPeo" style="margin-bottom:10px;" onclick="addPeople()">添加用户</span>
	<table id="userList" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th>No.</th>
			<th>手机号</th>
			<th>创建时间</th>
			<th>认证类型</th>
			<th>认证状态</th>
			<th>用户状态</th>
			<th class="center">操作</th>
			<!-- <td>启/禁用此用户</td> -->
			
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${userList}" var="user" varStatus='status'>
			<c:if test="${user.roleType==2}">
			<tr>
				<input type="hidden" value="${user.id}" name="userId">
				<td class="center">${status.index +1}</td>
				<td>${user.phone}</td>
				<td>${user.createTime}</td>
				<c:if test="${user.qualificationType == 0}">
					<td>个人</td>
				</c:if>
				<c:if test="${user.qualificationType == 1}">
					<td>企业</td>
				</c:if>
				<c:if test="${user.qualificationStatus == 0}">
					<td>未认证</td>
				</c:if>
				<c:if test="${user.qualificationStatus == 1}">
					<td>认证中</td>
				</c:if>
				<c:if test="${user.qualificationStatus == 2}">
					<td>通过认证</td>
				</c:if>
				<c:if test="${user.qualificationStatus == 3}">
					<td>认证失败</td>
				</c:if>
				<c:if test="${user.status == 0}">
					<td>禁用</td>
				</c:if>
				<c:if test="${user.status == 1}">
					<td>启用</td>
				</c:if>
				<td id="oper" class="center">
				<c:if test="${user.qualificationStatus == 1}">
					<span class="fa  fa-pencil-square-o" onclick="toChangeState('${user.id}');" data-toggle="tooltip" title="审核" style="cursor:pointer"></span>
				</c:if>
				<c:if test="${user.qualificationStatus == 2}">
				<span class="fa  fa-pencil-square-o" onclick="toChangeState('${user.id}');" data-toggle="tooltip" title="审核" style="cursor:pointer"></span>
				</c:if>
					<%-- <c:if test="${user.qualificationStatus == 2}">
					<span class="glyphicon glyphicon-remove" onclick="toQua2('${user.id}');" data-toggle="tooltip" title="取消认证" name="ra" style="cursor:pointer" ></span>
					</c:if>
					<c:if test="${user.qualificationStatus == 0}">
					<span class="glyphicon glyphicon-ok" onclick="toQua1('${user.id}');" data-toggle="tooltip" title="通过认证" name="ra" style="cursor:pointer" ></span>
					</c:if> --%>
					<c:if test="${user.status == 0}">
					<span class="fa fa-unlock" onclick="openUser('${user.id}');" data-toggle="tooltip" title="启用用户" name="ra" style="cursor:pointer" ></span>
					</c:if>
					<c:if test="${user.status == 1}">
					<span class="fa fa-lock"  onclick="closeUser('${user.id}');" data-toggle="tooltip" title="禁用用户" name="ra" style="cursor:pointer" ></span>
					</c:if>
				</td>
			</tr>
			</c:if>
		</c:forEach>
		</tbody>
	</table>
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
			<label class="col-sm-2 control-label no-padding-right">手机号</label>
			<div class="col-sm-9">
				<div class="input-group col-xs-12">
					<input class="form-control input-mask-date" id="phone" type="tel" value="" onblur="checkInputNull(this)">
					<div class="errorTip"></div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label no-padding-right">用户名</label>
			<div class="col-sm-9">
				<div class="input-group col-xs-12">
					<input class="form-control input-mask-date" id="userName" type="text" value="" onblur="checkInputNull(this)">
					<div class="errorTip"></div>
				</div>
			</div>
		</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right">密码</label>
				<div class="col-sm-9">
					<input class="form-control input-mask-date" id="pwd" type="password" value="" onblur="checkInputNull(this)">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label no-padding-right">确认密码</label>
				<div class="col-sm-9">
					<input class="form-control input-mask-date" id="repwd" type="password" value="" onblur="checkInputNull(this)">
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
<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
	<script>
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
	$(function(){
		var oTable1 =$('#userList').dataTable( {
				bAutoWidth: false,
				bStateSave: true,
				"aoColumns": [
				  { "bSortable": false },
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
		//提示工具
		 $("[data-toggle='tooltip']").tooltip(); 
	});
		function toChangeState(el){
			window.location.href = '${ctxPath}/v1/html/manage/userManage/update/auditUserInfo.do?id='+el;
		}
		
		function openUser (el){
			
			Showbo.Msg.confirm("确认要启动用户吗?",function(){
			     if($(".btnfocus").val() =="确定"){
					//锁屏图片显示
					$(".loading_chuan").show();
			    	 $.ajax({
							type : "post",
							url : "${ctxPath}/v1/html/manage/userManage/userManage/update/openUser.do",
							data : {        
									el : el,
							      },
							dataType : "json",
							success : function(data){
								//锁屏图片隐藏
								$(".loading_chuan").hide();
								if( data.result == "ok"){
									Showbo.Msg.alert("启用成功",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }                                        
									});
									
								}else{
									Showbo.Msg.alert("启用失败",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }
									});
								}
							},
						});
			     } else{
			    	//锁屏图片隐藏
				    $(".loading_chuan").hide();
			     }
			});

			
		}
		function closeUser (el){
			Showbo.Msg.confirm("确认要禁用用户吗?",function(){
			     if($(".btnfocus").val() =="确定"){
					//锁屏图片显示
					$(".loading_chuan").show()
			    	 $.ajax({
							type : "post",
							url : "${ctxPath}/v1/html/manage/userManage/update/disableUser.do",
							data : {
									el : el,
							      },
							dataType : "json",
							success : function(data){
								//锁屏图片隐藏
								$(".loading_chuan").hide();
								if( data.result == "ok"){
									Showbo.Msg.alert("禁止成功",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }
									});
								}else{
									Showbo.Msg.alert("启用失败",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }
									});
								}
							},
						});
			     } else{
			    	//锁屏图片隐藏
				    $(".loading_chuan").hide();
			     }
			});

		}
		
		function addU(){
			 $.ajax({
					type : "post",
					url : "${ctxPath}/",
					data : {
							el : el,
					      },
					dataType : "json",
					success : function(data){
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if( data.result == "ok"){
							Showbo.Msg.alert("禁止成功",function(){
								 if($(".btnfocus").val() =="确定"){
									 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
								 }
							});
						}else{
							Showbo.Msg.alert("启用失败",function(){
								 if($(".btnfocus").val() =="确定"){
									 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
								 }
							});
						}
					},
				});
			Showbo.Msg.confirm("确认要禁用用户吗?",function(){
			     if($(".btnfocus").val() =="确定"){
					//锁屏图片显示
					$(".loading_chuan").show()
			    	 $.ajax({
							type : "post",
							url : "${ctxPath}/v1/html/manage/userManage/update/disableUser.do",
							data : {
									el : el,
							      },
							dataType : "json",
							success : function(data){
								//锁屏图片隐藏
								$(".loading_chuan").hide();
								if( data.result == "ok"){
									Showbo.Msg.alert("禁止成功",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }
									});
								}else{
									Showbo.Msg.alert("启用失败",function(){
										 if($(".btnfocus").val() =="确定"){
											 window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
										 }
									});
								}
							},
						});
			     } else{
			    	//锁屏图片隐藏
				    $(".loading_chuan").hide();
			     }
			});

		}
	//新增用户
	function addPeople(){
		$(".editTask").show();
		$(".iso_alert").show();
		resizeIsoAlert();
	}
	//提交
	$("#editTaskBtn").click(function(){
		var phone = $("#phone").val();
		var userName = $("#userName").val();
		var pwd = $("#pwd").val();
		var repwd = $("#repwd").val();
		var Cphone = checkInputNull(document.getElementById("phone"));
		var CuserName = checkInputNull(document.getElementById("userName"));
		var Cpwd = checkInputNull(document.getElementById("pwd"));
		var Crepwd = checkInputNull(document.getElementById("repwd"));
		if(Cphone&&CuserName&&Cpwd&&Crepwd){
			var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
			if(!myreg.test(phone)){
				Showbo.Msg.alert("请输入正确的手机号码");
				return
			}
			if(userName.length>10){
				Showbo.Msg.alert("用户名最大长度为10位");
				return
			}
			if(pwd.length<6){
				Showbo.Msg.alert("密码长度最小为6位");
				return;
			}
			if(pwd!=repwd){
				Showbo.Msg.alert("两次输入的密码不相同");
				return
			}
			$.ajax({
				url:"${ctxPath}/v1/anon/user/create/regUserAdmin.do",
				type:"post",
				dataType:"json",
				data:{
					phone:phone,
					userName:userName,
					pwd:pwd
				},
				success:function(data){
					if(data.result=="ok"){
						Showbo.Msg.alert("增加成功",function(){
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
			Showbo.Msg.alert("您有未完善的信息，请返回查看");
		}
		
	});
	$('.iso_alertKuang').drag();
	//关闭编辑框
	$("#closeEditTask").click(function(){
		$(".editTask").hide();
		$(".iso_alert").hide();
		$("#phone").val("");
		$("#userName").val("");
		$("#pwd").val("");
		$("#repwd").val("");
	});
	//信息校验
	function checkInputNull(el){
		if(el.value==""){
			el.style.border="1px solid red";
			return false;
		}else{
			el.style.border="1px solid #ccc";
			return true;
		}
	}
	</script>
</body>
</html>
