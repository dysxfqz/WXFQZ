<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>测算报告</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
<style>
	#resultDetailList th{min-width:104px;}
	.Releft_word{
		display:inline-block;
		width:95px;
		text-align:right;
	}
	.multiCheck{
		float: left;
   	 	display: inline-block;
   	 	width: calc(100% - 100px);
	}
</style>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>测算报告</h1>
			<span class="detailGoBack">返回</span>
		</div>
		<div class="detailCondition">
			<ul>
				<li><span class="Releft_word">社会信用代码：</span><span style="padding-left:4px;"><input type="text" value="" id="societyCode"></span></li>
				<li><span class="Releft_word">纳税人名称：</span><span><input type="text" value="" id="name"></span></li><br>
				<c:if test="${swjgList.size()>0}">
				 <li style="width:100%">
					<span class="Releft_word" style="float:left;line-height:35px;">税务机关：</span>
						<span class="multiCheck" >
							<div>
								<label class="taskRaidolable" style="width:auto">
									<input value="0" name="taxAuthorityall" type="checkbox" checked class="ace">
									<span class="lbl"><span class="taskraidoWord" style="font-weight:bold;width:auto">全部</span></span>
								</label>
								<a href="javascript:void(0)" class="slg" style="line-height: 20px;margin-top: 10px;">展开>></a>
							</div>
							<div style="display:none">
								<c:forEach items="${swjgList}" var="p">
									<label class="taskRaidolable">
										<input value="${p}" name="taxAuthority" checked type="checkbox" class="ace">
										<span class="lbl"><span class="taskraidoWord">${p}</span></span>
									</label>
								</c:forEach>
							</div>
					</span>
				</li><br>
				</c:if>
				<li style="width:100%">
					<span class="Releft_word" style="float:left;line-height:35px;">登记注册类型：</span>
						<span class="multiCheck">
							<span style="display:block">
								<label class="taskRaidolable" style="width:auto">
									<input value="0" name="economicTypeall" type="checkbox" checked class="ace">
									<span class="lbl"><span class="taskraidoWord" style="font-weight:bold;width:auto">全部</span></span>
								</label>
								<a href="javascript:void(0)" class="slg" style="line-height: 20px;margin-top: 10px;">展开>></a>
							</span>
							<div style="display:none">
								<c:forEach items="${djzclxList}" var="p">
									<label class="taskRaidolable">
										<input value="${p}" name="economicType" checked type="checkbox" class="ace">
										<span class="lbl"><span class="taskraidoWord">${p}</span></span>
									</label>
								</c:forEach>
							</div>
					</span>
				</li><br>
				<!-- <li style="width:520px;"><span class="Releft_word">应申报税款：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li>
				<li style="width:520px;"><span class="Releft_word">已申报税款：</span><span>
					<input type="text" value="" class="doubleInp" >
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp">
					</span>
				</li> -->
				<li style="width:520px;"><span class="Releft_word">差额：</span><span>
					<input type="text" value="" class="doubleInp" id="minCha">
							<span class="doubleInpHeng">一</span>
							<input type="text" value="" class="doubleInp" id="maxCha">
					</span>
				</li>
				<li><a href="#" class="detailConditionCheck" id="goCheck">查询</a></li>
			</ul>
		</div>
		<div style="width:100%;overflow-x:auto;position:relative">
		<div class="meuListDiv">
		<div class="table-header">
			<span>&nbsp;</span>
			<span class="export exportPL" onclick="exportPLAll()" data-taxid="">全部导出</span>
			<span>&nbsp;</span>
			<span class="export exportPL" onclick="exportPL()">批量导出</span>
		</div>
		<table class="resultTable table table-info table-striped table-bordered table-hover" id="resultDetailList">
			<thead>
				<tr>
					<th style="width: 80px;min-width:80px;"><label><input class="ace ace-checkbox-1" name="resultAllExport"  type="checkbox"/><span class="lbl">选择</span></label></th>
					<th style="width: 65px;min-width:65px;">NO.</th>
					<th>社会信用代码（纳税人识别号）</th>
					<th>纳税人名称</th>
					<th>差额</th>
					<th>差额占比</th>
					<th>风险等级</th>
					<th>操作</th>

				</tr>
			</thead>
			<tbody>
			<c:forEach items="${taxPeopleList}" varStatus="status" var="map">
				<tr>
					<td style="text-align:center;">
						<input class="ace ace-checkbox-1" name="resultExport"  type="checkbox" data-taxId="${map.TASKID}" data-xh="${map.xh}"/>
						<span class="lbl"></span>
					</td>
					<td>${status.index+1}</td>
					<td>
						<c:if test="${map.NSRSSSHXYDM!='NA'}">${map.NSRSSSHXYDM}</c:if>
						<c:if test="${map.NSRSSSHXYDM=='NA'}">${map.TAXID}</c:if>
						<c:if test="${map.NSRSSSHXYDM=='NA'&&TAXID=='NA'}">${map.NSRSSDJZCDM}</c:if>
					</td>
					<td><a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID=${map.TASKID}&xh=${map.xh}&NSRMC=${map.NSRMC}&NSRSSSHXYDM=${map.NSRSSSHXYDM}&TAXID=${map.TAXID}&NSRSSDJZCDM=${map.NSRSSDJZCDM}">${map.NSRMC}</a></td>
					<td><fmt:formatNumber value="${map.CE}" pattern="#,###.##" minFractionDigits="2" /></td>
					<td><fmt:formatNumber value="${map.CEZB*100}" pattern="#.##" minFractionDigits="2" />%</td>
					<td>${map.fxdj}</td>
					
					<td><a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID=${map.TASKID}&xh=${map.xh}&NSRMC=${map.NSRMC}&NSRSSSHXYDM=${map.NSRSSSHXYDM}&TAXID=${map.TAXID}&NSRSSDJZCDM=${map.NSRSSDJZCDM}">一户式报告</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
			<div class="tableLodaing"><span class="fa fa-spinner fa-spin bigger-150"></span></div>
	</div>
	</div>
	</div>
