<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../static/inc/taglib.jsp"%>
<html>
  <head>
    <title>用户认证信息</title>
    <link rel="stylesheet" href="${ctxPath}/static/source/style/userInfo.css">
  </head>
  <body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>用户认证信息</h1>
		</div>
		<div class="alert alert-info">
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" autocomplete="off" id="passwordForm" role="form" 
					action="${ctxPath}/v1/html/user/basicData/update/updateUserInfo.do" >
						<!-- 注册手机号 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">注册手机号</label>
							<div class="col-sm-9">
								<span class="col-xs-10 col-sm-5 existenceCon">${user.phone}</span>
								<!-- <span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"><a href="javascript:changePhone()">更换手机号</a></span>
								</span> -->
							</div>
						</div>
						<!-- 绑定邮箱 -->
						<c:if test="${userInfo.email != null}">
							<div class="form-group">
								<label class="col-sm-2 control-label no-padding-right">邮箱</label>
								<div class="col-sm-9">
	 								<input type="email"   name="email" id="email" value="${userInfo.email}"  placeholder="邮箱" class="col-xs-10 col-sm-5" readonly="readonly"/>
								</div>
							</div>
						</c:if>
						<!-- 头像链接 -->
						<input type="hidden" id="headUrl" name="headUrl" value="${userInfo.headUrl}">
						<!-- 姓名 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">身份证姓名</label>
							<div class="col-sm-9">
								<input type="text" placeholder="姓名"  name="name" id="name" value="${userInfo.idCardName}" class="col-xs-10 col-sm-5" readonly="readonly"/>
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 身份证号-->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">身份证号</label>
							<div class="col-sm-9">
								<input type="text" placeholder="身份证号"  name="documentId" id="documentId" value="${userInfo.documentId}" class="col-xs-10 col-sm-5" readonly="readonly"/>
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 性别 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">性别</label>
							<div class="col-sm-9">
							<div class="col-sm-4 col-xs-4">
								<div class="radio">
									<label>
										<input value="0" name="sex" checked type="radio" class="ace" <c:if test="${userInfo.sex == 0}" >checked </c:if> disabled>
										<span class="lbl">男</span>
									</label>
								</div>
							</div>
							<div class="col-sm-4 col-xs-4">
							<div class="radio">
									<label>
										<input value="1" name="sex" type="radio" class="ace" <c:if test="${userInfo.sex == 1}" >checked </c:if> disabled>
										<span class="lbl">女</span>
									</label>
								</div>
							</div>
						</div>
						</div>
						
						<!-- 地址 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">地址</label>
							<div class="col-sm-9">
								<div class="col-sm-4 col-xs-4" style="padding-left:0;">
									<input type="text" placeholder="省份" class="col-xs-12" 
									 name="province" id="province" value="${userInfo.province}" readonly="readonly" />
								</div>
								<div class="col-sm-4 col-xs-4">
									<input type="text" placeholder="城市" class="col-xs-12" 
									 name="city" id="city" value="${userInfo.city}" readonly="readonly" />
								</div>
								<div class="col-sm-4 col-xs-4">
									<input type="text" placeholder="市/县/区" class="col-xs-12" 
									 name="area" id="area" value="${userInfo.area}" readonly="readonly" />
								</div>
							</div>
						</div>
						
						<!-- 详细地址 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">详细地址</label>
							<div class="col-sm-9">
								<input type="text" placeholder="详细地址" class="col-xs-10 col-sm-5" 
								name="address" id="address" value="${userInfo.address}" readonly="readonly" />
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 邮政编码 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">邮政编码</label>
							<div class="col-sm-9">
								<input type="text" placeholder="邮政编码" class="col-xs-10 col-sm-5"
								name="postCode" id="postCode" value="${userInfo.postCode}" readonly="readonly"/>
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 用户状态 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">用户状态</label>
							<div class="col-sm-9">
							<c:if test="${user.qualificationStatus == 0}">
								<input type="text" placeholder="用户状态" class="col-xs-10 col-sm-5"
								name="postCode" id="postCode" value="未认证" readonly="readonly"/>
							</c:if>
							<c:if test="${user.qualificationStatus == 1}">
								<input type="text" placeholder="用户状态" class="col-xs-10 col-sm-5"
								name="postCode" id="postCode" value="认证中" readonly="readonly"/>
							</c:if>
							<c:if test="${user.qualificationStatus == 2}">
								<input type="text" placeholder="用户状态" class="col-xs-10 col-sm-5"
								name="postCode" id="postCode" value="认证通过" readonly="readonly"/>
							</c:if>
							<c:if test="${user.qualificationStatus == 3}">
								<input type="text" placeholder="用户状态" class="col-xs-10 col-sm-5"
								name="postCode" id="postCode" value="认证失败" readonly="readonly"/>
							</c:if>
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">证件图片</label>
							<div class="col-sm-4" id="uploadArea">
								<span class="profile-picture" id="localImag" >
									<img id="avatar" class="editable img-responsive" <c:if test="${userInfo.idCardUrl == null||userInfo.idCardUrl == ''}">src="${ctxPath}/static/ace/avatars/profile-pic.jpg"</c:if>
									 <c:if test="${userInfo.idCardUrl != null}">
										src="${filePath}/${userInfo.idCardUrl}"
									 </c:if> >
								</span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">认证拒绝原因</label>
							<div class="col-sm-9">
								<textarea placeholder="拒绝时请填写"  onblur="checkPassRea(this)" name ="noPassReason" id="noPassReason" class="col-xs-10 col-sm-5"></textarea>
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
							<c:if test="${user.qualificationStatus == 0}">
								<span class="btn btn-primary"  onclick="toQua1('${user.id}')"style="width:100px;">通过
								</span>
								<span class="btn btn-primary"  onclick="toQua2('${user.id}')"style="width:100px;">拒绝
								</span>
								<span class="btn btn-primary"  onclick="backUserMsg()"style="width:100px;">返回
								</span>
							</c:if>
							<c:if test="${user.qualificationStatus == 1}">
								<span class="btn btn-primary"  onclick="toQua1('${user.id}')"style="width:100px;">通过
								</span>
								<span class="btn btn-primary"  onclick="toQua2('${user.id}')"style="width:100px;">拒绝
								</span>
								<span class="btn btn-primary"  onclick="backUserMsg()"style="width:100px;">返回
								</span>
							</c:if>
							<c:if test="${user.qualificationStatus == 2}">
								<%-- <span class="btn btn-warning"  onclick="toQua1('${user.id}')"style="width:100px;">通过
								</span> --%>
								<span class="btn btn-primary"  onclick="toQua2('${user.id}')"style="width:100px;">拒绝
								</span>
								<span class="btn btn-primary"  onclick="backUserMsg()"style="width:100px;">返回
								</span>
							</c:if>
							<c:if test="${user.qualificationStatus == 3}">
								<span class="btn btn-primary"  onclick="backUserMsg()"style="width:100px;">返回
								</span>
							</c:if>
							</div>
						</div>
			</div>
		</div>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script>
	function backUserMsg(){
		window.location.href = '${ctxPath}/v1/html/manage/userManage/query/userList.do';
	}
	//校验拒绝原因
	function checkPassRea(el){
		comNam = $(el).val();
		if(comNam!="" && comNam.length<1024){
			$($(el).next().children()[0]).html("<i class='ace-icon fa fa-check-circle checkok'></i>");
		}
	}
	function toQua1 (el){
		Showbo.Msg.confirm("是否确定通过认证",function(){
			if($(".btnfocus").val() =="确定"){
				//锁屏图片显示
				$(".loading_chuan").show();
				$.ajax({
					type : "post",
					url : "${ctxPath}/v1/html/manage/userManage/update/passAudit.do",
					data : {
							el : el,
					      },
					dataType : "json",
					success : function(data){
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if( data.result == "ok"){
							Showbo.Msg.alert("认证成功",function(){
								 if($(".btnfocus").val() =="确定"){
									 window.location.href = "${ctxPath}/v1/html/manage/userManage/query/userList.do";
								 }
							});
						}else{
							Showbo.Msg.alert("认证失败");
						}
					},
				});
			}
		});
	}
	function toQua2 (el){
		var noPass = $("#noPassReason").val();
		if("" == noPass || null == noPass){
			$($("#noPassReason").next().children()[0]).html("<span style='color:red'>* 请输入拒绝原因</span>");
			return;
		}
		Showbo.Msg.confirm("是否确定拒绝认证",function(){
			if($(".btnfocus").val() =="确定"){
				//锁屏图片显示
				$(".loading_chuan").show();
				$.ajax({
					type : "post",
					url : "${ctxPath}/v1/html/manage/userManage/update/refuseAudit.do",
					data : {
							el : el,
							noPassReason : noPass,
					      },
					dataType : "json",
					success : function(data){
						//锁屏图片隐藏
						$(".loading_chuan").hide();
						if( data.result == "ok"){
							Showbo.Msg.alert("拒绝认证成功",function(){
								 if($(".btnfocus").val() =="确定"){
									 window.location.href = "${ctxPath}/v1/html/manage/userManage/query/userList.do";
								 }
							});
							
						}else{
							Showbo.Msg.alert("拒绝认证失败");
						}
					},
				});
			}
		});
	}
</script>
  </body>
</html>
