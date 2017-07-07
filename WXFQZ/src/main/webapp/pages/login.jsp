<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../static/inc/taglib.jsp"%>
<html>
<head>
<title>用户登录</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="description" content="User login page" />
<meta http-equiv="pragma" content="no-cache"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="shortcut icon" type="image/x-icon" href="${ctxPath}/static/source/img/favicon.ico">

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap.css" />
<link rel="stylesheet" href="${ctxPath}/static/ace/css/font-awesome.css" />

<!-- text fonts -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace.css" />



<!--[if lte IE 9]>
	<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-part2.css" />
<![endif]-->
<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-rtl.css" />

<!--[if lte IE 9]>
  <link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-ie.css" />
<![endif]-->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="${ctxPath}/static/ace/js/html5shiv.js"></script>
<script src="${ctxPath}/static/ace/js/respond.js"></script>
<![endif]-->
<!-- change ace style-->
<link rel="stylesheet" href="${ctxPath}/static/source/style/changeace.css" />
<link rel="stylesheet" href="${ctxPath}/static/source/style/global.css" />
<!-- this page styles -->
<link rel="stylesheet" href="${ctxPath}/static/source/style/login.css" />
</head>
<body class="login-layout light-login" style="background-color:#fff !important;background:#fff">
<!--[if lte IE 8]>
<div id="ie8Tip">
	<div>
		<div>
			<img src="${ctxPath}/static/source/img/forie.png">
		</div>
	</div>
</div>
<![endif]-->
		<div class="bgimg">
		</div>
		<div class="main-container">
			<div class="main-content" style="min-height:98%">
				<div class="row" >
				
					<div class="container" >
					<div class="midContent">
						<img src="${ctxPath}/static/source/img/logo.png" style="width:800px;">
