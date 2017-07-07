<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>结果概览</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>结果概览</h1>
			<a href="${ctxPath}/v1/html/modelBuild/modelResult/list.do" class="detailGoBack">返回</a>
		</div>
		<div>
			<ul class="resultView">
			<li style="font-size: 16px;font-weight: bold;line-height: 35px;">
				<span>基本信息</span>
			</li>
			<li class="resultViewTable" style="border:none;background:none">
				<table>
					<tr>
						<td class="leftTilte">任务名称：</td>
						<td class="rightContent">${rw.mc}</td>				
						<td class="leftTilte">任务备注：</td>
						<td class="rightContent">${rw.ms}</td>	
					</tr>
					<tr>
						<td class="leftTilte">模型名称：</td>
						<td class="rightContent">${mx.mc}</td>				
						<td class="leftTilte">模型备注：</td>
						<td class="rightContent">${mx.ms}</td>	
					</tr>
					<tr>
						<td class="leftTilte">模型分类：</td>
						<td class="rightContent">${mxflb.mc}</td>				
						<td class="leftTilte">创建人：</td>
						<td class="rightContent">${userInfo.name}</td>	
					</tr>
					<tr>
						<td class="leftTilte">创建时间：</td>
						<td class="rightContent" colspan="3"><fmt:formatDate value="${rw.cjsj}" pattern="yyyy-MM-dd HH:mm:ss"/></td>				
					</tr>
				</table>
			</li>
			<li style="font-weight:bold;line-height: 35px;">
				<span>数据维度</span>
			</li>
			<li class="resultViewTable">
				<table >
					<tr>
						<td class="leftTilte">税种：</td>
						<td class="rightContent">${mx.szmc}</td>				
						<td class="leftTilte">行业：</td>
						<td class="rightContent">${hydlmc}</td>				
					</tr>
					<tr>
						<td class="leftTilte">城市：</td>
						<td class="rightContent">${mx.csmc}</td>				
						<td class="leftTilte">核算方式：</td>
						<td class="rightContent">${mx.hsfsmc}</td>				
					</tr>
					<tr>
						<td class="leftTilte">企业规模：</td>
						<td class="rightContent">${mx.qygm}</td>				
						<td class="leftTilte">登记注册类型：</td>
						<td class="rightContent">${djzclxmcdl}</td>				
					</tr>
					<tr>
						<td class="leftTilte">时间维度：</td>
						<td class="rightContent">
							<c:if test="${(rw.sjkssj == '' || rw.sjkssj == null) && (rw.sjjssj == '' || rw.sjjssj == null)}">所有 </c:if>
							<c:if test="${(rw.sjkssj != null && rw.sjkssj != '') || (rw.sjjssj != null && rw.sjjssj != '')}">
								<fmt:formatDate value="${rw.sjkssj }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${rw.sjjssj }" pattern="yyyy-MM-dd"/>
							</c:if>
						</td>				
					</tr>
				</table>
			</li>
			</ul>
		</div>
		<table class="resultTable table table-info table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>总户数</th>
					<th>总流失户</th>
					<th>总流失户占比</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="center">${docCount1}</td>
					<td class="center">${docCount2}</td>
					<td class="center"><fmt:formatNumber value="${zlshszb*100}" pattern="#.##" minFractionDigits="2" />%</td>
				</tr>
			</tbody>
		</table>
		<table class="resultTable table table-info table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>总应申报金额</th>
					<th>总已申报金额</th>
					<th>总流失金额</th>
					<th>总流失金额占比</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="center"><fmt:formatNumber value="${ycskze}" pattern='#,###.##' minFractionDigits="2" /></td>
					<td class="center"><fmt:formatNumber value="${ysbskze}" pattern="#,###.##" minFractionDigits="2" /></td>
					<td class="center"><fmt:formatNumber value="${lsje}" pattern="#,###.##" minFractionDigits="2" /></td>
					<td class="center"><fmt:formatNumber value="${zlsjezb*100}"  />%</td>
				</tr>
			</tbody>
		</table>
		
		<div style="text-align:right">
			<a href="${ctxPath}/v1/html/modelBuild/modelResult/taxpayerList.do?TASKID=${rw.rwh}" class="taxBtn">一户式报告</a>
		</div>
		<div class="payMethodTitle">
			<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a href="#highRisk"
					data-toggle="tab">高风险纳税人TOP 10</a></li>
				<li><a href="#shuiwuTab" data-toggle="tab" onclick="setTimeout(function(){creatShuiwu()},500)">税务机关</a></li>
				<li><a href="#qiyeTab" data-toggle="tab" onclick="setTimeout(function(){creatQiye()},500)">企业类型</a></li>
				<li><a href="#riskLevelTab" data-toggle="tab" onclick="setTimeout(function(){creatfengxian()},500)">风险级别</a></li>
			</ul>
		</div>
		<div id="myTabContent" class="tab-content">
			<div class=" childTab  tab-pane fade  in active" id="highRisk">
				<div class="col-xs-8" id="highRiskImg" style="height:500px;">
		
				</div>
				<div class="col-xs-4" style="min-height:500px;">
					<div style="text-align:right"><a href="${ctxPath}/v1/html/modelBuild/modelResult/taxpayerList.do?TASKID=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>NO.</th>
								<th>纳税人识别号</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="highRiskTableCont">
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class=" childTab  tab-pane fade" id="shuiwuTab">
				<div class="col-xs-8" id="shuiwuTabImg" style="height:500px;">
		
				</div>
				<div class="col-xs-4" style="min-height:500px;">
					<div style="text-align:right"><a href="${ctxPath}/v1/html/modelBuild/modelResult/detailList.do?type=1&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>NO.</th>
								<th>区县</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="shuiwuTabale">
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class=" childTab  tab-pane fade" id="qiyeTab">
				<div class="col-xs-8" id="qiyeTabImg" style="height:500px;">
		
				</div>
				<div class="col-xs-4" style="min-height:500px;">
					<div style="text-align:right"><a href="${ctxPath}/v1/html/modelBuild/modelResult/detailList.do?type=2&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>NO.</th>
								<th>企业类型</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="qiyeTable">
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class=" childTab  tab-pane fade" id="riskLevelTab">
				<div class="col-xs-8" id="riskLevelImg" style="height:500px;">
		
				</div>
				<div class="col-xs-4" style="min-height:500px;">
					<div style="text-align:right"><a href="${ctxPath}/v1/html/modelBuild/modelResult/detailList.do?type=3&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>NO.</th>
								<th>风险级别<span class="fa fa-cog setRisk" data-toggle="tooltip" title="自定义风险级别"></span></th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="riskTable">
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="iso_alert">
<div class="iso_alertKuang col-xs-12 col-sm-6">
	<div class="setRiskDiv">
		<div class="iso_alertHeader">
			<h2 class="iso_alertTitle">自定义风险级别</h2>
			<span id="closeTaskDetail" class="close_alertIso">&times;</span>
			<hr>
		</div>
		<div class="iso_alertBody">
			<form class="form-horizontal">
				<div class="form-group">
					<label class="col-sm-2 col-xs-4 control-label no-padding-right existenceCon" >定义方式：</label>
					<div class="col-sm-9 col-xs-8">
						<div class="radio radioUl">
							<label>
								<input value="0" name="dataType" type="radio" checked class="ace">
								<span class="lbl">数值</span>
							</label>
							<label>
								<input value="1" name="dataType" type="radio" class="ace">
								<span class="lbl">百分比</span>
							</label>
						</div>
					</div>
				</div>
				<div id="riskSetArea">
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
								<input type="number" value="" class="riskMaxCount lastRiskLevel col-xs-12 col-sm-4" onblur=""><span class="riskUnit"></span>
							</div>
						</div>
						<hr>
					</div>
					<div id="newAddRisk"></div>
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
<input type="hidden" value="${toptenX}" id="topTenX">
<input type="hidden" value="${toptenY}" id="topTenY">
<input type="hidden" value="${taxAuthX}" id="taxAuthX">
<input type="hidden" value="${taxAuthY}" id="taxAuthY">
<input type="hidden" value="${compX}" id="compX">
<input type="hidden" value="${compY}" id="compY">
<input type="hidden" value="${riskX}" id="riskX">
<input type="hidden" value="${riskY}" id="riskY">
<script src="${ctxPath}/static/source/js/echarts.js"></script>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
<script>
$(function(){$("[data-toggle='tooltip']").tooltip(); });
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
function creatHighRisk(){
		var topTenX = $("#topTenX").val().split(",");
		var topTenY = $("#topTenY").val().split(",");
		var tableContent = "";
		$.each(topTenX,function(i,p){
			var tempY =Number(topTenY[i]);
			tableContent += '<tr><td style="text-align:center">'+(i+1)+'</td><td>'+p+'</td><td style="text-align:right">'+formatNumber(tempY)+'</td></tr>'
		});
		$("#highRiskTableCont").html(tableContent);
		var dom = document.getElementById("highRiskImg");
		var myChart = echarts.init(dom);
		var app = {};
		var option = null;
		var xAxisData = topTenX;
		var data1 =topTenY;
		var itemStyle = {
                //通常情况下：
                normal:{  
　　　　　　　　　　　　//每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(221, 80, 68)','rgb(255, 206, 67)','rgb(24, 161, 95)','rgb(39, 126, 171)','rgb(170, 49, 77)','rgb(41, 60, 85)','rgb(87, 94, 231)','rgb(167, 96, 39)','rgb(249, 116, 149)','rgb(81, 145, 148)'];
                        return colorList[params.dataIndex];
                    }
                },
		   /*  emphasis: {
		        barBorderWidth: 1,
		        shadowBlur: 10,
		        shadowOffsetX: 0,
		        shadowOffsetY: 0,
		        shadowColor: 'rgba(0,0,0,0.5)'
		    } */
		};
		option = {
			title: {
		        text: '高风险纳税人前10名',
		    },
		    backgroundColor: '#fff',
		    tooltip: {},
		    xAxis: {
		        data: xAxisData,
		        name: 'X Axis',
		        silent: false,
		        axisLabel: {
		               interval: 0,
		               rotate: 45,
		         },
		        axisLine: {onZero: true},
		        splitLine: {show: false},
		        splitArea: {show: false}
		    },
		    yAxis: {
		        inverse: false,
		        splitArea: {show: false},
		    },
		    grid: {
		        left: 100
		    },
		 
		    series: [
		        {
		            type: 'bar',
		            stack: 'one',
		            itemStyle: itemStyle,
		            data: data1
		        }
		    ]
		};

		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
}
	//画税务机关图
	function creatShuiwu(){
		var dom = document.getElementById("shuiwuTabImg");
		var myChart = echarts.init(dom);
		var app = {};
		var xMsg = $("#taxAuthX").val().split(",");
		var yMsg = $("#taxAuthY").val().split(",");
		var data = [];
		var option = null;
		var tempTable = '';
		$.each(xMsg,function(i,p){
			var tempY = Number(yMsg[i]);
			var dataMsg = {value:0,name:''};
			dataMsg.value=tempY.toFixed(2);
			dataMsg.name=p;
			data.push(dataMsg);
			tempTable+='<tr><td style="text-align:center">'+(i+1)+'</td><td>'+p+'</td><td>'+formatNumber(tempY,2)+'</td></tr>';
		});
		$("#shuiwuTabale").html(tempTable);
		option = {
			    title : {
			        text: '税务机关',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    series : [
			        {
			            name: '税务机关',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:data,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};

		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
	}
	//画税企业类型
	function creatQiye(){
		var dom = document.getElementById("qiyeTabImg");
		var myChart = echarts.init(dom);
		var app = {};
		var xMsg = $("#compX").val().split(",");
		var yMsg = $("#compY").val().split(",");
		var data = [];
		var option = null;
		var tempTable = '';
		$.each(xMsg,function(i,p){
			var tempY = Number(yMsg[i]);
			var dataMsg = {value:0,name:''};
			dataMsg.value=tempY.toFixed(2);
			dataMsg.name=p;
			data.push(dataMsg);
			tempTable+='<tr><td style="text-align:center">'+(i+1)+'</td><td>'+p+'</td><td>'+formatNumber(tempY,2);+'</td></tr>';
		});
		$("#qiyeTable").html(tempTable);
		option = {
			    title : {
			        text: '企业类型',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    series : [
			        {
			            name: '企业类型',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:data,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};

		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
	}
	//画风险级别
	function creatfengxian(){
		var dom = document.getElementById("riskLevelImg");
		var myChart = echarts.init(dom);
		var app = {};
		var xMsg = $("#riskX").val().split(",");
		var yMsg = $("#riskY").val().split(",");
		var data = [];
		var option = null;
		var tempTable = '';
		var shunxu = [];
		$.each(xMsg,function(i,p){
			shunxu.push(p.substring(0,1)+"_"+i);
		});
		xMsg.sort();
		shunxu.sort();
		$.each(xMsg,function(i,p){
			var tempY = Number(yMsg[shunxu[i].substring(2,3)]);
			var dataMsg = {value:0,name:''};
			dataMsg.value=tempY.toFixed(2);
			dataMsg.name=p.substring(1,p.indexOf("："));
			data.push(dataMsg);
			if(p.substring(p.indexOf("：")+1,p.length).indexOf("%")<0){
				var fanwei = p.substring(p.indexOf("：")+1,p.length).split("-");
				fanwei[0] = formatNumber(fanwei[0],2);
				fanwei[1] = formatNumber(fanwei[1],2);
			}else{
				var fanwei = p.substring(p.indexOf("：")+1,p.length).split("-");
			}
			tempTable+='<tr><td style="text-align:center">'+(i+1)+'</td><td>'+dataMsg.name+'-级别所属级别区间:'+fanwei[0]+"-"+fanwei[1]+'</td><td>'+formatNumber(tempY,2);+'</td></tr>';
		});
		$("#riskTable").html(tempTable);
		option = {
			    title : {
			        text: '风险级别',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    series : [
			        {
			            name: '风险级别',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:data,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};

		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
	}
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
	        num = (typeof precision !== 'undefined' ?  parseInt(num*100)/100 : num).toString();
	        // 分离数字的小数部分和整数部分
	        parts = num.split('.');
	        // 整数部分加[separator]分隔, 借用一个著名的正则表达式
	        parts[0] = parts[0].toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1' + (separator || ','));

	        return parts.join('.');
	    }
	    return NaN;
	}
	creatHighRisk();
	
	//自定义风险级别
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
	$(".setRisk").click(function(){
		$(".iso_alert").show();
		$(".setRiskDiv").show();
		resizeIsoAlert();
	});
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
	resizeIsoAlert();
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
		if($(".lastRiskLevel").val()>100){
			Showbo.Msg.alert("按百分比分配最大值不能大于100");
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
		url:"${ctxPath}/v1/html/modelBuild/modelResult/customFxjb.do",
		dataType:"json",
		type:"post",
		data:{
			rwh:rwh,
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
});
</script>
</body>

</html>
