<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>流失情况散点图</title>
<link rel="stylesheet"
	href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>流失情况散点图</h1>
		<a href="${ctxPath}/v1/html/modelReport/intermediate/list.do"
			class="detailGoBack">返回</a>
	</div>
	<div class="col-xs-10" id=container style="height: 500px;"></div>
	<div style="clear:both"></div>
	<div class="row" style="margin-top:20px;padding-left:12px">	
		<div class="col-xs-5">
			<div class="table-header">行业一</div>
			<table
				class="resultTable table table-info table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>流失率</th>
					</tr>
				</thead>
				<tbody id="highRiskTableCont">
				</tbody>
			</table>
			</div>
		<div class="col-xs-5">
			<div class="table-header">行业二</div>
			<table
				class="resultTable table table-info table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>序号</th>
						<th>流失率</th>
					</tr>
				</thead>
				<tbody id="highRiskTableCont2">
				</tbody>
			</table>
		</div>
	</div>
</div>
		<script src="${ctxPath}/static/source/js/echarts.js"></script>
		<script>
			var dom = document.getElementById("container");
			var myChart = echarts.init(dom);
			var app = {};
			option = null;

			var data = [
					[ [ 1, 10, 17096869, '企业1', '行业一' ],
							[ 2, 20, 27662440, '企业2', '行业一' ],
							[ 3, 30, 1154605773, '企业3', '行业一' ],
							[ 4, 40, 10582082, '企业4', '行业一' ],
							[ 5, 50, 4986705, 'Finland', '行业一' ],
							[ 6, 60, 56943299, 'France', '行业一' ],
							[ 7, 70, 78958237, 'Germany', '行业一' ],
							[ 9, 80, 254830, 'Iceland', '行业一' ],
							[ 11, 90, 870601776, 'India', '行业一' ],
							[ 25, 100, 122249285, 'Japan', '行业一' ],
							[ 37, 10, 20194354, 'North Korea', '行业一' ],
							[ 39, 20, 42972254, 'South Korea', '行业一' ],
							[ 21, 30, 3397534, 'New Zealand', '行业一' ],
							[ 46, 40, 4240375, 'Norway', '行业一' ],
							[ 33, 50, 38195258, 'Poland', '行业一' ],
							[ 17, 60, 147568552, 'Russia', '行业一' ],
							[ 28, 70, 53994605, 'Turkey', '行业一' ],
							[ 22, 80, 57110117, 'United Kingdom', '行业一' ],
							[ 32, 90, 252847810, 'United States', '行业一' ] ],
					[ [ 2, 15, 23968973, '企业1', '行业二' ],
							[ 7, 12, 35939927, '企业2', '行业二' ],
							[ 6, 91, 1376048943, '企业3', '行业二' ],
							[ 11, 81, 11389562, '企业4', '行业二' ],
							[ 15, 71, 5503457, 'Finland', '行业二' ],
							[ 39, 61, 64395345, 'France', '行业二' ],
							[ 28, 51, 80688545, 'Germany', '行业二' ],
							[ 25, 31, 329425, 'Iceland', '行业二' ],
							[ 44, 11, 1311050527, 'India', '行业二' ],
							[ 45, 21, 126573481, 'Japan', '行业二' ],
							[ 15, 91, 25155317, 'North Korea', '行业二' ],
							[ 20, 81, 50293439, 'South Korea', '行业二' ],
							[ 22, 71, 4528526, 'New Zealand', '行业二' ],
							[ 24, 61, 5210967, 'Norway', '行业二' ],
							[ 35, 51, 38611794, 'Poland', '行业二' ],
							[ 43, 41, 143456918, 'Russia', '行业二' ],
							[ 14, 31, 78665830, 'Turkey', '行业二' ],
							[ 27, 21, 64715810, 'United Kingdom', '行业二' ],
							[ 19, 11, 321773631, 'United States', '行业二' ] ] ];

			option = {
				backgroundColor : new echarts.graphic.RadialGradient(0.3, 0.3,
						0.8, [ {
							offset : 0,
							color : '#f7f8fa'
						}, {
							offset : 1,
							color : '#cdd0d5'
						} ]),
				legend : {
					right : 10,
					data : [ '行业一', '行业二' ]
				},
				xAxis : {
					splitLine : {
						lineStyle : {
							type : 'dashed'
						}
					}
				},
				yAxis : {
					splitLine : {
						lineStyle : {
							type : 'dashed'
						}
					},
					scale : true
				},
				series : [
						{
							name : '行业一',
							data : data[0],
							type : 'scatter',
							symbolSize : function(data) {
								return Math.sqrt(data[2]) / 5e2;
							},
							label : {
								emphasis : {
									show : true,
									formatter : function(param) {
										return param.data[3];
									},
									position : 'top'
								}
							},
							itemStyle : {
								normal : {
									shadowBlur : 10,
									shadowColor : 'rgba(120, 36, 50, 0.5)',
									shadowOffsetY : 5,
									color : new echarts.graphic.RadialGradient(
											0.4, 0.3, 1, [ {
												offset : 0,
												color : 'rgb(251, 118, 123)'
											}, {
												offset : 1,
												color : 'rgb(204, 46, 72)'
											} ])
								}
							}
						},
						{
							name : '行业二',
							data : data[1],
							type : 'scatter',
							symbolSize : function(data) {
								return Math.sqrt(data[2]) / 5e2;
							},
							label : {
								emphasis : {
									show : true,
									formatter : function(param) {
										return param.data[3];
									},
									position : 'top'
								}
							},
							itemStyle : {
								normal : {
									shadowBlur : 10,
									shadowColor : 'rgba(25, 100, 150, 0.5)',
									shadowOffsetY : 5,
									color : new echarts.graphic.RadialGradient(
											0.4, 0.3, 1, [ {
												offset : 0,
												color : 'rgb(129, 227, 238)'
											}, {
												offset : 1,
												color : 'rgb(25, 183, 207)'
											} ])
								}
							}
						} ]
			};

			if (option && typeof option === "object") {
				myChart.setOption(option, true);
				creatH1();
				creatH2();
			}

			function creatH1() {
				var tempTr = "";
				$.each(data[0], function(m, n) {
					tempTr += '<tr><td>' + n[0] + '</td><td>' + n[1]
							+ '%</td></tr>'
				});
				$("#highRiskTableCont").html(tempTr);
			}
			function creatH2() {
				var tempTr = "";
				$.each(data[1], function(m, n) {
					tempTr += '<tr><td>' + n[0] + '</td><td>' + n[1]
							+ '%</td></tr>'
				});
				$("#highRiskTableCont2").html(tempTr);
			}
		</script>
</body>

</html>