<%-- 						<img src="${ctxPath}/static/source/img/shuiwu.png" style="width:70px;vertical-align: bottom;margin-bottom: 7px;margin-left: 10px;" ><br> --%>
						<span style="text-align:center;float:left;margin-left: 37px;">
							<img src="${ctxPath}/static/source/img/mo.png" style="margin-top:40px;"><br>
						</span>
					
						<div class="login-container" style="border-radius: 10px;margin-top:40px;">
							
							<div class="space-6"></div>

							<div class="position-relative" style="border-radius: 10px;">
								<div id="login-box" class="login-box visible widget-box no-border" style="border-radius: 10px;">
									<div class="widget-body" style="border-radius: 10px;">
										<div class="widget-main" style="border-radius: 10px;">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-coffee green"></i>
												登录
											</h4>

											<div class="space-6"></div>
											<p id="login-tip"></p>
											<form>
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" id="userName" name="userName" placeholder="用户名" />
															<i class="ace-icon fa fa-user"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" id="password" name="password" class="form-control" placeholder="密码" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>
				
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
														<input id="veryCode" style="width: 60%;" class="form-control" name="veryCode" type="text" />
														<i class="ace-icon" style="right:28px" onclick="changeImg('imgObj1')"><img id="imgObj1" alt="" src="${ctxPath}/v1/anon/user/create/verifyCode.do" style=""/></i>	
														<span class="ace-icon glyphicon glyphicon-refresh" onclick="changeImg('imgObj1')" data-toggle="tooltip" title="刷新验证码"  style="cursor:pointer" ></span>
														</span>
													</label>
				
				
													<div class="space"></div>

													<div class="clearfix">
														<label class="inline">
															<input type="checkbox" class="ace" id="rememberMe"/>
															<span class="lbl"> 记住我</span>
														</label>

														<button type="button" onclick="login()" class="width-35 pull-right btn btn-sm btn-primary">
															<i class="ace-icon fa fa-key"></i>
															<span class="bigger-110 loginWait">登录</span>
														</button>
													</div>

													<div class="space-4"></div>
												</fieldset>
											</form>

										</div><!-- /.widget-main -->

										<div class="toolbar clearfix" style="border-width:0;">
											<div style="display:none">
												<a href="#" data-target="#forgot-box" onclick="gotoLogin('重置密码','imgObj2');"  class="forgot-password-link">
													<i class="ace-icon fa fa-arrow-left"></i>
													忘记密码
												</a>
											</div>

											<div style="display:none">
												<a href="#" data-target="#signup-box" onclick="gotoLogin('用户注册','imgObj3');" class="user-signup-link" >
													注册
													<i class="ace-icon fa fa-arrow-right"></i>
												</a>
											</div>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.login-box -->

								<div id="forgot-box" class="forgot-box widget-box no-border">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-key"></i>
												重置密码
											</h4>

											<div class="space-6"></div>
											<p id="forgot-tip"></p>

											<form>
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" id="rephone" placeholder="手机号" />
															<i class="ace-icon fa fa-phone"></i>
														</span>
													</label>
													
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
														<input id="veryCode2" style="width: 60%;" class="form-control" name="veryCode2" type="text" />
														<i class="ace-icon" style="right:28px" onclick="changeImg('imgObj2')"><img id="imgObj2" alt=""  src="" style=""/></i>	
														<span class="ace-icon glyphicon glyphicon-refresh" onclick="changeImg('imgObj2')" data-toggle="tooltip" title="刷新验证码"  style="cursor:pointer" ></span>
														</span>
													</label>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control" id="recode" placeholder="请输入手机验证码"/>
															<span class="ace-icon btn btn-info get-code" id="spanre" onclick="getCode(this)">获取验证码</span>
														</span>
													</label>
													
													<label class="block clearfix">
														<span class="block input-icon input-icon-right" style="text-align:center" >
															<span class="btn btn-primary forWait" onclick="resetPwd()" style="width: 200px;margin-top: 20px;margin-bottom: -10px;">提交</span>
														</span>
													</label>
												</fieldset>
											</form>
										</div><!-- /.widget-main -->

										<div class="toolbar center">
											<a href="#" data-target="#login-box" onclick="gotoLogin('用户登录','imgObj1')" class="back-to-login-link">
												返回登录
												<i class="ace-icon fa fa-arrow-right"></i>
											</a>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.forgot-box -->

								<div id="signup-box" class="signup-box widget-box no-border" style="margin-top:-87px">
									<div class="widget-body">
										<div class="widget-main">
											<h4 class="header blue lighter bigger">
												<i class="ace-icon fa fa-users blue"></i>
												用户注册
											</h4>

											<div class="space-6"></div>
											<p id="signup-tip"></p>

											<form>
												<fieldset>
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="tel" id="phone" name="phone" class="form-control" placeholder="手机号" />
															<i class="ace-icon fa fa-phone"></i>
														</span>
													</label>
													
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
														<input id="veryCode3" style="width: 60%;" class="form-control" name="veryCode3" type="text" />
														<i class="ace-icon" style="right:28px" onclick="changeImg('imgObj3')"><img id="imgObj3" alt="" src="" style=""/></i>	
														<span class="ace-icon glyphicon glyphicon-refresh" onclick="changeImg('imgObj3')" data-toggle="tooltip" title="刷新验证码"  style="cursor:pointer" ></span>
														</span>
													</label>
													
													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<span class="ace-icon btn btn-info get-code" id="spanP" onclick="getCode(this)">获取验证码</span>
															<input type="text" class="form-control" id="code" placeholder="请输入手机验证码"/>
															
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" id="pwd" placeholder="密码"/>
															<i class="ace-icon fa fa-lock"></i>
														</span>
													</label>

													<label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control" id="repwd" placeholder="再次输入密码"/>
															<i class="ace-icon fa fa-retweet"></i>
														</span>
													</label>
													
													<label class="block">
														<input type="checkbox" class="ace" id="selectMe"/>
														<span class="lbl">
															我接受
															<a href="#">用户协议</a>
														</span>
													</label>

													<div class="space-24"></div>

													<div class="clearfix">
														<button type="reset" id="resteForm" onclick="clearCreTip()" class="width-30 pull-left btn btn-sm">
															<i class="ace-icon fa fa-refresh"></i>
															<span class="bigger-110">重置</span>
														</button>

														<button type="button" class="width-65 pull-right btn btn-sm btn-primary" onclick="regUser();">
															<span class="bigger-110 sinWait">提交</span>
														</button>
													</div>
												</fieldset>
											</form>
										</div>

										<div class="toolbar center">
											<a href="#" data-target="#login-box" onclick="gotoLogin('用户登录','imgObj1')" class="back-to-login-link">
												<i class="ace-icon fa fa-arrow-left"></i>
												返回登录
											</a>
										</div>
									</div><!-- /.widget-body -->
								</div><!-- /.signup-box -->
							</div><!-- /.position-relative -->
						</div></div>
					</div><!-- /.col -->
				</div><!-- /.row -->
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->
<div class="loginBottomWord">北京市博金恒信科技咨询有限公司<br>V1.0</div>
    <!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script src="${ctxPath}/static/ace/js/bootbox.js"></script>

<script src='${ctxPath}/static/source/js/cookie.js'></script>
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='${ctxPath}/static/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>
		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
			 $(document).on('click', '.toolbar a[data-target]', function(e) {
				e.preventDefault();
				var target = $(this).data('target');
				$('.widget-box.visible').removeClass('visible');//hide others
				$(target).addClass('visible');//show target
			 });
			});
</script>
<script>
//切换登录注册和忘记密码时，刷新验证码，同时更改页面titile
function gotoLogin(name,id){
	document.title=name;
	changeImg(id);
}
//是页面在不用分辨率下自动适应
$(".bgimg").css({ "margin-top": (document.documentElement.clientHeight - 800) / 3});
$(".midContent").css({ "margin-top": (document.documentElement.clientHeight - $("#midContent").height())/5});

