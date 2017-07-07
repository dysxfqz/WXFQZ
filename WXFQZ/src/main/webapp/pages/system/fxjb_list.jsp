<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>自定义风险级别</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>自定义风险级别</h1>
		</div>
		<div class="col-xs-12">
			<div class="alert alert-info">
				<div class="row">
					<form class="form-horizontal">
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >定义方式：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl">
							<label>
<%-- 							<c:forEach items="${fxjbList}" var="p" begin="0" end="0" varStatus='status'> --%>
								<input value="0" name="dataType" type="radio" <%-- <c:if test="${p.szlx==0}"> --%>checked<%-- </c:if> --%> class="ace">
								<span class="lbl">数值</span>
<%-- 							</c:forEach> --%>
							</label>
							<label>
<%-- 								<c:forEach items="${fxjbList}" var="p" begin="0" end="0" varStatus='status'> --%>
									<input value="1" name="dataType" type="radio" <%-- <c:if test="${p.szlx==1}">checked</c:if>  --%>class="ace">
									<span class="lbl">百分比</span>
<%-- 								</c:forEach> --%>
							</label>
						</div>
					</div>
				</div>
				<div id="riskSetArea">
<%-- 				<c:forEach items="${fxjbList}" var="p" begin="0" end="0" varStatus='status'> --%>
					<div id="firstSetRisk">
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别名称：</label>
							<div class="col-sm-9 col-xs-8">
								<input type="text" value="" class="riskName col-xs-12 col-sm-8" onblur="checkInputNull(this)">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别区间：</label>
							<div class="col-sm-9 col-xs-8">
								<input type="number" value="0" class="riskMinCount col-xs-12 col-sm-4" disabled><span class="riskUnit"></span><span class="qujianline">-</span>
								<input type="number" value=""  class="riskMaxCount lastRiskLevel col-xs-12 col-sm-4" onblur=""><span class="riskUnit"></span>
							</div>
						</div>
						<hr>
					</div>
<%-- 				</c:forEach> --%>
					<div id="newAddRisk">
