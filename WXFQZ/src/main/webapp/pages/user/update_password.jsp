<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${ctxPath}/static/source/style/updatePwd.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>密码设置</title>
<script type="text/javascript">
 function changeImg(){    
    var imgSrc = $("#imgObj");    
    var src = imgSrc.attr("src");  
    imgSrc.attr("src",chgUrl(src));    
}    
//时间戳    
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳    
function chgUrl(url){    
    var timestamp = (new Date()).valueOf();    
    var urlurl = url.substring(0,17);    
    if((url.indexOf("&")>=0)){    
        urlurl = url + "×tamp=" + timestamp;    
    }else{    
        urlurl = url + "?timestamp=" + timestamp;    
    }    
    return urlurl;    
}    
</script>
<style>
</style>
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>密码设置</h1>
		</div>
		<div class="alert alert-info">
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" autocomplete="off" id="passwordForm" role="form" action="${ctxPath}/v1/html/user/passwordSettings/update/updatePassword.do">
						<!-- 第一行信息 -->
						<c:if test="${user.password != null && user.password != ''}">
							<div class="form-group">
								<label class="col-sm-2 col-xs-4 control-label no-padding-right mobile_formLeft">原密码：</label>
								<div class="col-sm-9 col-xs-8 mobile_formRight">
									<input type="password" placeholder="原密码" name="oldPassword" id="oldPassword" class="col-xs-12 col-sm-5" />
									<span class="help-inline col-xs-12 col-sm-7">
										<span class="middle" style="line-height:30px"></span>
									</span>
								</div>
							</div>
						</c:if>
						<!-- 第二行信息 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right mobile_formLeft">新密码：</label>
							<div class="col-sm-9 col-xs-8 mobile_formRight">
								<input type="password" placeholder="新密码" name="newPassword" id="newPassword" onkeyup="pwStrength(this.value)" class="col-xs-12 col-sm-5" />
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 第三行信息 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right mobile_formLeft">密码强度：</label>
							<div class="col-sm-9  col-xs-8 mobile_formRight" style="padding-left:0;">
								<div class="col-xs-12 col-sm-5 pwdStrength">
									<span class="col-xs-4" id="s1">弱</span>
									<span class="col-xs-4" id="s2">中</span>
									<span class="col-xs-4" id="s3">强</span>
								</div>
							</div>
						</div>
						<!-- 第四行信息 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right mobile_formLeft">再次输入密码：</label>
							<div class="col-sm-9 col-xs-8 mobile_formRight">
								<input type="password" placeholder="再次输入密码" id="reNewPassword" class="col-xs-12 col-sm-5" />
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 第四行信息 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right"></label>
							<div class="col-sm-9 col-xs-12 mobile_queren">
								<span class="btn btn-warning" onclick="updateUserPwd(this)" style="width:200px;">确认</span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script>
	
	function CharMode(iN){ 
		if (iN>=48 && iN <=57) //数字  
		return 1;  
		if (iN>=65 && iN <=90) //大写  
		return 2;  
		if (iN>=97 && iN <=122) //小写  
		return 4;  
		else  
		return 8;   
		}  
		//bitTotal函数  
		//计算密码模式  
		function bitTotal(num){  
		modes=0;  
		for (i=0;i<4;i++){  
		if (num & 1) modes++;  
		num>>>=1;  
		}  
		return modes;  
		}  
		//返回强度级别  
		function checkStrong(sPW){  
		if (sPW.length<=4)  
		return 0; //密码太短  
		Modes=0;  
		for (i=0;i<sPW.length;i++){  
		//密码模式  
		Modes|=CharMode(sPW.charCodeAt(i));  
		}  
		return bitTotal(Modes);  
		}  
		  
		//显示颜色  
		function pwStrength(pwd){  
		O_color="#eeeeee";  
		L_color="#FF0000";  
		M_color="#FF9900";  
		H_color="#33CC00";  
		if (pwd==null||pwd==''){  
		Lcolor=Mcolor=Hcolor=O_color;  
		}  
		else{  
		S_level=checkStrong(pwd);  
		switch(S_level) {  
		case 0:  
		Lcolor=Mcolor=Hcolor=O_color;  
		case 1:  
		Lcolor=L_color;  
		Mcolor=Hcolor=O_color;  
		break;  
		case 2:  
		Lcolor=Mcolor=M_color;  
		Hcolor=O_color;  
		break;  
		default:  
		Lcolor=Mcolor=Hcolor=H_color;  
		}  
		}  
		document.getElementById("s1").style.background=Lcolor;  
		document.getElementById("s2").style.background=Mcolor;  
		document.getElementById("s3").style.background=Hcolor;  
		return;  
		}  
		var pwdLock = true;
		function updateUserPwd(el) {
			if(!pwdLock){
				Showbo.Msg.alert("正在发送数据，请稍后...");
				return;
			}
			var oldPwd = $("#oldPassword").val();
			var newPwd = $("#newPassword").val();
			var reNewPwd = $("#reNewPassword").val();
			if( ""== oldPwd){
				Showbo.Msg.alert("原密码不能为空!");
				return;
			}
			if( newPwd.length>32 || reNewPwd.length>32){
				Showbo.Msg.alert("密码长度过长!");
				return;
			}
			
			if( null == newPwd || "" == newPwd){
				Showbo.Msg.alert("请填写新密码!");
				return;
			}
			if( null == reNewPwd || "" == reNewPwd){
				Showbo.Msg.alert("请再次填写新密码!");
				return;
			}
			if( newPwd != reNewPwd){
				Showbo.Msg.alert("新密码输入不一致，请检查!");
				return;
			}else if(newPwd==oldPwd){
				Showbo.Msg.alert("新密码不能和旧密码相同，请点击确定按钮返回查看!");
				return;
			}
			pwdLock = false;
			$(el).html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
			//锁屏图片显示
			$(".loading_chuan").show();
			var options = {
				success : function(data) {
					//锁屏图片隐藏
					$(".loading_chuan").hide();
					if (data.result == 'ok') {
						Showbo.Msg.alert("保存成功",function(){
						     if($(".btnfocus").val() =="确定"){
						    	 pwdLock = true;
						    	 $(el).html("确认");
						    	 window.location.reload();
			 					       } 
			 					});
					} else {
						Showbo.Msg.alert(data.errormsg,function(){
						     if($(".btnfocus").val() =="确定"){
							    	 pwdLock = true;
							    	 $(el).html("确认");
			 					} 
			 			});
					}
				},
				error:function(){
					Showbo.Msg.alert("网络错误",function(){
					     if($(".btnfocus").val() =="确定"){
						    	 pwdLock = true;
						    	 $(el).html("确认");
		 					} 
		 			});
				}
			};
			$("#passwordForm").ajaxSubmit(options);
	}
	</script>
</body>

</html>