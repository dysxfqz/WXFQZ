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
<title>2012~2016各行业税收流失金额趋势图</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>2012~2016各行业税收流失金额趋势图</h1>
		<a href="${ctxPath}/v1/html/modelReport/intermediate/list.do"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10" id=container style="height:500px;"></div>
<div class="col-xs-10">
<div class="table-header" style="margin-top:30px;">2012~2016各行业税收流失金额趋势图</div>
	<table class="table table-striped table-bordered table-hover">
		<thead>
			<tr>
			    <th>行业</th><th>年度</th><th>流失金额</th>
			</tr>
		</thead>
		<tr>
		    <td>行业1</td><td>2012</td><td>1200000</td>
		    </tr>
		    <tr>
		    <td>行业1</td><td>2013</td><td>1320000</td>
		    </tr><tr>
		    <td>行业1</td><td>2014</td><td>1010000</td>
		     </tr><tr>
		    <td>行业1</td><td>2015</td><td>1340000</td>
		     </tr><tr>
		    <td>行业1</td><td>2016</td><td>900000</td>
		</tr>
		<tr >
		    <td>行业2</td><td>2012</td><td>2200000</td>
		     </tr><tr>
		    <td>行业2</td><td>2013</td><td>1820000</td>
		     </tr><tr>
		    <td>行业2</td><td>2014</td><td>1910000</td>
		     </tr><tr>
		    <td>行业2</td><td>2015</td><td>2340000</td>
		     </tr><tr>
		    <td>行业2</td><td>2016</td><td>2900000</td>
		    
		</tr>
		<tr >
		    <td>行业3</td><td>2012</td><td>1500000</td>
		     </tr><tr>
		    <td>行业3</td><td>2013</td><td>2320000</td>
		     </tr><tr>
		    <td>行业3</td><td>2014</td><td>2010000</td>
		     </tr><tr>
		    <td>行业3</td><td>2015</td><td>1540000</td>
		     </tr><tr>
		    <td>行业3</td><td>2016</td><td>1900000</td>
		</tr>
		<tr >
		    <td>行业4</td><td>2012</td><td>3200000</td>
		     </tr><tr>
		    <td>行业4</td><td>2013</td><td>3320000</td>
		     </tr><tr>
		    <td>行业4</td><td>2014</td><td>3010000</td>
		     </tr><tr>
		    <td>行业4</td><td>2015</td><td>3340000</td>
		     </tr><tr>
		    <td>行业4</td><td>2016</td><td>3900000</td>
		</tr>
		<tr >
		    <td>行业5</td><td>2012</td><td>8200000</td>
		     </tr><tr>
		    <td>行业5</td><td>2013</td><td>9320000</td>
		     </tr><tr>
		    <td>行业5</td><td>2014</td><td>9010000</td>
		     </tr><tr>
		    <td>行业5</td><td>2015</td><td>9340000</td>
		     </tr><tr>
		    <td>行业5</td><td>2016</td><td>12900000</td>
		</tr>
	</table>
</div>
<script src="${ctxPath}/static/source/js/echarts.js"></script>
	<script>
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	
	
	
	option = {
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['行业1','行业2','行业3','行业4','行业5']
		    },
		    toolbox: {
		        feature: {
		            saveAsImage: {}
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : ['2012','2013','2014','2015','2016']
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'行业1',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[1200000, 1320000, 1010000, 1340000, 900000]
		        },
		        {
		            name:'行业2',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[2200000, 1820000, 1910000, 2340000, 2900000]
		        },
		        {
		            name:'行业3',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[1500000, 2320000, 2010000, 1540000, 1900000]
		        },
		        {
		            name:'行业4',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[3200000, 3320000, 3010000, 3340000, 3900000]
		        },
		        {
		            name:'行业5',
		            type:'line',
		            stack: '总量',
		            label: {
		                normal: {
		                    show: true,
		                    position: 'top'
		                }
		            },
		            areaStyle: {normal: {}},
		            data:[8200000, 9320000, 9010000, 9340000, 12900000]
		        }
		    ]
		};
	
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	</script>
	
	
</body>

</html>