<%-- 					<c:forEach items="${fxjbList}" var="p" begin="1" varStatus='status'> --%>
<!-- 						<div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别名称：</label> -->
<!-- 							<div class="col-sm-9 col-xs-8"> -->
<%-- 								<input type="text" value="${p.jb}" class="riskName col-xs-12 col-sm-8" onblur="checkInputNull(this)"> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别区间：</label> -->
<!-- 							<div class="col-sm-9 col-xs-8"> -->
<%-- 								<input type="number" value="${p.zxz }" class="riskMinCount col-xs-12 col-sm-4" disabled><span class="riskUnit"><c:if test="${p.szlx==1}">%</c:if></span><span class="qujianline">-</span> --%>
<%-- 								<input type="number" value="${zdz.zdz}" class="riskMaxCount <c:if test="${status.index==fxjbList.size()-1}">lastRiskLevel</c:if> col-xs-12 col-sm-4" <c:if test="${status.index!=fxjbList.size()-1}">disabled</c:if> onblur=""><span class="riskUnit"><c:if test="${p.szlx==1}">%</c:if></span> --%>
<%-- 								<i class="fa fa-minus-square removeRisk" onclick="removeRisk(this)" <c:if test="${status.index!=fxjbList.size()-1}"> style="display:none" </c:if> aria-hidden="true"></i> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<hr> -->
<!-- 					</div> -->
<%-- 					</c:forEach> --%>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" > </label>
					<div class="col-sm-9 col-xs-8">
							<label class="setRiskBtn addRisk">增加级别</label>
							<label class="setRiskBtn" onclick="saveRisk()">保存</label>
					</div>
				</div>
			</form>
				</div>
			</div>
		</div>
	</div>
	<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
	<script type="text/javascript">
	$(".addRisk").click(function(){
		if($(".riskName").length==7){
			Showbo.Msg.alert("最多设置7个等级");
			return;
		}
		var tempUnit = "";
		if($(".lastRiskLevel").val()==""){
			Showbo.Msg.alert("请填写区间最大值");
			return;
		}
		var prevRiskMaxCount = parseFloat($(".lastRiskLevel").val());
		var prevRiskMinCount =  parseFloat($(".lastRiskLevel").prev().prev().prev().val());
		var checkName =true; 
		if($("input[name=dataType]:checked").val()==1){
			tempUnit = "%";
			if(prevRiskMaxCount>100){
				Showbo.Msg.alert("按百分比分配最大值不能大于100");
				return;
			}else if(prevRiskMaxCount==100){
				Showbo.Msg.alert("区间最大值已经为100%，无法继续增加");
				return;
			}
		}
		$(".riskName").each(function(i,p){
			if(checkName){
				checkName = checkInputNull(p);
			}else{
				checkInputNull(p);
			}
		});
		if(!checkName){
			Showbo.Msg.alert("请填写风险等级名称");
			return;
		}
		if(prevRiskMinCount>=prevRiskMaxCount){
			Showbo.Msg.alert("区间最大值必须大于最小值");
			return;
		}
		$(".lastRiskLevel").attr("disabled","true");
		$(".lastRiskLevel").prop("disabled","true");
		$(".riskMaxCount").removeClass("lastRiskLevel");
		$(".removeRisk").remove();
		var tempHtml = '<div><div class="form-group"><label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别名称：</label>'+
		'<div class="col-sm-9 col-xs-8"><input type="text" value="" class="riskName col-xs-12 col-sm-8" onblur="checkInputNull(this)"></div></div>'+
		'<div class="form-group"><label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >风险级别区间：</label><div class="col-sm-9 col-xs-8">'+
		'<input type="number" value="'+prevRiskMaxCount+'" class="riskMinCount col-xs-12 col-sm-4" disabled><span class="riskUnit">'+tempUnit+'</span><span class="qujianline">-</span>'+
		'<input type="number" value="" class="riskMaxCount lastRiskLevel col-xs-12 col-sm-4" onblur=""><span class="riskUnit">'+tempUnit+'</span><i class="fa fa-minus-square removeRisk" onclick="removeRisk(this)" aria-hidden="true"></i></div></div><hr></div>';
		$("#newAddRisk").append(tempHtml);
	});
	//移除区间
	function removeRisk(el){
		$(el).parent().parent().parent().remove();
		if($("#newAddRisk").children().length==0){
			$("#firstSetRisk .riskMaxCount").addClass("lastRiskLevel");
			$("#firstSetRisk .riskMaxCount").attr("disabled",false);
			$("#firstSetRisk .riskMaxCount").prop("disabled",false);
		}else{
			var arrayRisk = $(".riskMaxCount");
			$(arrayRisk[arrayRisk.length-1]).addClass("lastRiskLevel");
			$(arrayRisk[arrayRisk.length-1]).attr("disabled",false);
			$(arrayRisk[arrayRisk.length-1]).prop("disabled",false);
			$(arrayRisk[arrayRisk.length-1]).parent().append('<i class="fa fa-minus-square removeRisk" onclick="removeRisk(this)" aria-hidden="true"></i>');
		}
	}
	function saveRisk(){
		var rwh = zs_getUrlParameter("TASKID");
		var dataType = $("input[name=dataType]:checked").val();
		var riskNameArray = $(".riskName");
		var riskMinCountArray = $(".riskMinCount");
		var riskMaxCountArray = $(".riskMaxCount");
		if($(".lastRiskLevel").val()==""){
			Showbo.Msg.alert("请填写区间最大值");
			return;
		}
		var prevRiskMaxCount = parseFloat($(".lastRiskLevel").val());
		var prevRiskMinCount =  parseFloat($(".lastRiskLevel").prev().prev().prev().val());
		var riskContent="";
		var checkName = true;
		$(".riskName").each(function(i,p){
			if(checkName){
				checkName = checkInputNull(p);
			}else{
				checkInputNull(p);
			}
		});
		if(!checkName){
			Showbo.Msg.alert("请填写风险等级名称");
			return;
		}
		if($("input[name=dataType]:checked").val()==1){
			if($(".lastRiskLevel").val()!=100){
				Showbo.Msg.alert("按百分比分配最大值必须为100");
				return;
			}
		}
		if(prevRiskMinCount>=prevRiskMaxCount){
			Showbo.Msg.alert("区间最大值必须大于最小值");
			return;
		}
		$.each(riskNameArray,function(i,p){
			riskContent+=$(p).val()+"_"+$(riskMinCountArray[i]).val()+"_"+$(riskMaxCountArray[i]).val()+",";
		});
		riskContent = riskContent.substring(0,riskContent.length-1);
		$.ajax({
			url:"${ctxPath}/v1/html/manage/systemManage/update/fxjb.do",
			dataType:"json",
			type:"post",
			data:{
				szlx:dataType,
				param:riskContent
			},
			success:function(data){
				if(data.result=="ok"){
					Showbo.Msg.alert("保存成功",function(){
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
	}
	$(".close_alertIso").click(function(){
		$(".iso_alert").hide();
		$("#newAddRisk").html("");
		$(".riskName").val("");
		$(".riskMaxCount").val("");
	});

	//判断选中的是数值还是百分比
	$("input[name=dataType]").click(function(){
		if(this.value==0){
			$(".riskUnit").html("");
		}else{
			$(".riskUnit").html("%");
		}
		$("#newAddRisk").html("");
		$(".qujianline").next().addClass("lastRiskLevel");
		$(".qujianline").next().attr("disabled",false);
		$(".qujianline").next().prop("disabled",false);
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