//记住我功能，从cookie中获取用户名和密码，如果有自动填充到表单当中
var cookieUserName = getCookie("authServer_userName");
var cookiePwd = getCookie("authServer_userPssword");
if(cookieUserName!=null){
	$("#userName").val(cookieUserName);	
	$("#password").val(cookiePwd);
	$("#rememberMe").attr("checked",true);	
}
//清除注册提示
function clearCreTip(){
	$("#signup-tip").html("");
}
//登录
var judge=Array();//用于违规操作提醒
var loginLock = true;//登录锁，避免频繁点击登录按钮
var signLock = true;//注册锁，避免频繁点击注册按钮
var forgLock = true;//忘记密码锁，避免频繁点击忘记密码按钮
function login(){
	judge.splice(0,judge.length);
	$("#login-tip").html("");
	if(loginLock==false){
		$("#login-tip").html("* 正在登录，请稍后...");
		return;
	}
	//判断用户名是否为空
	var userName=$("#userName").val();
	if(userName==""){
		judge.push("用户名")
	}
	
 	//判断密码是否为空
	var password=$("#password").val();
	if(password==""){
		judge.push("密码")
	}
	//判断验证码是否为空
	var veryCode=$("#veryCode").val();
	if(veryCode==""){
		judge.push("验证码")
	}
	//通过数组来实现违规操作后提醒
	if(judge.length>0){
		var judgeStr="* ";
		for(var i=0;i<judge.length;i++){
			if(i!=judge.length-1){
				judgeStr += judge[i]+"，";
			}else{
				judgeStr += judge[i]+"不能为空";
			}
		}
		$("#login-tip").html(judgeStr);
		judge.splice(0,judge.length); 
		return;
	}
	loginLock = false;
	$(".loginWait").html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
	jQuery.post('${ctxPath}/v1/anon/user/query/login.do', {userName:userName,password:password,veryCode:veryCode}, function(data){
		if(data.result == 'ok'){
			
			if($("#rememberMe").is(":checked")){
				setCookie("authServer_userName",userName,1000);
				setCookie("authServer_userPssword",password,1000);
			}else{
				delCookie("authServer_userName");
				delCookie("authServer_userPssword");
			}
			window.location.href = '${ctxPath}'+data.values;
			loginLock = true;
			//$(".loginWait").html("登录");
		}else {
			changeImg('imgObj1');
			$("#login-tip").html("*"+data.errormsg);
			loginLock = true;
			$(".loginWait").html("登录");
		}
    });
}
$("#veryCode").keydown(function(event){
	var keycode = (event.keyCode ? event.keyCode : event.which);  
    if(keycode == '13'){  
    	login();
    }  
});
//注册或忘记密码违规操作提示
function sinOrforgetTip(id,tipMessage){
	if(id=="spanre"){
		$("#forgot-tip").html(tipMessage);
	}else if(id=="spanP"){
		$("#signup-tip").html(tipMessage);
	}
}
//获取手机验证码
function getCode(el){
	var id = $(el).attr("id");
	if($(el).html()=="获取验证码"){
		var phone = $(el).parent().parent().prev().prev().find("input").val();
		var veryCode = $(el).parent().parent().prev().find("input").val();
		if(phone==""||phone==null ){
			sinOrforgetTip(id,"* 请输入手机号");
			return;
		}
		var num=/^1[34578]{1}\d{9}$/;
		if(!num.test(phone)){
			sinOrforgetTip(id,"* 请输入正确的手机号");
			return;
		}else if(phone.length!=11){
			sinOrforgetTip(id,"* 手机号码长度不正确");
			return;
		}
		$(el).html("发送中");
		sinOrforgetTip(id,"");
		$.ajax({
			type : "post",
			url : "${ctxPath}/v1/anon/user/query/getIdCode.do",
			data : {
					phone : phone,
					id : id,
					veryCode:veryCode
			      },
			dataType : "json",
			success : function(data){
				if( data.result == "ok"){
					$("#code").val(data.values);
					$(el).removeClass("btn-info");
					$(el).addClass("btn-default");
					$(el).html("60s后重发");
					var timeLoop = setInterval(function(){
						var countNum = parseInt($(el).html())-1;
						$(el).html(countNum+"s后重发");
					},1000);
					setTimeout(function(){
						clearInterval(timeLoop);
						$(el).addClass("btn-info");
						$(el).removeClass("btn-default");
						$(el).html("获取验证码");
					},60000);
				}else if( data.result == "error"){
					$(el).html("获取验证码");
					console.log(data.errormsg);
					sinOrforgetTip(id,"* "+data.errormsg);
				}
			}
		});
		
	}else{
		//alert("请稍后再试");
	}
	
}
//更新验证码图片
 function changeImg(id){  
    var imgSrc = $("#"+id);    
    var src = "${ctxPath}/v1/anon/user/create/verifyCode.do";
    	//console.log(src);
    imgSrc.attr("src",chgUrl(src));    
}    
//时间戳    
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳    
function chgUrl(url){
	//console.log(url);
    var timestamp = (new Date()).valueOf();    
    var urlurl = url.substring(0,14);    
    if((url.indexOf("&")>=0)){    
        urlurl = url + "×tamp=" + timestamp;    
    }else{    
        urlurl = url + "?timestamp=" + timestamp;    
    }    
    return urlurl;    
}
//注册用户方法
function regUser(){
	if(signLock ==false){
		$("#signup-tip").html("* 注册中，请稍后...");
		return;
	}
	var phone = $("#phone").val();
	var pwd = $("#pwd").val();
	var repwd = $("#repwd").val();
	var code = $("#code").val();
	var selMe = $("#selectMe").is(":checked");
	var num=/^1[34578]{1}\d{9}$/;
	//校验手机号
	if(phone==""||phone==null ){
		judge.push("请输入手机号");
	}else if(!num.test(phone)){
		judge.push("请输入正确的手机号");
	}else if(phone.length!=11){
		judge.push("手机号码长度不正确");
	}
	if( pwd != repwd ){
		judge.push("两次输入的密码不一致");
	}
	if( code == "" || code == null){
		judge.push("手机验证码不能为空");
	}
	if( !selMe ){
		judge.push("请阅读用户协议");
	}
	if(judge.length>0){
		var judgeStr="* ";
		for(var i=0;i<judge.length;i++){
			if(i!=judge.length-1){
				judgeStr;
			}else{
				judgeStr += judge[i];
			}
		}
		$("#signup-tip").html(judgeStr);
		judge.splice(0,judge.length); 
		return;
	}
	signLock = false;
	$(".sinWait").html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
	$.ajax({
		type : "post",
		url : "${ctxPath}/v1/anon/user/create/regUser.do",
		data : {
				phone : phone,
				pwd : pwd,
				code : code,
		      },
		dataType : "json",
		success : function(data){
			if( data.result == "ok"){
				$(".sinWait").html("提交");
				$("#signup-tip").html("<span style='color:green'>* 注册成功,<span class='timeCut'>3</span>秒后跳转登录页面</span>");
				var timecu = setInterval(function(){
					$(".timeCut").html($(".timeCut").html()-1);
				},1000);
				setTimeout(function(){
					location.reload();
					signLock = true;
					clearInterval(timecu);
				},3000);
				
			}else{
				$("#signup-tip").html("* "+data.errormsg);
				signLock = true;
				$(".sinWait").html("提交");
			}
		},
		error : function(){
			$("#signup-tip").html("* 连接失败");
			signLock = true;
			$(".sinWait").html("提交");
		}
	});
}
//重置密码方法
function resetPwd(){
	if(forgLock==false){
		$("#forgot-tip").html("* 重置中，请稍后...");
		return;
	}
	var phone = $("#rephone").val();
	var code = $("#recode").val();	
	var num=/^1[34578]{1}\d{9}$/;
	
	if(phone==""||phone==null ){
		judge.push("手机号不能为空");
	}else if(!num.test(phone)){
		judge.push("请输入正确的手机号");
	}else if(phone.length!=11){
		judge.push("手机号码长度不正确");
	}
	if(code==""||code==null){
		judge.push("手机验证码不能为空");
	}
	if(judge.length>0){
		var judgeStr="";
		for(var i=0;i<judge.length;i++){
			if(i!=judge.length-1){
				judgeStr += judge[i]+"，";
			}else{
				judgeStr += judge[i];
			}
		}
		$("#forgot-tip").html("* "+judgeStr);
		judge.splice(0,judge.length); 
		return;
	}
	forgLock = false;
	$(".forWait").html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
	$.ajax({
		type : "post",
		url : "${ctxPath}/v1/anon/user/creat/resetPassword.do",
		data : {
				phone : phone,
				code : code,
		      },
		dataType : "json",
		success : function(data){
			forgLock = true;
			if( data.result == "ok"){
				//密码重置成功，系统已将新密码发送到您的手机上，请注意查收
				$("#forgot-tip").html("<span style='color:green'>*" +data.values+"</span>");
				$(".forWait").html("提交");
				setTimeout(function(){
					window.location.reload();
				},3000);
			}else{
				$("#forgot-tip").html("* "+data.errormsg);
				$(".forWait").html("提交");
			}
		},
		error : function(){
			forgLock = true;
			$(".forWait").html("提交");
			$("#forgot-tip").html("* 连接失败");
		}
	});
}
</script>
</body>
</html>
