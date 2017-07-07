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
<title>北京地区各区营业收入状况</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
<style type="text/css">
table.hovertable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #999999;
    border-collapse: collapse;
    margin-bottom:3%;
    margin-left:2%;
}
table.hovertable th {
    background-color:#c3dde0;
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
table.hovertable tr {
    background-color:#d4e3e5;
}
table.hovertable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
</style>
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>北京地区各区营业收入状况</h1>
		<a href="${ctxPath}/v1/html/modelReport/macroscopic/list.do" class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10" id=container style="height:500px;"></div>

<script src="${ctxPath}/static/source/js/echarts.js"></script>
	<script>
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	//从这里开始粘
option = {
    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '5%',
        right: '4%',
        bottom: '25%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['北京市地方税务局第二直属...', '北京市地方税务局开发区分...', '北京市地方税务局燕山分局...', '昌平区', '朝阳区', '大兴区', '东城区','房山区', '丰台区', '海淀区', '怀柔区', '门头沟区', '密云区', '平谷区','石景山区','通州区','西城区','延庆区'],
            axisTick: {
                alignWithLabel: true
            },
            axisLabel: {
	               interval: 0,
	               rotate: 45,
	         },
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'营业收入',
            type:'bar',
            barWidth: '60%',
            data:[200000, 3600000000, 240000, 17100000000, 36000000000,22000000000, 11000000000,24000000000, 24700000000, 16200000000, 6130000000, 27000000000, 10400000000, 12528000000,2000450000, 20000000000, 32510000000, 1000000000]
        }
    ]
};
	
	//到这里结束
	
	
	
	
	
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	</script>
	<!-- Table goes in the document BODY -->
<div class="col-xs-10" style="min-height: 500px;margin-top:20px">
<div class="table-header">北京地区各区营业收入状况</div>
<table
	class="resultTable table table-info table-striped table-bordered table-hover">
	<thead>
<tr>
   <th>地区</th><td>北京市地方税务局第二直属...</td><td>北京市地方税务局开发区分...</td><td>北京市地方税务局燕山分局...</td><td>昌平区</td><td>朝阳区</td><td>大兴区</td> <td>东城区</td><td>房山区</td><td>丰台区</td>
</tr>
</thead>
<tbody>
<tr>
   <th>金额</th><td>200000</td><td>3600000000</td><td>240000</td><td>17100000000</td><td>36000000000</td><td>22000000000</td> <td>11000000000</td><td>24000000000</td><td>24700000000</td>
</tr>
<tr>
   <th>地区</th><td>海淀区</td><td>怀柔区</td><td>门头沟区</td><td>密云区</td><td>平谷区</td> <td>石景山区</td><td>通州区</td><td>西城区</td> <td>延庆区</td>
</tr>
<tr>
   <th>金额</th><td>16200000000</td><td>6130000000</td><td>27000000000</td><td>10400000000</td><td>12528000000</td> <td>2000450000</td><td>20000000000</td><td>32510000000</td> <td>1000000000</td>
</tr>
</tbody>
</table>
</div>
</body>



</html>