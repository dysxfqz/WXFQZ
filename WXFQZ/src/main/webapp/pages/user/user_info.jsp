<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../static/inc/taglib.jsp"%>
<html>
  <head>
    <title>基础资料</title>
    <link rel="stylesheet" href="${ctxPath}/static/source/style/userInfo.css">
    <script src="${ctxPath}/static/source/js/addressInfo/Address.js"></script>
  </head>
  <body>
  
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>基础资料</h1>
		</div>
		<div class="alert alert-info">
			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" autocomplete="off" id="passwordForm" role="form" 
					action="${ctxPath}/v1/html/user/basicData/update/updateUserInfo.do" >
						<!-- 注册手机号 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >注册手机号</label>
							<div class="col-sm-9 col-xs-8">
								<span class="col-xs-10 col-sm-5 existenceCon" style="padding-left:0">
								<c:if test="${user.phone==null || user.phone==''}">
									<span class="middle  existenceCon" style="line-height:30px"><a href="javascript:changePhone()">添加手机号</a></span>
								</c:if>
								<c:if test="${user.phone!=null && user.phone!=''}">${user.phone}</c:if>
								</span>
								<span class="help-inline col-xs-12 col-sm-7">
								<c:if test="${user.phone!=null && user.phone!=''}">
									<span class="middle  existenceCon" style="line-height:30px"><a href="javascript:changePhone()">更换手机号</a></span>
								</c:if>
								</span>
							</div>
						</div>
						<!-- 绑定邮箱 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon">邮箱</label>
							<div class="col-sm-9 col-xs-8">
								<span class="col-xs-10 col-sm-5 existenceCon" style="padding-left:0">
									<c:if test="${empty user.email}">
										您还未绑定邮箱
									</c:if>
									<c:if test="${not empty user.email}">
										${user.email}
									</c:if>
								</span>
								<!-- userInfo.email user.email -->
								<input type="hidden" value="${user.email}" id="userEmail">
								<input type="hidden" value="${userInfo.email}" id="userInfoEmail">
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle existenceCon" style="line-height:30px">
										<a href="javascript:bangdingEmail()">
											<c:if test="${empty user.email}">
												绑定邮箱
											</c:if>
											<c:if test="${not empty user.email}">
												更换邮箱
											</c:if>
										</a>
										<i class="fa fa-info-circle orange" id="emailTip" style="display:none" data-toggle="tooltip" data-placement="right"  title="变更邮箱[${userInfo.email}],只有新邮箱通过验证才能使用，未验证前请使用旧邮箱登录"></i>
									</span>
								</span>
							</div>
						</div>
						<!-- 头像链接 -->
						<input type="hidden" id="headUrl" name="headUrl" value="${userInfo.headUrl}">
						<!-- 姓名 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right">姓名</label>
							<div class="col-sm-9 col-xs-8">
								<input type="text" flag="true" onblur="checkLength('name', 32, '您输入的姓名长度过长!');" placeholder="姓名"  name="name" id="name" value="${userInfo.name}" class="col-xs-10 col-sm-5" />
								<span class="help-inline col-xs-12 col-sm-7">
									<span class="middle" style="line-height:30px"></span>
								</span>
							</div>
						</div>
						<!-- 性别 -->
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right">性别</label>
							<div class="col-sm-9 col-xs-8" >
							<div class="col-sm-4 col-xs-4">
								<div class="radio">
									<label>
										<input value="0" name="sex" checked type="radio" class="ace" <c:if test="${userInfo.sex == 0}" >checked </c:if> >
										<span class="lbl">男</span>
									</label>
								</div>
							</div>
							<div class="col-sm-4 col-xs-4">
							<div class="radio">
									<label>
										<input value="1" name="sex" type="radio" class="ace" <c:if test="${userInfo.sex == 1}" >checked </c:if> >
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
								<div class="col-sm-9 col-xs-12" id="addressSelect" style="padding-left:0;">
									<select id="province" style="margin-top:5px;min-width:145px">
										<option>选择省份</option>
									</select>
									<select id="city" style="margin-top:5px;min-width:145px">
										<option>选择城市</option>
									</select>
									<select id="area" style="margin-top:5px;min-width:145px">
										<option>选择区/县</option>
									</select>
									<input type="hidden" name="province" id="province1" value="${userInfo.province}"  />
									<input type="hidden" name="city" id="city1" value="${userInfo.city}"  /> 
 									<input type="hidden" name="area" id="area1" value="${userInfo.area}"  /> 
								</div>
								<div class="col-sm-4 col-xs-4">
								</div>
								<div class="col-sm-4 col-xs-4">
								</div>
							</div>
						</div>
						
						<!-- 详细地址 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">详细地址</label>
							<div class="col-sm-9">
								<div class="col-sm-9 col-xs-12" style="padding-left:0">
									<input type="text" placeholder="详细地址" class="col-xs-12 col-sm-5" flag="true"  onblur="checkLength('address', 1024, '您输入长度过长!');"
									name="address" id="address" value="${userInfo.address}"  />
									<span class="help-inline col-xs-12 col-sm-7">
										<span class="middle" style="line-height:30px"></span>
									</span>
								</div>
							</div>
						</div>
						<!-- 邮政编码 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right">邮政编码</label>
							<div class="col-sm-9">
								<div class="col-sm-9 col-xs-12" style="padding-left:0">
									<input type="text" placeholder="邮政编码" class="col-xs-12 col-sm-5" flag="true" onblur="checkLength('postCode', 32, '您输入长度过长!');"
									name="postCode" id="postCode" value="${userInfo.postCode}" />
									<span class="help-inline col-xs-12 col-sm-7">
										<span class="middle" style="line-height:30px"></span>
									</span>
								</div>
							</div>
						</div>
					</form>
				
				<form class="form2 form-horizontal" autocomplete="off" id="form2" role="form" >
					<div class="form-group">
						<label class="col-sm-2 control-label no-padding-right">上传头像</label>
						<div class="col-sm-9" id="uploadArea">
					<input type="hidden" id="path1" name="path1" value="avatar">
					<input type="hidden" id="path2" name="path1" value="">
								<span class="profile-picture" id="localImag" >
									<img id="avatar" class="editable img-responsive" style="width: 100%;" <c:if test="${userInfo.headUrl == null||userInfo.headUrl == ''}">src="${ctxPath}/static/ace/avatars/profile-pic.jpg"</c:if>
									 <c:if test="${userInfo.headUrl != null}">
										src="${systemHeadUrl}/${userInfo.headUrl}"
									</c:if> >
									<input type="file" id="file1" name="file" onchange="javascript:setImagePreview()">
						  			
								</span>
								<div class="uploadBtn">
									<span onclick="ajaxFileUpload()" class="btn btn-info"><i class="ace-icon fa fa-check"></i></span>
			                        <span onclick="consoleUpload()" class="btn" style="float:right"><i class="ace-icon fa fa-times"></i></span>
			                      </div>
						</div>
					</div>
	 			</form>

				</div>
				<!-- 提交信息 -->
						<div class="form-group">
							<label class="col-sm-2 control-label no-padding-right"></label>
							<div class="col-sm-9 querenDiv">
								<span class="btn btn-warning"  onclick="updateUser(this)"style="width:200px;" id="queren">确认 </span>
							</div>
						</div>
			</div>
		</div>
	</div>
	<!-- 更改手机号码 -->   
	<div class="alertInfo">
	<div class="alertInfo-content alert-content col-xs-10 col-md-4">
		<div id="changtel">
			<div class="header smaller lighter blue">
			<h4>更改手机号<span class="pull-right closeWin" onclick="closeWind()">&times;</span></h4>
		</div>
		<div class="alertInfo-body col-xs-10">
					<div class="form-group"> 
						<span class="col-xs-10" id="msgPhone" style="text-align: center;"></span>
					</div>
					<p id="changephone-tip"></p>
				<form class="form-horizontal" autocomplete="off" id="changephone" role="form" >
					<!-- 新的手机号 -->
					<label class="block clearfix">
						<span class="block input-icon input-icon-right ">
							<input onblur="checkPhoneFormat(this);" flag="false" type="text" class="form-control" id="rephone" placeholder="请输入新的手机号" />
						</span>
					</label>
					<label class="block clearfix">
						<span class="block input-icon input-icon-right" style="margin-top:15px;">
						<input id="veryCode" style="width: 60%;" class="form-control" name="veryCode" type="text" placeholder="请输入图形验证码"/>
						<i class="ace-icon" style="right:28px" onclick="changeImg('imgObj')"><img id="imgObj" alt="" src="${ctxPath}/v1/anon/user/create/verifyCode.do" style=""/></i>	
						<span class="ace-icon glyphicon glyphicon-refresh" onclick="changeImg('imgObj')" data-toggle="tooltip" title="刷新验证码"  style="cursor:pointer" ></span>
						</span>
					</label>
					<label class="block clearfix" style="margin-top:15px;">
						<span class="block input-icon input-icon-right">
							<input type="text" class="form-control" id="verCode" placeholder="请输入短信验证码" />
							<span class="ace-icon btn btn-info get-code" id="" onclick="getCode(this)">获取验证码</span>
						</span>
					</label>
				</form>
		</div>
		<div class="alertInfo-footer">
			<span class="btn btn-primary col-xs-10" onclick="boundPhone();" id="sendPhone">确定</span>
		</div>
		</div>
		<!-- 绑定邮箱 -->
		<div id="changEmal">
			<div class="header smaller lighter">
			<h4>更改邮箱<span class="pull-right closeWin" onclick="closeWind()">&times;</span></h4>
		</div>
		<div class="alertInfo-body col-xs-12">
					<div class="form-group"> 
						<span class="col-xs-12" id="msgEmail" style="text-align: center;margin-top: -10px;height: 30px;"></span>
					</div>
				<form class="form-horizontal" autocomplete="off" id="changeEm" role="form" >
					<!-- 新的手机号 -->
					<label class="block clearfix" style="margin-bottom:15px;">
						<span >变更邮箱的过程中，只有新邮箱被重新验证才能启用，为验证之前请使用旧邮箱登录</span>
					</label>
					<label class="block clearfix">
						<span class="block input-icon input-icon-right">
							<input type="email" class="form-control" flag="false" id="reEmail" placeholder="请输入新的邮箱地址" onblur="checkEmailFormat(this);"/>
							<span class="ace-icon btn btn-info get-code" onclick="sendBoundEmail();">获取验证链接</span>
						</span>
					</label>
					<label class="block clearfix" style="margin-top:15px;">
						<span >请前往您的新邮箱获取验证链接，并点击链接进行验证</span>
					</label>
				</form>
		</div>
		<div class="alertInfo-footer">
			<span class="btn btn-primary col-xs-12"  onclick="closeWind();">确定</span>
		</div>
		</div>
		
	</div>
