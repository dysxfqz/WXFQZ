<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>新建任务</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<script src="${ctxPath }/static/source/js/jedate/jedate.js"></script>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>新建任务</h1>
			<a href="${ctxPath}/v1/html/task/predict/list.do" class="detailGoBack">返回</a>
		</div>
		<div class="detailCondition">
			<form class="form-horizontal" autocomplete="off" role="form" >
				<h4 class="taskTitle">任务属性</h4>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >任务名称：</label>
					<div class="col-sm-9 col-xs-8">
						<input type="text" value="" id="taskName" class="col-xs-12 col-sm-4" onblur="checkInputNull(this)">
						<span class="help-inline col-xs-12 col-sm-6">
							<span class="middle existenceCon" style="line-height:30px">（必填）</span>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >任务备注：</label>
					<div class="col-sm-9 col-xs-8">
						<textarea rows="4" class="col-xs-12 col-sm-6 col-md-5" id="taskdec"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >模型分类：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl">
							<c:forEach items="${mxflList}" var="p" varStatus="status">
								<label>
									<input value="${p.id}" name="modelType" type="radio" class="ace">
									<span class="lbl">${p.mc}</span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >模型选择：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl" id="modelList">
						<c:forEach items="${mxList}" var="p" varStatus="status">
							<label>
								<input value="${p.mxh}" name="model" type="radio" class="ace">
								<span class="lbl">
									<ul>
										<li class="center radioTitle" >${p.mc}</li>
										<li><span class="radioUlLeft">税种：</span><span class="radioUlRight">${p.szmc}</span></li>
										<li><span class="radioUlLeft">适用行业：</span><span class="radioUlRight"><c:if test="${p.hy==''}">全部</c:if><c:if test="${p.hy!=''}">${p.hy}</c:if></span></li>
										<li><span class="radioUlLeft">城市：</span><span class="radioUlRight">${p.csmc}</span></li>
										<li><span class="radioUlLeft">核算方式：</span><span class="radioUlRight">${p.hsfsmc}</span></li>
										<li><span class="radioUlLeft">企业规模：</span><span class="radioUlRight">${p.qygm}</span></li>
										<li><span class="radioUlLeft">登记注册类型：</span><span class="radioUlRight"><c:if test="${p.djzclx==''}">全部</c:if><c:if test="${p.djzclx!=''}">${p.djzclx}</c:if></span></li>
										<li><span class="radioUlLeft">创建人：</span><span class="radioUlRight">${p.creater}</span></li>
										<li><span class="radioUlLeft">创建时间：</span><span class="radioUlRight"><fmt:formatDate value="${p.cjsj }" pattern="yyyy-MM-dd HH:mm:ss"/></span></li>
									</ul>
								</span>
							</label>
						</c:forEach>
						</div>
					</div>
				</div>
				<hr style="border-color:#ccc">
				<h4 class="taskTitle">数据信息</h4>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据源设置：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio">
							<label>
								<input value="0" name="choiceDataSource" data-showDiv="existenceDataSource" data-hiddenDiv="addDataSourceDiv" type="radio" checked class="ace">
								<span class="lbl">已有</span>
							</label>
							<label>
								<input value="1" name="choiceDataSource" data-showDiv="addDataSourceDiv" data-hiddenDiv="existenceDataSource"  type="radio" class="ace">
								<span class="lbl">新增</span>
							</label>
						</div>
					</div>
				</div>
				<div class="form-group existenceDataSource">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" > </label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl" id="exDataSource"></div>
					</div>
				</div>
				<div class="addDataSourceDiv">
					<div class="form-group">
						<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon">数据源名称：</label>
						<div class="col-sm-9 col-xs-8">
							<input type="text" value="" id="dataSourceName" class="col-xs-12 col-sm-4" onblur="checkInputNull(this)">
							<span class="help-inline col-xs-12 col-sm-6">
							<span class="middle existenceCon" style="line-height:30px">（必填）</span>
						</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据源备注：</label>
						<div class="col-sm-9 col-xs-8">
							<textarea class="col-xs-12  col-sm-6 col-md-5" id="dataSourceDec"  rows="5" ></textarea>
							<span class="help-inline col-xs-12 col-sm-6">
								<span class="middle existenceCon" style="line-height:30px"></span>
							</span>
						</div>
					</div>
					<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据时间段：</label>
					<div class="col-sm-9 col-xs-8">
					<input class="col-xs-12 col-sm-2" id="startTime"  value ="" type="text" /> <span style="float:left;line-height: 30px;margin-left: 10px;margin-right: 10px;">至</span> <input class="col-xs-12 col-sm-2" id="endTime"  value ="" type="text" />		
					</div>
				</div>
				<hr>
				<div class="newAddDatabase"><span class="dataSourceBtn" onclick="showAddDatabase()">新增</span></div>
					<div class="form-group existenceGetData">
						<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" > </label>
						<div class="col-sm-9 col-xs-8">
							<div class="checkbox radioUl" id="databaseList">
								<c:forEach items="${sjcjList }" var="p" varStatus="status">
								<label>
									<input value="${p.id}" name="database" type="checkbox" <c:if test="${status.index==0}">checked</c:if> class="ace">
									<span class="lbl">
										<ul>
											<li class="center radioTitle">数据库信息</li>
											<li><span class="radioUlLeft">数据库类型：</span><span class="radioUlRight"><c:if test="${p.sjklx==0 }">mysql</c:if><c:if test="${p.sjklx==1 }">oracle</c:if></span></li>
											<li><span class="radioUlLeft">数据库地址：</span><span class="radioUlRight">${p.sjkdz}</span></li>
											<li><span class="radioUlLeft">数据库名称：</span><span class="radioUlRight">${p.sjkmc}</span></li>
											<li><span class="radioUlLeft">端口号：</span><span class="radioUlRight">${p.dkh}</span></li>
											<li><span class="radioUlLeft">用户名：</span><span class="radioUlRight">${p.yhm}</span></li>
											<li><span class="radioUlLeft">密码：</span><span class="radioUlRight">${p.mm}</span></li>
										</ul>
									</span>
								</label>
								</c:forEach>
							</div>
						</div>
					</div>
					</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" > </label>
					<div class="col-sm-9 col-xs-8">
						<span class="creatTaskBtn">创建</span>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="iso_alert">
	<div class="iso_alertKuang col-xs-12 col-sm-6">
