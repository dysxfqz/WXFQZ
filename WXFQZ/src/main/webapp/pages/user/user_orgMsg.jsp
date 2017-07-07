<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>企业认证信息</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/renzheng.css" />
<style>
</style>
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter">
	<h3> <i class="menu-icon fa fa-credit-card"></i> 企业认证信息</h3>
	</div>
	<div class="alert alert-info">
		<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" autocomplete="off">
						<!-- 第一行信息 -->
						<div class="form-group">
							<label class="col-xs-3 control-label no-padding-right">开发者类型</label>
							<div class="col-xs-9 control-label" style="text-align:left">企业开发者</div>
						</div>
					
					<!-- 第二行信息 -->
					<div class="form-group">
						<label class="col-xs-3 control-label no-padding-right">公司名称</label>
						<div class="col-xs-9 control-label" style="text-align:left">${oi.name}</div>
					</div>
					<!-- 第三行信息 -->
					<div class="form-group">
						<label class="col-xs-3 control-label no-padding-right">公司地址</label>
						<div class="col-xs-9 control-label" style="text-align:left">${oi.address}</div>
					</div>
					<!-- 第四行信息 -->
					<div class="form-group">
						<label class="col-xs-3 control-label no-padding-right">所属行业</label>
						<div class="col-xs-9 control-label" style="text-align:left">
									<c:if test="${oi.jobType == '0'}">互联网金融</c:if>
									<c:if test="${oi.jobType == '1'}">游戏</c:if>
									<c:if test="${oi.jobType == '2'}">教育培训</c:if>
									<c:if test="${oi.jobType == '3'}">银行/保险</c:if>
									<c:if test="${oi.jobType == '4'}">电商</c:if>
									<c:if test="${oi.jobType == '5'}">零售/贸易</c:if>
									<c:if test="${oi.jobType == '6'}">交通/物流</c:if>
									<c:if test="${oi.jobType == '7'}">房地产</c:if>
									<c:if test="${oi.jobType == '8'}">政府/企事业单位</c:if>
									<c:if test="${oi.jobType == '9'}">医疗健康</c:if>
									<c:if test="${oi.jobType == '10'}">物联网/智能硬件</c:if>
									<c:if test="${oi.jobType == '11'}">门户/论坛/网站</c:if>
									<c:if test="${oi.jobType == '12'}">生活服务</c:if>
									<c:if test="${oi.jobType == '13'}">文化传媒</c:if>
									<c:if test="${oi.jobType == '14'}">农业/能源/电气</c:if>
									<c:if test="${oi.jobType == '15'}">IT/系统集成/软件外包</c:if>
									<c:if test="${oi.jobType == '16'}">企业软件服务</c:if>
									<c:if test="${oi.jobType == '17'}">其他</c:if>
						</div>
					</div>
					<!-- 认证状态 -->
					<div class="form-group">
						<label class="col-xs-3 control-label no-padding-right">认证状态</label>
						<c:if test="${user.qualificationStatus == 0}">
							<div class="col-xs-9 control-label" style="text-align:left">未认证</div>
						</c:if>
						<c:if test="${user.qualificationStatus == 1}">
							<div class="col-xs-9 control-label" style="text-align:left">认证中</div>
						</c:if>
						<c:if test="${user.qualificationStatus == 2}">
							<div class="col-xs-9 control-label" style="text-align:left">认证通过</div>
						</c:if>
						<c:if test="${user.qualificationStatus == 3}">
							<div class="col-xs-9 control-label" style="text-align:left">认证失败</div>
						</c:if>
					</div>
					<hr>
					<!-- 第五行信息 -->
						<div class="form-group">
							<c:if test="${oi.documentType == 0}">
								<label class="col-xs-3 control-label no-padding-right">统一社会信用代码</label>
							</c:if>
							<c:if test="${oi.documentType == 1}">
								<label class="col-xs-3 control-label no-padding-right">注册号</label>
							</c:if>
							<c:if test="${oi.documentType == 2}">
								<label class="col-xs-3 control-label no-padding-right">营业执照号</label>
							</c:if>
							<div class="col-xs-9 control-label" style="text-align:left">${oi.regNo} </div>
						</div>
					
					<c:if test="${oi.documentType == 1 }">
						<div class="form-group">
							<label class="col-xs-3 control-label no-padding-right">税务登记号</label>
							<div class="col-xs-9 control-label" style="text-align:left">${oi.taxNo}</div>
						</div>
					</c:if>
					<div class="form-group">
						<label class="col-xs-3 control-label no-padding-right">营业执照</label>
							<div class="col-xs-4">
								<div class="showImg1 col-xs-10" id="showImg1">
									<div >
										<c:if test="${oi.regUrl!=''}">
										<a id="preImg1" target="_blank" href="javascript:void(0)">
											<img style="width:100%;max-width:200px;margin-left: -3%;margin-top: 3%;" id="authImg1" src="${filePath}/${oi.regUrl}">
										</a>
										</c:if>
									</div>
								</div>
							</div>
					</div>
					<hr>
					<c:if test="${oi.documentType == 2 }">
						<div class="form-group">
							<label class="col-xs-3 control-label no-padding-right">税务登记号</label>
							<div class="col-xs-9 control-label" style="text-align:left">${oi.taxNo}</div>
						</div>
					</c:if>
					<c:if test="${oi.documentType == 2}">
						<div class="form-group">
							<label class="col-xs-3 control-label no-padding-right">税务登记证</label>
								<div class="col-xs-4">
									<div class="showImg1 col-xs-10" id="showImg1">
										<div >
										
										<c:if test="${oi.taxUrl!=''}">
											<a id="preImg1" target="_blank" href="javascript:void(0)">
												<img style="width:100%;max-width:200px;margin-left: -3%;margin-top: 3%;" id="authImg1" src="${filePath}/${oi.taxUrl}">
											</a>
										</c:if>
										</div>
									</div>
								</div>
						</div>
					</c:if>		
					
					<hr>
					
					<div class="form-group">
							<label class="col-xs-3 control-label no-padding-right">认证拒绝原因</label>
							<div class="col-xs-9">
								<textarea placeholder="拒绝时请填写" onblur="checkPassRea(this)" name ="noPassReason" id="noPassReason" class="col-xs-10 col-sm-5"></textarea>
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
								<%-- <span class="btn btn-warning"  onclick="toQua1('${user.id}')"style="width:100px;">通过
								</span> --%>
								<%-- <span class="btn btn-warning"  onclick="toQua2('${user.id}')"style="width:100px;">拒绝
								</span> --%>
								<span class="btn btn-primary"  onclick="backUserMsg()"style="width:100px;">返回
								</span>
							</c:if>
							</div>
						</div>
		</div>
	</div>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script type="text/javascript">
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
							Showbo.Msg.alert("认证通过成功",function(){
								if($(".btnfocus").val()=="确定"){
									window.location.href = "${ctxPath}/v1/html/manage/userManage/query/userList.do";
								}
							});
							
						}else{
							Showbo.Msg.alert("认证通过失败");
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
								if($(".btnfocus").val()=="确定"){
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