</div>
 <div id="loadingState">
 	<div>
 		<div><img class="load_img" src="${ctxPath}/static/source/img/loading.gif" style="width:50px;"/></div>
 	</div>
 </div>
	<script src="${ctxPath}/static/source/js/picture/ajaxfileupload.js"></script>
	<script>
		//判断是否应该显示更改邮箱后的提示-->zxj
		var jud = $("#userEmail").val()!=$("#userInfoEmail").val()||$("#userEmail").val()==""&&$("#userInfoEmail").val()!="";
		if(jud){
			$("#emailTip").show();
		}
		//提示工具
		 $("[data-toggle='tooltip']").tooltip(); 
	</script>
	<script>
	
	setup();
	function setup(){
		var pId = "";
		var cId = "";
		
		$.each(Tprovince, function(i, p){
			$("#province").append(option);
			if(p[1][0]==$("#province1").val()){
				var option= "<option value='" + p[0] + "' selected>" + p[1][0] + "</option>";
	    		 pId = p[0];
			}else{
				var option= "<option value='" + p[0] + "'>" + p[1][0] + "</option>";
			}
			$("#province").append(option);
		});
	     if($("#city1").val()!=""){
	    	 $("#city option:gt(0)").remove();
	        $.each(Tcity, function(k,p){ 
	        	if(pId==p[2]){
        		  if(p[1][0] ==$("#city1").val()){
        			  var option= "<option value='" + p[0] + "' selected>" + p[1][0] + "</option>";
        			  cId = p[0]
        		  }else{
        			  var option= "<option value='" + p[0] + "'>" + p[1][0] + "</option>";
        		  }
               	 $("#city").append(option);
	        	}
	        });
	    }
		    if($("#area1").val()!=""){
		    	 $("#area option:gt(0)").remove();
		        $.each(Tcity, function(k,p){
		        	 if (cId == p[2]) {
		        		 if(p[1][0] ==$("#area1").val()){
		        			 var  option= "<option value='" + p[0] + "' selected>" + p[1][0] + "</option>";
		        		 }else{
		        		  	var option= "<option value='" + p[0] + "'>" + p[1][0] + "</option>";
		        		 }
		                $("#area").append(option);
		            }
		        });
		    } 
		
	    $("#province").change(function () {
	        var selValue = $(this).val();
	        $("#province1").val($(this).find("option:selected").text());
	        $("#city option:gt(0)").remove();
	        $.each(Tcity, function (k, p) { 
	            if (p[2] == selValue) {
	                var option = "<option value='" + p[0] + "'>" + p[1][0] + "</option>";
	                $("#city").append(option);
	            }
	        });
	         
	    });
	     
	    $("#city").change(function () {
	        var selValue = $(this).val();
	        $("#city1").val($(this).find("option:selected").text());
	        $("#area option:gt(0)").remove(); 
	        $.each(Tcity, function (k, p) {
	            if (p[2] == selValue) {
	                var option = "<option value='" + p[0] + "'>" + p[1][0] + "</option>";
	                $("#area").append(option);
	            }
	        }); 
	    }); 
	    $("#area").change(function(){
	   	 $("#area1").val($(this).find("option:selected").text());
	   });
}
	$("#uploadArea label").addClass("col-xs-10 col-sm-5");
	
	function shipei(){
		var logindiv_width = $(".alert-content").width();
	    var logindiv_height = $(".alert-content").height();
		$(".alert-content").css({
	        "left": (document.body.clientWidth - logindiv_width) / 2,
	        "top": (document.body.clientHeight - logindiv_height) / 3
	    });
	}
	shipei();
	$(window).resize(function () {
		shipei();
	});
	var afterImgurl = $("#avatar").attr("src");
	function setImagePreview(avalue) {
	var docObj=document.getElementById("file1");
	var imgObjPreview=document.getElementById("avatar");
	if(docObj.files &&docObj.files[0]){
		//火狐下，直接设img属性
		imgObjPreview.style.display = 'block';
		imgObjPreview.style.width = '200px';
		imgObjPreview.style.height = '200px'; 
		//imgObjPreview.src = docObj.files[0].getAsDataURL();
	 
		//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
		imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
	}
	else{
		//IE下，使用滤镜
		docObj.select();
		docObj.blur();
		var imgSrc = document.selection.createRange().text;
		var localImagId = document.getElementById("localImag");
		//必须设置初始大小
		localImagId.style.width = "200px";
		localImagId.style.height = "200px";
		//图片异常的捕捉，防止用户修改后缀来伪造图片
	try{
		localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
		localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
	}
	catch(e){
		Showbo.Msg.alert("您上传的图片格式不正确，请重新选择");
		return false;
	}
		imgObjPreview.style.display = 'none';
		document.selection.empty();
	}
		$(".uploadBtn").show();
		return true;
	}
	function consoleUpload(){
		$("#avatar").attr("src",afterImgurl);
		$("#file1").val("");
		$(".uploadBtn").hide();
	}


	//异步上传
	function ajaxFileUpload() {
		 $("#loadingState").show();
		 var path1 = $("#path1").val();
		 var path2 = $("#path2").val();
		 $.ajaxFileUpload ({
	        	 url: '${ctxPath}/v1/html/common/util/uploadImg.do', //用于文件上传的服务器端请求地址
	        	 type:'post',
	             secureuri: false, //是否需要安全协议，一般设置为false
	             fileElementId: 'file1', //文件上传域的ID
	             dataType: 'json', //返回值类型 一般设置为json
	             //async : false,//异步传输设置
	             data:{
	            	 "path1" : path1,
	            	 "path2" : path2,
	             }, 
	             success : function(json) {
	            	 if (json.result == "ok") {
						  var attchUrlUp1 = json.attchUrlUp1;
						  if( "" != attchUrlUp1 && null != attchUrlUp1 ){
							  var path11 = '${ctxPath}\\'+attchUrlUp1;
							  $(".uploadBtn").hide();
							  $("#headImg").attr("src",path11);
							  $("#headUrl").val(attchUrlUp1);
						  }
			          } else {
			        	  Showbo.Msg.alert("图片上传失败");
			          }
	            	 $("#loadingState").hide();
			      },
			      error:function(){
			    	  $("#loadingState").hide();
			    	  Showbo.Msg.alert("图片上传失败");
			      },
	         });
		} 


	//文件上传事件
	function fuzhi1() {
		$(".fil").val($(".btt").val());
		$("#showImg1").hide();
		$("#uploadBtn").show();
		$("#butten13").show();
	};
	var infoLock = true;
	function updateUser(el) {
		if(!infoLock){
			Showbo.Msg.alert("正在提交，请稍后...");
			return;
		}
		var f1 = $("#name").attr("flag");
		var f5 = $("#address").attr("flag");
		var f6 = $("#postCode").attr("flag");
		var name = $("#name").val();
		//var value = [f1,f2,f3,f4,f5,f6];
		var mingcheng = ["姓名","省份","城市","区县","详细地址","邮编"];
		var inputk = [$('#name'),$('#province'),$('#city'),$('#area'),$('#address'),$('#postCode'),];
		infoLock = false;
		$(el).html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
		
		if(f1 == "true" && f5 == "true"&& f6=="true"){
			$("#loadingState").show();
			var options = {
					success : function(data) {
						$("#loadingState").hide();
						if (data.result == 'ok') {
							Showbo.Msg.alert(("保存成功"),function(){
							     if($(".btnfocus").val() =="确定"){
							    	 infoLock = true;
							    	 $(el).html("确认");
							    	 window.location.reload();
			  					     } 
			  					});
						} else {
							 $(el).html("确认");
							 infoLock = true;
							Showbo.Msg.alert("保存失败");
						}
					}
				};
				$("#passwordForm").ajaxSubmit(options);
		} else {
			 $(el).html("确认");
			 infoLock = true;
			 for(var i=0;i<6;i++){
				 if(value[i]=="false"){
					 inputk[i].blur();
					 Showbo.Msg.alert(mingcheng[i]+"长度太长");
					 break;
				 }
			 }
			
		}
	}
	
	//获取手机验证码
	function getCode(el){
		if($("#rephone").attr("flag") == "true"){
			$("#msgPhone").html("<span style='color:red'>* 验证码发送中……</span>");
			var id = "";
			if($(el).html()=="获取验证码"){
				//var phone = $(el).prev().val();
				var phone = $(el).parent().parent().prev().prev().find("input").val();
				var veryCode = $(el).parent().parent().prev().find("input").val();
				var num=/^1[34578]{1}\d{9}$/;
				if(phone==""||phone==null ){
					$("#msgPhone").html("<span style='color:red'>* 手机号不能为空！</span>");
					return;
				}else if(phone.length!=11){
					$("#msgPhone").html("<span style='color:red'>* 手机号码长度不正确！</span>");
					return;
				}else if(!num.test(phone)){
					$("#msgPhone").html("<span style='color:red'>* 请输入正确的手机号！</span>");
					return;
				}
				$(el).html("发送中");
				$.ajax({
					type : "post",
					url : "${ctxPath}/v1/anon/user/query/getIdCode.do",
					data : {
							phone : phone,
							id : id,
							veryCode : veryCode,
					      },
					dataType : "json",
					success : function(data){
						if( data.result == "ok"){
							$("#msgPhone").html("验证码已发送至您的手机上，请注意查收！");
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
							$("#msgPhone").html("<span style='color:red'>* " + data.errormsg +"</span>");
						}
					}
				});
			}
		} else {
			$("#msgPhone").html("<span style='color:red'>* 请输入正确手机号！</span>");
		}
	} 
	
	function changePhone(){
		$(".alertInfo").show();
		$("#changtel").show();
		$("#changEmal").hide();
		shipei();
	}
	function closeWind(){
		location.reload();
		//$("#changtel").css("z-index","-99999");
		//$("#changephone")[0].reset();
	}
	function bangdingEmail(){
		$(".alertInfo").show();
		$("#changtel").hide();
		$("#changEmal").show();
		shipei();
	}
	/* function closeWindEm(){
		$("#changEmal").css("z-index","-99999");
		$("#changeEm")[0].reset();
	} */
	
	//
	function changeImg(id){  
	    var imgSrc = $("#"+id);    
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
	//绑定手机 -->zyz
	function boundPhone () {
		$("#rephone").blur();
		var code = $("#verCode").val();
		var phone = $("#rephone").val();
		var veryCode = $("#veryCode").val();
		var f1 = $("#rephone").attr("flag");
		if(f1 == "true" && code != "" && code != null && code != undefined){
			$("#msgPhone").html("验证码校验中……");
			//锁屏图片显示
			$("#loadingState").show();
			$.ajax({
			      type : "post",
			      url : "${ctxPath}/v1/html/user/update/boundPhone.do",
			      data : {
			    	 phone : phone,
			    	 code : code,
			    	 veryCode : veryCode,
			      },
			      dataType : "json",
			      success : function(data) {
			    	  //$("#sendPhone").attr("onclick", "closeWind()");
		 				//锁屏图片隐藏
		 				 $("#loadingState").hide();
		 			  if (data.result == "ok") {
		 				 setTimeout(function(){ 
		 					$(".alertInfo").hide();
		 					$("#changtel").hide();
		 					$("#changEmal").hide();
		 					Showbo.Msg.alert("新号码绑定成功！",function(){
		 						 if($(".btnfocus").val() =="确定"){
		 							window.location.reload();
		 						}	
		 					});
		 				 },3000);
			          } else {
			        	  changeImg('imgObj');
			        	  setTimeout(function(){ 
			        		  $("#msgPhone").html("<span style='color:red'>* "+data.values+"</span>");
			        	  },3000);
			          }
			      },
			      error : function(){
			    	  setTimeout(function(){ 
			    		  $("#msgPhone").html("<span style='color:red'>* 验证码发送失败，请重新获取验证码。</span>");
			    		  //锁屏图片隐藏
			 			  $("#loadingState").hide();
			    	  },3000);
			      }
			    });
		} else {
			$("#msgPhone").html("<span style='color:red'>* 请输入新手机号与验证码！</span>");
		}
		
		
	} 
	//发送绑定邮件-->zyz
	function sendBoundEmail () {
		if($("#reEmail").attr("flag") == "true"){
			if($("#reEmail").attr("flag") == "true" ){
				$("#msgEmail").html("请稍后……");
				var email = $("#reEmail").val();
				//锁屏图片显示
				$("#loadingState").show();
				$.ajax({
				      type : "post",
				      url : "${ctxPath}/v1/html/user/update/sendBoundEmail.do",
				      data : {
				        email : email,
				      },
				      dataType : "json",
				      success : function(data) {
			 			  if (data.result == "ok") {
			 				 //锁屏图片隐藏
			 				 $("#loadingState").hide();
			 				 setTimeout(function(){ 
			 					$("#msgEmail").html("<span style='color:red'> 邮件发送成功 <span style='color: #F1AF74;font-size: 20px;'>24小时</span>内有效</span>");
			 				 },3000);
				 			$("#loadingState").hide();
				          } else {
				        	  setTimeout(function(){ 
				        		 //锁屏图片隐藏
					 			 $("#loadingState").hide();
				        		  $("#msgEmail").html("<span style='color:red'>* 邮箱已被占用</span>");
				        	  },3000);
				          }
				      },
				      error : function(){
				    	  setTimeout(function(){ 
				    		  //锁屏图片隐藏
				 		      $("#loadingState").hide();
				    		  $("#msgEmail").html("<span style='color:red'>* 邮件发送失败</span>");
				    	  },3000);
				      }
				    });
			}
		} else {
			$("#msgEmail").html("<span style='color:red'>* 请输入有效的邮箱！</span>");
		}
	}
</script>
  </body>
</html>