<!-- 弹出层 -->
		<div class="taskDetail">
			<div class="iso_alertHeader">
				<h2 class="iso_alertTitle">新建数据库</h2>
				<span id="closeTaskDetail" class="close_alertIso">&times;</span>
				<hr>
			</div>
			<div class="iso_alertBody">
				<form class="form-horizontal">
		
				</form>
			</div>
		</div>
		<div class="addDataBase" style="display:none">
		<div class="iso_alertHeader">
				<h2 class="iso_alertTitle">编辑任务</h2>
				<span id="closeDataBase" class="close_alertIso">&times;</span>
				<hr>
			</div>
			<div class="iso_alertBody">
			<form class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >数据库类型：</label>
				<div class="col-sm-9 col-xs-8">
					<select class="col-xs-12 col-sm-6" id="dataBase">
						<option selected value="0">mysql</option>
						<option value="1">oracle</option>
					</select>
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px"></span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >数据库地址：</label>
				<div class="col-sm-9 col-xs-8">
					<input type="text" value="" class="col-xs-10 col-sm-6" id="dataBaseAddress" onblur="checkInputNull(this)">
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px">（必填）</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >数据库名称：</label>
				<div class="col-sm-9 col-xs-8">
					<input type="text" value="" class="col-xs-10 col-sm-6" id="dataBaseName" onblur="checkInputNull(this)">
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px">（必填）</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >端口号：</label>
				<div class="col-sm-9 col-xs-8">
					<input type="text" value="" class="col-xs-10 col-sm-6" id="dataBasePort" onblur="checkInputNull(this)">
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px">（必填）</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >用户名：</label>
				<div class="col-sm-9 col-xs-8">
					<input type="text" value="" class="col-xs-10 col-sm-6" id="userName" onblur="checkInputNull(this)">
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px">（必填）</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" >密码：</label>
				<div class="col-sm-9 col-xs-8">
					<input type="password" id="dataBasePwd" value="" class="col-xs-10 col-sm-6" onblur="checkInputNull(this)">
					<span class="help-inline col-xs-12 col-sm-6">
						<span class="middle existenceCon" style="line-height:30px">（必填）</span>
					</span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 col-xs-4 control-label no-padding-right existenceCon" > </label>
				<div class="col-sm-9 col-xs-8">
					<span class="dataSourceBtn" style="width:200px;" onclick="goAddDatabase()">增加</span>
				</div>
			</div>
			</form>
			</div>
		</div>
	</div>
