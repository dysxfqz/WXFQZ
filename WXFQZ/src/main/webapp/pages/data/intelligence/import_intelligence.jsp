<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>智能导入</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
	<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap-duallistbox.css" />
<script src="${ctxPath }/static/source/js/jedate/jedate.js"></script>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>智能导入</h1>
		</div>
		<div class="detailCondition">
			<form class="form-horizontal" autocomplete="off" role="form" >
				<h4 class="taskTitle">数据信息</h4>
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
			<hr style="border-color:#ccc">
				<h4 class="taskTitle">基本属性</h4>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据时间段：</label>
					<div class="col-sm-9 col-xs-8" style="padding-left:30px">
						<input class="col-xs-12 col-sm-2" id="startTime"  value ="" type="text" /> <span style="float:left;line-height: 30px;margin-left: 10px;margin-right: 10px;">至</span> <input class="col-xs-12 col-sm-2" id="endTime"  value ="" type="text" />		
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-top" for="duallist">省份</label>
					<div class="col-sm-9 col-xs-8">
						<!-- #section:plugins/input.duallist -->
						<select multiple="multiple" size="10" name="provinceList" id="provinceList">
							 <c:forEach items="${sfDisList}" var="p">
							 	<c:if test="${fn:contains(p[1],'内蒙')}">
									<option value="${p[0]}">${p[1]}</option>
							 	</c:if>
							</c:forEach>
						</select>
						<!-- /section:plugins/input.duallist -->
						<div class="hr hr-16 hr-dotted"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-top" for="duallist">主管税务机关</label>
					<div class="col-sm-9 col-xs-8" id="cityListDiv">
						<!-- #section:plugins/input.duallist -->
						<select multiple="multiple" size="10" name="cityList" id="citylist">
						</select>
						<!-- /section:plugins/input.duallist -->
						<div class="hr hr-16 hr-dotted"></div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >行业：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="conditonList" style="width:700px;">
							<span class="conditonTitle"><span class="condtitleWord">选择行业</span><span class="fa fa-angle-down down-arrow"></span></span>
							<div class="allCondent">
								<div class="hangyeHeader">
									<span>选择行业</span>
									<span class="hangBtn">
										<span class="confirmBtn">确定</span>
										<span class="cancleBtn">取消</span>
									</span>
								</div>
								<div class="hangyeDiv">
								
