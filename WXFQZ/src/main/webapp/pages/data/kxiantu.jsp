<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>内蒙地区GDP与税收收入发展状况</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
<div class="header smaller lighter blue">
		<h1>内蒙地区GDP与税收收入发展状况</h1>
		<a href="${ctxPath}/v1/html/modelReport/macroscopic/list.do"class="detailGoBack">返回</a>
	</div>
	</div>
	<div class="row">
	<div class="col-xs-10" id=container style="height: 500px;"></div>
	<div class="col-xs-10" style="min-height: 500px;margin-top:20px">
		<div class="table-header">内蒙地区GDP与税收收入发展状况</div>
		<table
			class="resultTable table table-info table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th>时间</th>
					<th>GDP</th>
					<th>税收收入</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>2016-03-23</td>
					<td>80</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-04-01</td>
					<td>60</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-04-19</td>
					<td>70</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-04-27</td>
					<td>19</td>
					<td>80</td>
				</tr>
				
				<tr>
					<td>2016-05-05</td>
					<td>5</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-05-13</td>
					<td>15</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-05-23</td>
					<td>8</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-06-01</td>
					<td>6</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-06-09</td>
					<td>6</td>
					<td>80</td>
				</tr>
				<tr>
					<td>2016-06-17</td>
					<td>6</td>
					<td>80</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script src="${ctxPath}/static/source/js/echarts.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
       <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yaDRGoon5YoRzAAwH781yUgn"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
	<script>
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;

	function splitData(rawData) {
	    var categoryData = [];
	    var values = [];
	    var volumns = [];
	    for (var i = 0; i < rawData.length; i++) {
	        categoryData.push(rawData[i].splice(0, 1)[0]);
	        values.push(rawData[i]);
	        volumns.push(rawData[i][4]);
	    }
	    return {
	        categoryData: categoryData,
	        values: values,
	        volumns: volumns
	    };
	}

	function calculateMA(dayCount, data) {
	    var result = [];
	    for (var i = 0, len = data.values.length; i < len; i++) {
	        if (i < dayCount) {
	            result.push('-');
	            continue;
	        }
	        var sum = 0;
	        for (var j = 0; j < dayCount; j++) {
	            sum += data.values[i - j][1];
	        }
	        result.push(+(sum / dayCount).toFixed(3));
	    }
	    return result;
	}

	$.get('${ctxPath}/pages/data/stock-DJI.json', function (rawData) {

	    var data = splitData(rawData);

	    myChart.setOption(option = {
	        backgroundColor: '#eee',
	        animation: false,
	        legend: {
	            bottom: 10,
	            left: 'center',
	            data: ['Dow-Jones index', 'GDP', '税收收入']
	        },
	        tooltip: {
	            trigger: 'axis',
	            axisPointer: {
	                type: 'line'
	            }
	        },
	        toolbox: {
	            feature: {
	                dataZoom: {
	                    yAxisIndex: false
	                },
	                brush: {
	                    type: ['lineX', 'clear']
	                }
	            }
	        },
	        brush: {
	            xAxisIndex: 'all',
	            brushLink: 'all',
	            outOfBrush: {
	                colorAlpha: 0.1
	            }
	        },
	        grid: [
	            {
	                left: '10%',
	                right: '8%',
	                height: '50%'
	            },
	            {
	                left: '10%',
	                right: '8%',
	                top: '63%',
	                height: '16%'
	            }
	        ],
	        xAxis: [
	            {
	                type: 'category',
	                data: data.categoryData,
	                scale: true,
	                boundaryGap : false,
	                axisLine: {onZero: false},
	                splitLine: {show: false},
	                splitNumber: 20,
	                min: 'dataMin',
	                max: 'dataMax'
	            },
	            {
	                type: 'category',
	                gridIndex: 1,
	                data: data.categoryData,
	                scale: true,
	                boundaryGap : false,
	                axisLine: {onZero: false},
	                axisTick: {show: false},
	                splitLine: {show: false},
	                axisLabel: {show: false},
	                splitNumber: 20,
	                min: 'dataMin',
	                max: 'dataMax'
	            }
	        ],
	        yAxis: [
	            {
	                scale: true,
	                splitArea: {
	                    show: true
	                }
	            },
	            {
	                scale: true,
	                gridIndex: 1,
	                splitNumber: 2,
	                axisLabel: {show: false},
	                axisLine: {show: false},
	                axisTick: {show: false},
	                splitLine: {show: false}
	            }
	        ],
	        dataZoom: [
	            {
	                type: 'inside',
	                xAxisIndex: [0, 1],
	                start: 98,
	                end: 100
	            },
	            {
	                show: true,
	                xAxisIndex: [0, 1],
	                type: 'slider',
	                top: '85%',
	                start: 98,
	                end: 100
	            }
	        ],
	        series: [
	            {
	                name: 'Dow-Jones index',
	                type: 'candlestick',
	                data: data.values,
	                itemStyle: {
	                    normal: {
	                        borderColor: null,
	                        borderColor0: null
	                    }
	                },
	                tooltip: {
	                    formatter: function (param) {
	                        var param = param[0];
	                        return [
	                            'Date: ' + param.name + '<hr size=1 style="margin: 3px 0">',
	                            'Open: ' + param.data[0] + '<br/>',
	                            'Close: ' + param.data[1] + '<br/>',
	                            'Lowest: ' + param.data[2] + '<br/>',
	                            'Highest: ' + param.data[3] + '<br/>'
	                        ].join('');
	                    }
	                }
	            },
	            {
	                name: 'GDP',
	                type: 'line',
	                data: calculateMA(5, data),
	                smooth: true,
	                lineStyle: {
	                    normal: {opacity: 0.5}
	                }
	            },
	            {
	                name: '税收收入',
	                type: 'line',
	                data: calculateMA(10, data),
	                smooth: true,
	                lineStyle: {
	                    normal: {opacity: 0.5}
	                }
	            },
	            {
	                name: 'Volumn',
	                type: 'bar',
	                xAxisIndex: 1,
	                yAxisIndex: 1,
	                data: data.volumns
	            }
	        ]
	    }, true);

	    // myChart.on('brushSelected', renderBrushed);

	    // function renderBrushed(params) {
	    //     var sum = 0;
	    //     var min = Infinity;
	    //     var max = -Infinity;
	    //     var countBySeries = [];
	    //     var brushComponent = params.brushComponents[0];

	    //     var rawIndices = brushComponent.series[0].rawIndices;
	    //     for (var i = 0; i < rawIndices.length; i++) {
	    //         var val = data.values[rawIndices[i]][1];
	    //         sum += val;
	    //         min = Math.min(val, min);
	    //         max = Math.max(val, max);
	    //     }

	    //     panel.innerHTML = [
	    //         '<h3>STATISTICS:</h3>',
	    //         'SUM of open: ' + (sum / rawIndices.length).toFixed(4) + '<br>',
	    //         'MIN of open: ' + min.toFixed(4) + '<br>',
	    //         'MAX of open: ' + max.toFixed(4) + '<br>'
	    //     ].join(' ');
	    // }

	    myChart.dispatchAction({
	        type: 'brush',
	        areas: [
	            {
	                brushType: 'lineX',
	                coordRange: ['2016-06-02', '2016-06-20'],
	                xAxisIndex: 0
	            }
	        ]
	    });
	});
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	</script>
</body>

</html>