</div>
<script src="${ctxPath}/static/source/js/timeReversal.js"></script>
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
$('.iso_alertKuang').drag();
//选择数据源
$("input[name=choiceDataSource]").click(function(){
	$("."+$(this).attr("data-showDiv")).show();
	$("."+$(this).attr("data-hiddenDiv")).hide();
});
//选择数据库
$("input[name=getData]").click(function(){
	$("."+$(this).attr("data-showDiv")).show();
	$("."+$(this).attr("data-hiddenDiv")).hide();
});
//日历控件
jeDate({
	dateCell:"#startTime",
	format:"YYYY-MM",
	isinitVal:true,
	isTime:true, //isClear:false,
	//minDate:"2014-09-19 00:00:00",
	okfun:function(val){}
});
jeDate({
	dateCell:"#endTime",
	format:"YYYY-MM",
	isinitVal:true,
	isTime:true, //isClear:false,
	//minDate:"2014-09-19 00:00:00",
	okfun:function(val){}
});
//ajax异步提交
$(".creatTaskBtn").click(function(){
	var taskName = $("#taskName").val();//任务名称
	var taskdec = $("#taskdec").val();//任务描述
	var startTime = $("#startTime").val();//开始时间
	var endTime = $("#endTime").val();//结束时间
	var model = $("input[name=model]:checked").val();//选择的模型
	var choiceDataSource = $("input[name=choiceDataSource]:checked").val();//数据源的选择
	var dataSource = $("input[name=dataSource]:checked").val();//当选择数据源为已有时，数据源
	var dataSourceName = $("#dataSourceName").val();//当数据源选择为新增时，数据源名称
	var dataSourceDec = $("#dataSourceDec").val();//当数据源选择为新增时，数据源描述
	var databaseIds = $("input[name=database]:checked");//当数据采集选择为已有时，数据采集方式
	var submitData = null;
	
	if(choiceDataSource==0){
		if(dataSource==undefined){
			Showbo.Msg.alert("没有可用的数据源");
			return;
		}
		var CtaskName = checkInputNull(document.getElementById("taskName"));
		if(CtaskName){
			submitData = {
					taskName:taskName,
					taskdec:taskdec,
					modelhao:model,
					choiceDataSource:choiceDataSource,
					dataSourceId:dataSource
			}
		}else{
			Showbo.Msg.alert("您有未完善的信息，请返回查看");
			return;
		}
	}else if(choiceDataSource==1){
		var qishiTime = new Date(startTime).getTime();
		var jieshuTime = new Date(endTime).getTime();
		if(jieshuTime<=qishiTime){
			Showbo.Msg.alert("结束时间必须大于开始时间");
			return;
		}
		var databaseId = "";
		$.each(databaseIds,function(i,p){
			databaseId+=$(p).val()+",";
		});
		databaseId = databaseId.substring(0,databaseId.length-1);
		if(databaseId==""){
			Showbo.Msg.alert("请选择数据库");
			return
		}
		var CtaskName = checkInputNull(document.getElementById("taskName"));
		var CdataSourceName = checkInputNull(document.getElementById("dataSourceName"));
		if(CtaskName&&CdataSourceName){
			submitData = {
					taskName:taskName,
					taskdec:taskdec,
					startTime:startTime,
					endTime:endTime,
					modelhao:model,
					choiceDataSource:choiceDataSource,
					dataSourceName:dataSourceName,
					dataSourceDec:dataSourceDec,
					databaseId:databaseId
			}
		}else{
			Showbo.Msg.alert("您有未完善的信息，请返回查看");
			return;
		}
	}
	$.ajax({
		url:"${ctxPath}/v1/html/task/predict/save.do",
		dataType:"json",
		type:"post",
		data:submitData,
		success:function(data){
			if(data.result=="ok"){
				Showbo.Msg.alert(("创建成功"),function(){
				 window.location.href = "${ctxPath}/v1/html/task/predict/list.do";
 				});
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			Showbo.Msg.alert("服务器异常");
		}
	});
});
var dataSourceArray = [];
var dataBaseArray = [];
$(function(){
	$("input[name=modelType]:first").click();
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
//筛选条件按钮弹窗显示
function filterInfo(index){
	$(".taskDetail .iso_alertTitle").html("筛选条件");
	$(".taskDetail").show();
	$(".iso_alert").show();
	 resizeIsoAlert();
	 $(".taskDetail .iso_alertBody form").html(dataSourceArray[index]);
}
//关闭弹窗
$("#closeTaskDetail").click(function(){
	$(".taskDetail").hide();
	$(".iso_alert").hide();
	$(".addDataBase").hide();
	$(".iso_alertKuang").removeClass("alertMinWid");
});
//数据库信息弹窗显示
function databaseInfo(index){
	$(".taskDetail .iso_alertTitle").html("数据库信息");
	$(".taskDetail").show();
	$(".iso_alert").show();
	$(".iso_alertKuang").addClass("alertMinWid");
	 resizeIsoAlert();
	 $(".taskDetail .iso_alertBody form").html(dataBaseArray[index]);
}
//保持数据源高度一致
function keepDtaSourceH(id){
	var maxHeight = 0;
	$("#"+id+" label").each(function(i,p){
		maxHeight = $(p).height() > maxHeight ? $(p).height():maxHeight;
	});
	$("#exDataSource ul").each(function(i,p){
		$(p).css("height",maxHeight);
	});
}
//显示增加数据库
function showAddDatabase(){
	$(".iso_alert").show();
	$(".taskDetail").hide();
	$(".addDataBase").show();
	resizeIsoAlert();
}
$("#closeDataBase").click(function(){
	$(".taskDetail").hide();
	$(".iso_alert").hide();
	$(".addDataBase").hide();
	$("#dataBaseAddress").val("");
	$("#dataBasePort").val("");
	$("#userName").val("");
	$("#dataBasePwd").val("");
	$("#dataBaseName").val("");
});
//新创建数据库
function goAddDatabase(){
	var dataBaseType = $("#dataBase").val();//当数据采集设置为新增时，数据库类型
	var dataBaseAddress = $("#dataBaseAddress").val();//当数据采集设置为新增时，数据库地址
	var dataBasePort = $("#dataBasePort").val();//当数据采集设置为新增时，数据库端口
	var userName = $("#userName").val();//当数据采集设置为新增时，数据库用户名
	var dataBasePwd = $("#dataBasePwd").val();//当数据采集设置为新增时，数据库的密码
	var dataBaseName = $("#dataBaseName").val();//当数据采集设置为新增时，数据库的名称
	
	var CdataBaseAddress = checkInputNull(document.getElementById("dataBaseAddress"));
	var CdataBasePort = checkInputNull(document.getElementById("dataBasePort"));
	var CuserName = checkInputNull(document.getElementById("userName"));
	var CdataBaseName = checkInputNull(document.getElementById("dataBaseName"));
	var CdataBasePwd = checkInputNull(document.getElementById("dataBasePwd"));
	if(CdataBaseAddress&&CdataBasePort&&CuserName&&CdataBaseName&&CdataBasePwd){
		$.ajax({
			url:"${ctxPath}/v1/html/task/predict/addDataBase.do",
			dataType:"json",
			type:"post",
			data:{
				dataBaseType:dataBaseType,
				dataBaseAddress:dataBaseAddress,
				dataBasePort:dataBasePort,
				userName:userName,
				dataBaseName:dataBaseName,
				dataBasePwd:dataBasePwd
			},
			success:function(data){
				if(data.result=="ok"){
				var dbType = ['mysql','oracle'];
				var tempdatabaseHtml='<label><input value="'+data.values.id+'" name="database" type="checkbox" class="ace"><span class="lbl"><ul><li class="center radioTitle">数据库信息</li>'+
				'<li><span class="radioUlLeft">数据库类型：</span><span class="radioUlRight">'+dbType[data.values.sjklx]+'</span></li>'+
				'<li><span class="radioUlLeft">数据库地址：</span><span class="radioUlRight">'+data.values.sjkdz+'</span></li>'+
				'<li><span class="radioUlLeft">数据库名称：</span><span class="radioUlRight">'+data.values.sjkmc+'</span></li>'+
				'<li><span class="radioUlLeft">端口号：</span><span class="radioUlRight">'+data.values.sjkmc+'</span></li>'+
				'<li><span class="radioUlLeft">用户名：</span><span class="radioUlRight">'+data.values.yhm+'</span></li>'+
				'<li><span class="radioUlLeft">密码：</span><span class="radioUlRight">'+data.values.mm+'</span></li></ul></span></label>';
				$("#databaseList").append(tempdatabaseHtml);
				$("#closeDataBase").click();
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				Showbo.Msg.alert("服务器异常");
			}
		});
	}else{
		Showbo.Msg.alert("您有未完善的信息");
	}
}
//模型分类点击事件
$("input[name=modelType]").click(function(){
	var modelTypeName = this.value;
	$.ajax({
		url:"${ctxPath}/v1/html/task/predict/getMX.do",
		type:"post",
		dataType:"json",
		data:{mxflbh:modelTypeName},
		success:function(data){
			if(data.result=="ok"){
				if(data.values=="empty"){
					$("#modelList").html("暂无模型");
					$("#exDataSource").html("");
				}else{
					var modelListHtml = "";
					$.each(data.values,function(i,p){
						var hangyeName = "";
						if(p.hy==""){
							hangyeName = "全部";
						}else{
							hangyeName = p.hy;
						}
						var qiye = ["一般企业","大企业","全部"];
						var zhuceType="";
						if(p.djzclx==""){
							zhuceType = "全部";
						}else{
							zhuceType = p.djzclx;
						}
						modelListHtml += '<label><input value="'+p.mxh+'" name="model" type="radio" class="ace"><span class="lbl"><ul><li class="center radioTitle" >'+p.mc+'</li>'+
						'<li><span class="radioUlLeft">税种：</span><span class="radioUlRight">'+p.szmc+'</span></li>'+
						'<li><span class="radioUlLeft">适用行业：</span><span class="radioUlRight">'+hangyeName+'</span></li>'+
						'<li><span class="radioUlLeft">城市：</span><span class="radioUlRight">'+p.csmc+'</span></li>'+
						'<li><span class="radioUlLeft">核算方式：</span><span class="radioUlRight">'+p.hsfsmc+'</span></li>'+
						'<li><span class="radioUlLeft">企业规模：</span><span class="radioUlRight">'+p.qygm+'</span></li>'+
						'<li><span class="radioUlLeft">登记注册类型：</span><span class="radioUlRight">'+zhuceType+'</span></li>'+
						'<li><span class="radioUlLeft">创建人：</span><span class="radioUlRight">'+p.creater+'</span></li>'+
						'<li><span class="radioUlLeft">创建时间：</span><span class="radioUlRight">'+getFormatDateByLong(p.cjsj)+'</span></li></ul></span></label>';
					});
					$("#modelList").html(modelListHtml);
					keepDtaSourceH("modelList");
					//注册监听事件
					$("input[name=model]").click(function(){
						dataSourceArray = [];
						dataBaseArray = [];
						var mxh = $(this).val();
						var dataModel = [];
						$.each($(this).next().find("li"),function(i,p){
							dataModel.push($(p).html());
						});
						$.ajax({
							url:"${ctxPath}/v1/html/task/predict/getDataSource.do",
							dataType:"json",
							type:"post",
							data:{mxh:mxh},
							success:function(data){
								var tempUlHtml = "";
								if(data.result=="ok"){
									$.each(data.values,function(i,p){
										var checked = '';
										if(i==0){
											checked='checked';
										}
										tempUlHtml+='<label><input value="'+p.id+'" name="dataSource" type="radio" '+checked+' class="ace"><span class="lbl"><ul>';
										tempUlHtml+='<li class="center radioTitle">数据源信息</li><li><span class="radioUlLeft">数据源名称：</span><span class="radioUlRight">'+p.mc+'</span></li><li><span class="radioUlLeft">数据源描述：</span><span class="radioUlRight">'+p.ms+'</span></li><li><span class="radioUlLeft">创建人：</span><span class="radioUlRight">'+p.creater+'</span></li><li><span class="radioUlLeft">创建时间：</span><span class="radioUlRight">'+getFormatDateByLong(p.cjsj)+'</span></li><li style="text-align:center" ><span class="dataSourceBtn" onclick="filterInfo('+i+')">筛选条件</span><span class="dataSourceBtn" onclick="databaseInfo('+i+')">数据库信息</span></li></ul></span></label>';
										var ulHtml="<ul class='alertInfoUl'>";
										$.each(dataModel,function(m,n){
											if(m>0&&m<dataModel.length-2){
												ulHtml += '<li>'+n+'</li>';
											}
										});
										ulHtml+="</ul>";
										dataSourceArray.push(ulHtml);
										var dbType = ['mysql','oracle'];
										var databsaseUlHtml="";
										$.each(p.sjcjList,function(m,n){
											databsaseUlHtml+='<ul class="alertInfoUl"><li><span class="radioUlLeft">数据库类型：</span><span class="radioUlRight">'+dbType[n.sjklx]+'</span></li><li><span class="radioUlLeft">数据库名称：</span><span class="radioUlRight">'+n.sjkmc+'</span></li><li><span class="radioUlLeft">数据库地址：</span><span class="radioUlRight">'+n.sjkdz+'</span></li><li><span class="radioUlLeft">端口号：</span><span class="radioUlRight">'+n.dkh+'</span></li><li><span class="radioUlLeft">用户名：</span><span class="radioUlRight">'+n.yhm+'</span></li><li><span class="radioUlLeft">密码：</span><span class="radioUlRight">'+n.mm+'</span></li></ul>';
										});
										dataBaseArray.push(databsaseUlHtml);
									});
									$("#exDataSource").html(tempUlHtml);
									keepDtaSourceH("exDataSource");
								}else{
									Showbo.Msg.alert(data.errormsg);
								}
							},
							error:function(){
								Showbo.Msg.alert("服务器异常");
							}
						});
					});
					$("input[name=model]:first").click();
				}
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			Showbo.Msg.alert("服务器异常");
		}
	});
});
</script>
</body>

</html>
