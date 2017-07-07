<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>新建任务</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
	<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap-duallistbox.css" />
<script src="${ctxPath }/static/source/js/jedate/jedate.js"></script>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>新建任务</h1>
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
								<label class="taskRaidolable">
									<input value="${p.id}" name="modelType" type="radio" class="ace">
									<span class="lbl"><span class="taskraidoWord">${p.mc}</span></span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >模型名称：</label>
					<div class="col-sm-9 col-xs-8">
						<input type="text" value="" id="modelName" class="col-xs-12 col-sm-4" onblur="checkInputNull(this)">
						<span class="help-inline col-xs-12 col-sm-6">
							<span class="middle existenceCon" style="line-height:30px">（必填）</span>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >模型备注：</label>
					<div class="col-sm-9 col-xs-8">
						<textarea rows="4" class="col-xs-12 col-sm-6 col-md-5" id="modeldec"></textarea>
					</div>
				</div>
				<hr style="border-color:#ccc">
				<h4 class="taskTitle">数据信息</h4>
				<div class="form-group existenceDataSource">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据源设置：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl" id="exDataSource"></div>
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
<!-- 弹出层 -->
<div class="iso_alert">
	<div class="iso_alertKuang col-xs-12 col-sm-6">
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
	</div>
</div>
<script src="${ctxPath}/static/source/js/timeReversal.js"></script>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
<script src="${ctxPath}/static/ace/js/jquery.bootstrap-duallistbox.js"></script>
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
//选择数据库
$("input[name=getData]").click(function(){
	$("."+$(this).attr("data-showDiv")).show();
	$("."+$(this).attr("data-hiddenDiv")).hide();
});
//ajax异步提交
$(".creatTaskBtn").click(function(){
	var taskName = $("#taskName").val();//任务名称
	var taskdec = $("#taskdec").val();//任务描述
	var model = $("input[name=modelType]:checked").val();//选择的模型
	var modelName = $("#modelName").val();//模型名称
	var modelDec = $("#modeldec").val();//模型描述
	var dataSource = $("input[name=dataSource]:checked").val();//当选择数据源为已有时，数据源
	var submitData = null;
	var CtaskName = checkInputNull(document.getElementById("taskName"));
	var CmodelName = checkInputNull(document.getElementById("modelName"));
	if(CtaskName&&CmodelName){
		submitData = {
				taskName:taskName,
				taskdec:taskdec,
				modelTypeId:model,
				modelName:modelName,
				modelDesc:modelDec,
				dataSourceId:dataSource
		}
	}else{
		Showbo.Msg.alert("您有未完善的信息，请返回查看");
		return;
	}
	$.ajax({
		url:"${ctxPath}/v1/html/modelBuild/newMission/save.do",
		dataType:"json",
		type:"post",
		data:submitData,
		success:function(data){
			if(data.result=="ok"){
				Showbo.Msg.alert(("创建成功"),function(){
					window.location.href = "${ctxPath}/v1/html/modelBuild/taskManage/list.do";
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
var importInfoArray=[];
$(function(){
	$("input[name=modelType]:first").click();
	initDataSource();
});
//异步获取数据源信息
function initDataSource(){
	$.ajax({
		url:"${ctxPath}/v1/html/modelBuild/newMission/getDataSource.do",
		type:"post",
		dataType:"json",
		data:{},
		success:function(data){
			if(data.result=="ok"){
				var tempUlHtml = "";
				$.each(data.values,function(i,p){
					var checked = '';
					if(i==0){
						checked='checked';
					}
					tempUlHtml+='<label><input value="'+p.id+'" name="dataSource" type="radio" '+checked+' class="ace"><span class="lbl"><ul>';
					tempUlHtml+='<li class="center radioTitle">数据源信息</li><li><span class="radioUlLeft">数据源名称：</span><span class="radioUlRight">'+p.mc+'</span></li><li><span class="radioUlLeft">数据源描述：</span><span class="radioUlRight">'+p.ms+'</span></li><li><span class="radioUlLeft">创建人：</span><span class="radioUlRight">'+p.creater+'</span></li><li><span class="radioUlLeft">创建时间：</span><span class="radioUlRight">'+getFormatDateByLong(p.cjsj)+'</span></li><li style="text-align:center" >';
					if(p.sXTJ!=undefined){
						tempUlHtml+='<span class="dataSourceBtn" onclick="filterInfo('+i+')">数据信息</span>';
						var ulHtml="<ul class='alertInfoUl'>"+
						"<li><span class='radioUlLeft'>税种：</span><span class='radioUlRight'>"+p.sXTJ.sz+"</span></li>"+
						"<li><span class='radioUlLeft'>适用行业：</span><span class='radioUlRight'>"+p.sXTJ.hy+"</span></li>"+
						"<li><span class='radioUlLeft'>城市：</span><span class='radioUlRight'>"+p.sXTJ.cs+"</span></li>"+
						"<li><span class='radioUlLeft'>核算方式：</span><span class='radioUlRight'>"+p.sXTJ.hsfs+"</span></li>"+
						"<li><span class='radioUlLeft'>企业规模：</span><span class='radioUlRight'>"+p.sXTJ.qygm+"</span></li>"+
						"<li><span class='radioUlLeft'>登记注册类型：</span><span class='radioUlRight'>"+p.sXTJ.djlx+"</span></li></ul>";
						dataSourceArray.push(ulHtml);
					}else{
						dataSourceArray.push("1");
						
					}
					if(p.xlsjdr!=undefined){
						tempUlHtml+='<span class="dataSourceBtn" onclick="importInfo('+i+')">导入信息</span>';
						var zt = '上传中';
						if(1 == p.xlsjdr.zt){
							zt = '上传失败';
						}else if(2 == p.xlsjdr.zt){
							zt = '上传成功';
						}
						
						var wjlx = 'excel';
						if(0 == p.xlsjdr.wjlx){
							wjlx = 'excel';
						}else if(1 == p.xlsjdr.wjlx){
							wjlx = 'csv';
						}

						var drlx = '格式化导入';
						if(0 == p.xlsjdr.drlx){
							drlx = '格式化导入';
						}else if(1 == p.xlsjdr.drlx){
							drlx = '自定义导入';
						}
						
						var ulHtml="<ul class='alertInfoUl'>"+
						"<li><span class='radioUlLeft'>文件名：</span><span class='radioUlRight'>"+p.xlsjdr.wjm+"</span></li>"+
						"<li><span class='radioUlLeft'>创建人：</span><span class='radioUlRight'>"+p.creater+"</span></li>"+
						"<li><span class='radioUlLeft'>创建时间：</span><span class='radioUlRight'>"+getFormatDateByLong(p.xlsjdr.cjsj)+"</span></li>"+
						"<li><span class='radioUlLeft'>状态：</span><span class='radioUlRight'>"+zt+"</span></li>"+
						"<li><span class='radioUlLeft'>文件类型：</span><span class='radioUlRight'>"+wjlx+"</span></li>"+
						"<li><span class='radioUlLeft'>导入类型：</span><span class='radioUlRight'>"+drlx+"</span></li></ul>";
						importInfoArray.push(ulHtml);
					}else{
						importInfoArray.push("1");
						
					}
					var dbType = ['mysql','oracle'];
					var databsaseUlHtml="";
					if(p.xlsjcjList!=undefined){
						tempUlHtml+='<span class="dataSourceBtn" onclick="databaseInfo('+i+')">数据库信息</span>';
						$.each(p.xlsjcjList,function(m,n){
							databsaseUlHtml+='<ul class="alertInfoUl"><li><span class="radioUlLeft">数据库类型：</span><span class="radioUlRight">'+dbType[n.sjklx]+'</span></li><li><span class="radioUlLeft">数据库名称：</span><span class="radioUlRight">'+n.sjkmc+'</span></li><li><span class="radioUlLeft">数据库地址：</span><span class="radioUlRight">'+n.sjkdz+'</span></li><li><span class="radioUlLeft">端口号：</span><span class="radioUlRight">'+n.dkh+'</span></li><li><span class="radioUlLeft">用户名：</span><span class="radioUlRight">'+n.yhm+'</span></li><li><span class="radioUlLeft">密码：</span><span class="radioUlRight">'+n.mm+'</span></li></ul>';
						});
						dataBaseArray.push(databsaseUlHtml);
					}else{
						dataBaseArray.push("1");
						
					}
					tempUlHtml+='</li></ul></span></label>';
				});
				$("#exDataSource").html(tempUlHtml);
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			Showbo.Msg.alert("服务器异常");
		}
	});
}
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
//数据信息按钮弹窗显示
function filterInfo(index){
	$(".taskDetail .iso_alertTitle").html("数据信息");
	$(".taskDetail").show();
	$(".iso_alert").show();
	 $(".taskDetail .iso_alertBody form").html(dataSourceArray[index]);
	 resizeIsoAlert();
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
	 $(".taskDetail .iso_alertBody form").html(dataBaseArray[index]);
	 resizeIsoAlert();
}
//导入信息
function importInfo(index){
	$(".taskDetail .iso_alertTitle").html("导入信息");
	$(".taskDetail").show();
	$(".iso_alert").show();
	$(".iso_alertKuang").addClass("alertMinWid");
	 $(".taskDetail .iso_alertBody form").html(importInfoArray[index]);
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
</script>
</body>

</html>