<%-- 										<c:forEach items="${hydmDisList}" var="p"> --%>
<%-- 									<c:if test="${fn:contains(p[1],'房地产业')||fn:contains(p[1],'租赁和商务服务业')}"> --%>
<!-- 									<div class="conditionGroup checkbox"> -->
<!-- 									<span class="conditionLeft"> -->
<!-- 										<label> -->
<%-- 											<input class="ace ace-checkbox-1" value="${p[0]}"  type="checkbox" data-confirmed="cancle" name="${p[0]}all" /><span class="lbl" style="font-weight:bold">${p[1]}</span> --%>
<!-- 										</label> -->
<!-- 									</span> -->
<!-- 									<span class="conditionright"> -->
<%-- 										<c:forEach items="${hyList}" var="m"> --%>
<%-- 											<c:if test="${m.hymldm == p[0]&&(fn:contains(m.hyxlmc,'物业管理')||fn:contains(m.hyxlmc,'汽车租赁'))}"> --%>
<!-- 												<label> -->
<%-- 													<input class="ace ace-checkbox-1" value="${m.hyxldm}" data-hymc="${m.hyxlmc}"  type="checkbox" data-confirmed="cancle"  name="${p[0]}"/><span class="lbl">${m.hyxlmc}</span> --%>
<!-- 												</label> -->
<%-- 											</c:if> --%>
<%-- 										</c:forEach> --%>
<!-- 									</span> -->
<!-- 									</div> -->
<%-- 									</c:if> --%>
<%-- 								</c:forEach> --%>
								<c:forEach items="${hydmDisList}" var="p">
									<div class="conditionGroup checkbox">
									<span class="conditionLeft">
										<label>
											<input class="ace ace-checkbox-1" value="${p[0]}"  type="checkbox" data-confirmed="cancle" name="${p[0]}all" /><span class="lbl" style="font-weight:bold">${p[1]}</span>
										</label>
									</span>
									<span class="conditionright">
										<c:forEach items="${hyList}" var="m">
											<c:if test="${m.hymldm == p[0]}">
												<label>
													<input class="ace ace-checkbox-1" value="${m.hyxldm}" data-hymc="${m.hyxlmc}"  type="checkbox" data-confirmed="cancle"  name="${p[0]}"/><span class="lbl">${m.hyxlmc}</span>
												</label>
											</c:if>
										</c:forEach>
									</span>
									</div>
								</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >登记类型：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="checkbox radioUl multiCheck">
							<div>
								<label class="taskRaidolable">
									<input value="0" name="rejistTypeall" type="checkbox" class="ace">
									<span class="lbl"><span class="taskraidoWord" style="font-weight:bold">全部</span></span>
								</label>
							</div>
							<c:forEach items="${djzclxList}" var="p">
								<label class="taskRaidolable">
									<input value="${p.djzclxdmxl}" data-djlxmc="${p.djzclxmcxl}" name="rejistType" type="checkbox" class="ace">
									<span class="lbl"><span class="taskraidoWord">${p.djzclxmcxl}</span></span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >核算方式：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="checkbox radioUl multiCheck">
							<div>
								<label class="taskRaidolable">
									<input value="0" name="hesuanMethodall" type="checkbox" class="ace">
									<span class="lbl"><span class="taskraidoWord" style="font-weight:bold">全部</span></span>
								</label>
							</div>
							<c:forEach items="${hsfsList}" var="p">
								<label class="taskRaidolable">
									<input value="${p.hsfsdm}" data-hsmc="${p.hsfsmc}" name="hesuanMethod" type="checkbox" class="ace">
									<span class="lbl"><span class="taskraidoWord">${p.hsfsmc}</span></span>
								</label>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >税种：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl">
						<c:forEach items="${ssList}" var="p" varStatus = "status">
							<c:if test="${p.zsxmmc=='企业所得税'}">
								<label class="taskRaidolable">
									<input value="${p.zsxmdm}" data-szmc="${p.zsxmmc}" name="taskType" type="radio" checked class="ace">
									<span class="lbl"><span class="taskraidoWord">${p.zsxmmc}</span></span>
								</label>
							</c:if>
						</c:forEach>
							<c:forEach items="${ssList}" var="p" varStatus = "status">
								<c:if test="${p.zsxmmc!='企业所得税'}">
									<label class="taskRaidolable">
										<input value="${p.zsxmdm}" data-szmc="${p.zsxmmc}" name="taskType" type="radio" disabled class="ace">
										<span class="lbl"><span class="taskraidoWord">${p.zsxmmc}</span></span>
									</label>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >企业规模：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl">
							<label>
								<input value="0" name="qiyeType" type="radio" checked class="ace">
								<span class="lbl">一般企业</span>
							</label>
							<label>
								<input value="1" name="qiyeType" type="radio" class="ace">
								<span class="lbl">大企业</span>
							</label>
						</div>
					</div>
				</div>
			<div class="newAddDatabase"><span class="dataSourceBtn" onclick="showAddDatabase()">新增</span></div>
				<div class="form-group existenceGetData">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >数据库设置</label>
					<div class="col-sm-9 col-xs-8">
						<div class="checkbox radioUl" id="databaseList">
							<c:forEach items="${xlsjcjList }" var="p" varStatus="status">
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
<div class="hangyeBottomCeng"></div>
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
				<h2 class="iso_alertTitle">新建数据库</h2>
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
<script src="${ctxPath}/static/ace/js/jquery.bootstrap-duallistbox.js"></script>
<script>
var dataSourceArray = [];
var dataBaseArray = [];
var cityStr = "";
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
var createLock = true;
$(".creatTaskBtn").click(function(){
	if(createLock==false){
		Showbo.Msg.alert("正在提交，请稍后");
		return;
	}
	var startTime = $("#startTime").val();//开始时间
	var endTime = $("#endTime").val();//结束时间
	var dataSourceName = $("#dataSourceName").val();//当数据源选择为新增时，数据源名称
	var dataSourceDec = $("#dataSourceDec").val();//当数据源选择为新增时，数据源描述
	var databaseIds = $("input[name=database]:checked");//当数据采集选择为已有时，数据采集方式
	var submitData = null;
	var qishiTime = new Date(startTime).getTime();
	var jieshuTime = new Date(endTime).getTime();
	var choiceHy = "";//所选择的行业
	var taskType = "";//所选择的税种
	var databaseId = "";//所选择的数据库
	var hesuanMethod = "";//所选择的核算方式
	var rejistType = "";//所选择的登记类型
	var qygmList = "";
	$.each($(".conditionGroup .conditionright"),function(i,p){
		$.each($(p).find("input[type=checkbox]:checked"),function(m,n){
			choiceHy+=$(n).val()+"_"+$(n).attr("data-hymc")+",";
		});
	});
	if(choiceHy==""){
		Showbo.Msg.alert("请选择行业");
		return;
	}
	choiceHy = choiceHy.substring(0,choiceHy.length-1);
	taskType = $("input[name=taskType]:checked").val()+"_"+$("input[name=taskType]:checked").attr("data-szmc");
	if(jieshuTime<=qishiTime){
		Showbo.Msg.alert("结束时间必须大于开始时间");
		return;
	}
	if(cityStr==""){
		Showbo.Msg.alert("请选择城市");
		return;
	}
	$.each(databaseIds,function(i,p){
		databaseId+=$(p).val()+",";
	});
	if(databaseId==""){
		Showbo.Msg.alert("请选择数据库");
		return
	}
	databaseId = databaseId.substring(0,databaseId.length-1);
	if($("input[name=hesuanMethodall]").is("checked")){
		hesuanMethod="";
	}else{
		$("input[name=hesuanMethod]:checked").each(function(i,p){
			hesuanMethod+=	$(p).val()+"_"+$(p).attr("data-hsmc")+",";
		});
		if(hesuanMethod==""){
			Showbo.Msg.alert("请选择核算方式");
			return
		}
		hesuanMethod = hesuanMethod.substring(0,hesuanMethod.length-1);
	}
	if($("input[name=rejistTypeall]").is("checked")){
		rejistType = "";
	}else{
		$("input[name=rejistType]:checked").each(function(i,p){
			rejistType+=$(p).val()+"_"+$(p).attr("data-djlxmc")+",";
		});
		if(rejistType==""){
			Showbo.Msg.alert("请选择登记类型");
			return
		}
		rejistType = rejistType.substring(0,rejistType.length-1);
	}
	qygmList = $("input[name=qiyeType]:checked").val()+"_"+$("input[name=qiyeType]:checked").next().html();
	
	var CdataSourceName = checkInputNull(document.getElementById("dataSourceName"));
	if(CdataSourceName){
		submitData = {
				startTime:startTime,
				endTime:endTime,
				dataSourceName:dataSourceName,
				dataSourceDec:dataSourceDec,
				databaseId:databaseId,
				hyList:choiceHy,
				djlxList:rejistType,
				hsfsList:hesuanMethod,
				szList:taskType,
				csList:cityStr,
				qygmList:qygmList
		}
	}else{
		Showbo.Msg.alert("您有未完善的信息，请返回查看");
		return;
	}
	createLock = false;
	$(".creatTaskBtn").html("<span class='fa fa-spinner fa-spin bigger-150'></span>");
	$.ajax({
		url:"${ctxPath}/v1/html/data/dataCollect/cleverImport/save.do",
		dataType:"json",
		type:"post",
		data:submitData,
		success:function(data){
			if(data.result=="ok"){
				Showbo.Msg.alert(("创建成功"),function(){
				 window.location.reload();
 				});
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
			createLock = true;
			$(".creatTaskBtn").html("创建");
		},
		error:function(){
			Showbo.Msg.alert("服务器异常");
			createLock = true;
			$(".creatTaskBtn").html("创建");
		}
	});
});
$(function(){
	//初始化城市信息
	initCityDom();
	function initCityDom(){
		var demo1 = $('select[name="cityList"]').bootstrapDualListbox({
			infoTextFiltered: '<span class="label label-purple label-lg">Filtered</span>',
			filterPlaceHolder:"筛选",
			moveAllLabel:"选择全部",
			removeAllLabel:"移除所有",
			success:function(item){
				var tempCitps = ""
				cityStr = "";
				item.element.find('option:selected').each(function(i, p) {
					tempCitps = $(p).attr("data-provincedm")+"_"+$(p).attr("data-provincemc")+"_"+$(p).val()+"_"+$(p).html();
					cityStr += tempCitps+",";		 
				 });
				cityStr = cityStr.substring(0,cityStr.length)
			}
		});
		var container1 = demo1.bootstrapDualListbox('getContainer');
		container1.find('.btn').addClass('btn-white btn-info btn-bold');
	}
	//异步获取城市
	function sysGetCity(provinceDm){
		$.ajax({
			url:"${ctxPath}/v1/html/data/dataCollect/cleverImport/getCity.do",
			type:"post",
			dataType:"json",
			data:{provinceDm:provinceDm},
			success:function(data){
				if(data.result=="ok"){
					var citySelect = '<select multiple="multiple" size="10" name="cityList" id="citylist">';
					$.each(data.values,function(i,p){
						citySelect+='<option data-provincedm="'+p[0]+'" data-provincemc="'+p[1]+'" value="'+p[2]+'">'+p[3]+'</option>'
					});
					citySelect+='</select><div class="hr hr-16 hr-dotted"></div>';
					$("#cityListDiv").html(citySelect);
					initCityDom();
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				Showbo.Msg.alert("服务器异常");
			}
		});
	}
	var demo2 = $('select[name="provinceList"]').bootstrapDualListbox({
		infoTextFiltered: '<span class="label label-purple label-lg">Filtered</span>',
		filterPlaceHolder:"筛选",
		moveAllLabel:"选择全部",
		removeAllLabel:"移除所有",
		success:function(item){
			 var provinceDm = "";
			item.element.find('option:selected').each(function(i, p) {
				provinceDm+=$(p).val()+",";
			 });
			provinceDm = provinceDm.substring(0,provinceDm.length-1);
			sysGetCity(provinceDm); 
		},
		initSuccess:function(item){
			/* item.element.find('option').each(function(i, p) {
				if($(p).html().indexOf("内蒙")>=0){
					sysGetCity($(p).val());
				}	 
			 }); */
			
		}
	});
	var container2 = demo2.bootstrapDualListbox('getContainer');
	container2.find('.btn').addClass('btn-white btn-info btn-bold');
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

//关闭弹窗
$("#closeTaskDetail").click(function(){
	$(".taskDetail").hide();
	$(".iso_alert").hide();
	$(".addDataBase").hide();
	$(".iso_alertKuang").removeClass("alertMinWid");
});
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
			url:"${ctxPath}/v1/html/data/dataCollect/cleverImport/addDataBase.do",
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
//点击选择行业
$(".conditonTitle").click(function(){
	if($(this).parent().find(".allCondent").is(":visible")){
		$(this).parent().find(".allCondent").hide();
	}else{
		$(this).parent().find(".allCondent").show();
	}
	$(".hangyeBottomCeng").show();
});
//取消选择选择行业
$(".cancleBtn").click(function(){
	$(this).parent().parent().parent().hide();
	$(".allCondent input[type=checkbox]").each(function(i,p){
		if($(p).attr("data-confirmed")!="confirm"){
			$(p).attr("checked",false);
			$(p).prop("checked",false);
		}else{
			$(p).attr("checked",true);
			$(p).prop("checked",true);
		}
	});
	$(".hangyeBottomCeng").hide();
});
//确定选择行业
$(".confirmBtn").click(function(){
	var hangyeName = "";
	$(this).parent().parent().parent().hide();
	$(".allCondent input[type=checkbox]").each(function(i,p){
		if($(p).is(":checked")){
			$(p).attr("data-confirmed","confirm");
			hangyeName+=$(p).next().html()+"+";
		}else{
			$(p).attr("data-confirmed","cancle");
		}
	});
	hangyeName = hangyeName.substring(0,hangyeName.length-1);
	if(hangyeName==""){
		hangyeName="选择行业";
	}
	$(".condtitleWord").html(hangyeName);
	$(".hangyeBottomCeng").hide();
});
function multiCheckbox(el){
	var thisName = $(el).attr("name");
	if(thisName.indexOf("all")>=0){
		var newthisName = thisName.substring(0,thisName.length-3);
		if($(el).is(":checked")){
			$("input[name="+newthisName+"]").attr("checked",true);
			$("input[name="+newthisName+"]").prop("checked",true);
		}else{
			$("input[name="+newthisName+"]").attr("checked",false);
			$("input[name="+newthisName+"]").prop("checked",false);
		}
	}else{
		var newthisName = thisName.substring(0,thisName.length-3);
		if($("input[name="+thisName+"]").length ==$("input[name="+thisName+"]:checked").length){
			$("input[name="+thisName+"all]").attr("checked",true);
			$("input[name="+thisName+"all]").prop("checked",true);
		}else{
			$("input[name="+thisName+"all]").attr("checked",false);
			$("input[name="+thisName+"all]").prop("checked",false);
		}
	}
}
$(".allCondent input[type=checkbox]").click(function(){
	multiCheckbox(this);
});
$(".multiCheck input[type=checkbox]").click(function(){
	multiCheckbox(this);
});
</script>
</body>

</html>