</div>
 <div id="loadingState">
 	<div>
 		<div><img class="load_img" src="${ctxPath}/static/source/img/loading.gif" style="width:50px;"/></div>
 	</div>
 </div>
 <input type="hidden" value="0" id="checkSearch">
<input type="hidden" value="${RwInfo.CJR}" id="cjr">
<input type="hidden" value="${RwInfo.CJSJ}" id="cjsj">
<input type="hidden" value="${maxCount}" id="maxCount">
<script>
var oTable1 = null;
var maxCount=0;
$(function(){
	maxCount =  $("#maxCount").val();
	oTable1 =$('#resultDetailList').DataTable( {
		bStateSave: false,
		bAutoWidth: false,
		"aaSorting": [],
		"aoColumns": [
		  { "bSortable": false },
		  null, null, null,null, null, null,
		  { "bSortable": false }
		],
		"aoColumnDefs": [
			{
			 sDefaultContent: '',
			 aTargets: [ '_all' ]
			  }
			],
				"bMaxDataNumber":maxCount,
	    } );
		//$(".meuListDiv").css("width",$("#resultDetailList").width());
});
$(window).resize(function(){
	//$(".meuListDiv").css("width","auto");
});
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/analyse/result/resultList.do";
});
var TASKID = zs_getUrlParameter("TASKID");
var batch = 0;
var pageSize = 100;
var cjr = $("#cjr").val();
var cjsj = $("#cjsj").val();
function loadNewData(el){
	if($(el).attr("class").indexOf("removeDisabled")>=0){
		batch++;
		var datas = $("#checkSearch").val();
		datas = JSON.parse(datas);
		datas.batch = batch;
		$(".meuListDiv .tableLodaing").show();
		var taskid = $("#taskid").val();
		var taxid = $("#taxid").val();
		var  activePage = $(".meuListDiv .paginate_button.active a").html();
		var currentCount = $("#resultDetailList_info").html();//当前总共的条数
		currentCount = parseInt(currentCount.substring(1,currentCount.length))
		 $.ajax({
			url:"${ctxPath}/v1/html/analyse/result/getBatchData.do",
			type:"post",
			data:datas,
			dataType:"json",
			success:function(data){
				if(data.result=="ok"){
					$.each(data.values,function(i,p){
						var tempCode = p.NSRSSSHXYDM
						if(tempCode=='NA'){
							tempCode = p.TAXID
						}else if(tempCode=='NA'){
							tempCode = p.NSRSSDJZCDM
						}
						var tempArray = [];
						tempArray.push('<input class="ace ace-checkbox-1"  type="checkbox" /><span class="lbl"></span>');
						tempArray.push(currentCount+i+1);
						tempArray.push(tempCode);
						tempArray.push('<a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID='+p.TASKID+'&xh='+p.xh+'&NSRMC='+p.NSRMC+'&NSRSSSHXYDM='+p.NSRSSSHXYDM+'&TAXID='+p.TAXID+'&NSRSSDJZCDM='+p.NSRSSDJZCDM+'">'+p.NSRMC+'</a>');
						tempArray.push(p.CE);
						tempArray.push(parseInt(p.CEZB*10000)/100+"%");
						tempArray.push(p.fxdj);
						tempArray.push('<a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID='+p.TASKID+'&xh='+p.xh+'&NSRMC='+p.NSRMC+'&NSRSSSHXYDM='+p.NSRSSSHXYDM+'&TAXID='+p.TAXID+'&NSRSSDJZCDM='+p.NSRSSDJZCDM+'">一户式报告</a>');
						oTable1.row.add(tempArray).draw(); 
					});
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
				$(".meuListDiv .tableLodaing").hide();
				oTable1.page(parseInt(activePage)).draw(false);
			},
			error:function(){
				Showbo.Msg.alert('查询失败'); 
			}
		}); 
	}
}
//导出
function exportPL(){
	var TASKID="";
	var xh="";
	$("input[name=resultExport]:checked").each(function(i,p){
		TASKID += $(p).attr("data-taxId")+"_";
		xh += $(p).attr("data-xh")+"_";
	});
	if(TASKID==""){
		Showbo.Msg.alert("请选择需要导出的结果");
		return;
	}
	TASKID = TASKID.substring(0,TASKID.length-1);
	xh = xh.substring(0,xh.length-1);
	$("#loadingState").show();
	$.ajax({
		url:"${ctxPath}/v1/html/modelBuild/modelResult/zipExcel.do",
		dataType:"json",
		type:"post",
		data:{
			TASKID:TASKID,
			xh:xh
		},
		success:function(data){
			$("#loadingState").hide();
			if(data.result=="ok"){
				downloadFile(data.values);
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			$("#loadingState").hide();
			Showbo.Msg.alert("服务器异常");
		}
	});
}
//全部导出
function exportPLAll(){
	var TASKID=getParameter("TASKID");
	$("#loadingState").show();
	$.ajax({
		url:"${ctxPath}/v1/html/modelBuild/modelResult/zipExcelAll.do",
		dataType:"json",
		type:"post",
		data:{
			TASKID:TASKID
		},
		success:function(data){
			$("#loadingState").hide();
			if(data.result=="ok"){
				downloadFile(data.values);
			}else{
				Showbo.Msg.alert(data.errormsg);
			}
		},
		error:function(){
			$("#loadingState").hide();
			Showbo.Msg.alert("服务器异常");
		}
	});
}
function downloadFile(url) {   
    try{ 
        var elemIF = document.createElement("iframe");   
        elemIF.src = url;   
        elemIF.style.display = "none";   
        document.body.appendChild(elemIF);   
    }catch(e){ 
		console.log(e);
    } 
}
$("input[name=resultAllExport]").click(function(){
	if($(this).is(":checked")){
		$("input[name=resultExport]").attr("checked",true);
		$("input[name=resultExport]").prop("checked",true);
	}else{
		$("input[name=resultExport]").attr("checked",false);
		$("input[name=resultExport]").prop("checked",false);
	}
});
function toDecimal2(x) { 
	   var f = parseFloat(x); 
	   if (isNaN(f)) { 
	    return false; 
	   } 
	   var f = Math.round(x*100)/100; 
	   var s = f.toString(); 
	   var rs = s.indexOf('.'); 
	   if (rs < 0) { 
	    rs = s.length; 
	    s += '.'; 
	   } 
	   while (s.length <= rs + 2) { 
	    s += '0'; 
	   } 
	   return s; 
	  }
//搜索查询功能
$("#goCheck").click(function(){
	var societyCode = $("#societyCode").val();
	var name = $("#name").val();
	var taxAuthority ="";
	var economicType = "";
	var minCha = $("#minCha").val();
	var maxCha = $("#maxCha").val();
	 var f = parseFloat(minCha); 
	   if(isNaN(minCha)||isNaN(maxCha)) { 
		   Showbo.Msg.alert("差额需填写数值");
	    return false; 
	   } 
	if($("input[name=taxAuthorityall]").is(":checked")){
		taxAuthority="";
	}else{
		$("input[name=taxAuthority]:checked").each(function(){
			taxAuthority+=$(this).val()+",";
		});
		if(taxAuthority.length>0){
			taxAuthority = taxAuthority.substring(0,taxAuthority.length-1);
		}
	}
	if($("input[name=economicTypeall]").is(":checked")){
		economicType="";
	}else{
		$("input[name=economicType]:checked").each(function(){
			economicType+=$(this).val()+",";
		});
		if(economicType.length>0){
			economicType = economicType.substring(0,economicType.length-1);
		}
	}
	var datas={
		TASKID:TASKID,
		batch:0,
		pageSize:pageSize,
		nsrsbh:societyCode,
		nsrmc:name,
		swjgs:taxAuthority,
		djzclxs:economicType,
		ceup:minCha,
		cedown:maxCha
	};
	var taskid = $("#taskid").val();
	var taxid = $("#taxid").val();
	$(".meuListDiv .tableLodaing").show();
	$.ajax({
		url:"${ctxPath}/v1/html/analyse/result/getBatchData.do",
		dataType:"json",
		type:"post",
		data:datas,
		success:function(data){
			if(data.result=="ok"){
				$("#checkSearch").val(JSON.stringify(datas));
				var tempH = '<div class="table-header">'+
				'<span>&nbsp;</span>'+
				'<span class="export exportPL" onclick="exportPLAll()" data-taxid="">全部导出</span>'+
					'<span>&nbsp;</span>'+
					'<span class="export exportPL" onclick="exportPL()">批量导出</span>'+
				'</div>'+
				'<table class="resultTable table table-info table-striped table-bordered table-hover" id="resultDetailList">'+
					'<thead>'+
						'<tr>'+
							'<th style="width: 80px;min-width:80px;"><label><input class="ace ace-checkbox-1" name="resultAllExport"  type="checkbox"/><span class="lbl">选择</span></label></th>'+
							'<th style="width: 65px;min-width:65px;">NO.</th>'+
							'<th>社会信用代码（纳税人识别号）</th>'+
							'<th>纳税人名称</th>'+
							'<th>差额</th>'+
							'<th>差额占比</th>'+
							'<th>风险等级</th>'+
							'<th>操作</th>'+
						'</tr></thead><tbody>';
					$.each(data.values.mapList,function(i,p){
						var tempCode = p.NSRSSSHXYDM
						if(tempCode=='NA'){
							tempCode = p.TAXID
						}else if(tempCode=='NA'){
							tempCode = p.NSRSSDJZCDM
						}
						
						tempH+='<tr>'+
						'<td style="text-align:center;">'+
							'<input class="ace ace-checkbox-1" name="resultExport"  type="checkbox" data-taxId="'+p.TASKID+'" data-xh="'+p.xh+'"/>'+
							'<span class="lbl"></span>'+
						'</td>'+
						'<td>'+(i+1)+'</td>'+
						'<td>'+tempCode+'</td>'+
					'<td><a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID='+p.TASKID+'&xh='+p.xh+'&NSRMC='+p.NSRMC+'&NSRSSSHXYDM='+p.NSRSSSHXYDM+'&TAXID='+p.TAXID+'&NSRSSDJZCDM='+p.NSRSSDJZCDM+'">'+p.NSRMC+'</a></td>'+
						'<td>'+formatNumber(p.CE)+'</td>'+
						'<td>'+toDecimal2(parseInt(p.CEZB*10000)/100)+'%</td>'+
						'<td>'+p.fxdj+'</td>'+
						'<td><a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID='+p.TASKID+'&xh='+p.xh+'&NSRMC='+p.NSRMC+'&NSRSSSHXYDM='+p.NSRSSSHXYDM+'&TAXID='+p.TAXID+'&NSRSSDJZCDM='+p.NSRSSDJZCDM+'">一户式报告</a></td>'+
					'</tr>';
					});
					tempH+='</tbody></table><div class="tableLodaing"><span class="fa fa-spinner fa-spin bigger-150"></span></div>';
				//var tempHtml = template('reportTable',data.values);
				$(".meuListDiv").html(tempH);
				oTable1 = null;
				maxCount = data.values.maxCount;
				oTable1 =$('#resultDetailList').DataTable( {
					bStateSave: false,
					bAutoWidth: false,
					"aaSorting": [],
					"aoColumns": [
					  { "bSortable": false },
					  null, null, null,null, null, null,
					  { "bSortable": false }
					],
					"aoColumnDefs": [
						{
						 sDefaultContent: '',
						 aTargets: [ '_all' ]
						  }
						],
							"bMaxDataNumber":maxCount,
				    } );
				batch = 0;
				//$(".meuListDiv").css("width",$("#resultDetailList").width());
			}else{
				Showbo.Msg.alert(data.errormsg);
				$(".meuListDiv .tableLodaing").hide();
			}
		},
		error:function(){
			Shobo.Msg.alert("服务器异常");
			$(".meuListDiv .tableLodaing").hide();
		}
	});
});
//税务机关和登记注册类型展开于收起
$(".slg").click(function(){
	if($(this).parent().next().is(":visible")){
		$(this).html("展开>>");
	}else{
		$(this).html("收起>>");
	}
	$(this).parent().next().slideToggle();
});
//勾选全部与否
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
//格式化大金额数字
function formatNumber(num, precision, separator) {
    var parts;
    // 判断是否为数字
    if (!isNaN(parseFloat(num)) && isFinite(num)) {
        // 把类似 .5, 5. 之类的数据转化成0.5, 5, 为数据精度处理做准, 至于为什么
        // 不在判断中直接写 if (!isNaN(num = parseFloat(num)) && isFinite(num))
        // 是因为parseFloat有一个奇怪的精度问题, 比如 parseFloat(12312312.1234567119)
        // 的值变成了 12312312.123456713
        num = Number(num);
        // 处理小数点位数
        num = toDecimal2(num,precision);
       // num = (typeof precision !== 'undefined' ?  parseInt(num*100)/100 : num).toString();
        // 分离数字的小数部分和整数部分
        parts = num.split('.');
        // 整数部分加[separator]分隔, 借用一个著名的正则表达式
        parts[0] = parts[0].toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1' + (separator || ','));

        return parts.join('.');
    }
    return NaN;
}
//获取url参数
function getParameter(param){
	var query = window.location.search;
	var iLen = param.length;
	var iStart = query.indexOf(param);
	if (iStart == -1)
		return "";
	iStart += iLen + 1;
	var iEnd = query.indexOf("&", iStart);
	
	if (iEnd == -1)
		return query.substring(iStart);
	return query.substring(iStart, iEnd);
}
</script>
</body>

</html>
