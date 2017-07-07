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
			<a href="${ctxPath}/v1/html/task/result/overviewList.do" class="detailGoBack">返回</a>
		</div>
		<div>
			<ul class="resultView">
			<li style="font-size: 16px;font-weight: bold;    line-height: 35px;">
				<span>${rw.mc}</span>
			</li>
			<li>
				<span class="resultViewLiLeft">模型名称：</span><span class="resultViewLiRight">${mx.mc}</span>
			</li>
			<li>
				<span class="resultViewLiLeft">创建人：</span><span class="resultViewLiRight">${userInfo.name}</span>
			</li>
			<li>
				<span class="resultViewLiLeft">创建时间：</span><span class="resultViewLiRight"><fmt:formatDate value="${rw.cjsj}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
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
						<td class="rightContent"><fmt:formatDate value="${rw.sjkssj}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${rw.sjjssj}" pattern="yyyy-MM-dd"/></td>				
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
					<td>${docCount1}</td>
					<td>${docCount2}</td>
					<td><fmt:formatNumber value="${zlshszb*100}" pattern="#.##" minFractionDigits="2" />%</td>
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
					<td><fmt:formatNumber value="${ycskze}" pattern='#,###.##' minFractionDigits="2" /></td>
					<td><fmt:formatNumber value="${ysbskze}" pattern="#,###.##" minFractionDigits="2" /></td>
					<td><fmt:formatNumber value="${lsje}" pattern="#,###.##" minFractionDigits="2" /></td>
					<td><fmt:formatNumber value="${zlsjezb*100}"  />%</td>
				</tr>
			</tbody>
		</table>
		
		<div style="text-align:right">
			<a href="${ctxPath}/v1/html/task/result/taxpayerList.do?TASKID=${rw.rwh}" class="taxBtn">一户式报告</a>
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
					<div style="text-align:right"><a href="${ctxPath}/v1/html/task/result/taxpayerList.do?TASKID=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>纳税人识别号</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="highRiskTableCont">
							<tr>
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
					<div style="text-align:right"><a href="${ctxPath}/v1/html/task/result/detailList.do?type=1&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>区县</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="shuiwuTabale">
							<tr>
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
					<div style="text-align:right"><a href="${ctxPath}/v1/html/task/result/detailList.do?type=2&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>企业类型</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="qiyeTable">
							<tr>
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
					<div style="text-align:right"><a href="${ctxPath}/v1/html/task/result/detailList.do?type=3&taskId=${rw.rwh}" class="taxLookDetail">查看详情</a></div>
					<table class="resultTable table table-info table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>风险级别</th>
								<th>流失金额</th>
							</tr>
						</thead>
						<tbody id="riskTable">
							<tr>
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
<input type="hidden" value="${toptenX}" id="topTenX">
<input type="hidden" value="${toptenY}" id="topTenY">
<input type="hidden" value="${taxAuthX}" id="taxAuthX">
<input type="hidden" value="${taxAuthY}" id="taxAuthY">
<input type="hidden" value="${compX}" id="compX">
<input type="hidden" value="${compY}" id="compY">
<input type="hidden" value="${riskX}" id="riskX">
<input type="hidden" value="${riskY}" id="riskY">
<script src="${ctxPath}/static/source/js/echarts.js"></script>
<script>
	function creatHighRisk(){
		var topTenX = $("#topTenX").val().split(",");
		var topTenY = $("#topTenY").val().split(",");
		var tableContent = "";
		$.each(topTenX,function(i,p){
			var tempY =Number(topTenY[i]);
			tableContent += '<tr><td>'+p+'</td><td style="text-align:right">'+formatNumber(tempY)+'</td></tr>'
		});
		$("#highRiskTableCont").html(tableContent);
		var dom = document.getElementById("highRiskImg");
		var myChart = echarts.init(dom);
		var app = {};
		var option = null;
		var xAxisData = topTenX;
		var data1 =topTenY;
		var itemStyle = {
		    normal: {
		    },
		    emphasis: {
		        barBorderWidth: 1,
		        shadowBlur: 10,
		        shadowOffsetX: 0,
		        shadowOffsetY: 0,
		        shadowColor: 'rgba(0,0,0,0.5)'
		    }
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
			tempTable+='<tr><td>'+p+'</td><td>'+formatNumber(tempY,2)+'</td></tr>';
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
			tempTable+='<tr><td>'+p+'</td><td>'+formatNumber(tempY,2);+'</td></tr>';
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
		xMsg.sort();
		$.each(xMsg,function(i,p){
			var tempY = Number(yMsg[i]);
			var dataMsg = {value:0,name:''};
			dataMsg.value=tempY.toFixed(2);
			dataMsg.name=p.substring(1,p.length);
			data.push(dataMsg);
			tempTable+='<tr><td>'+p.substring(1,p.length)+'</td><td>'+formatNumber(tempY,2);+'</td></tr>';
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
</script>
</body>

</html>
