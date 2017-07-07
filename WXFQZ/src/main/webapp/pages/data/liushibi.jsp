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
<title>流失比</title>
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
    margin-left:5%;
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
		<h1>流失比</h1>
		<a href="${ctxPath}/v1/html/modelReport/macroscopic/list.do"
			class="detailGoBack">返回</a>
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
		title: {
	        text: '流失比',
	        left: 'center',
	        top: '2%'
	    },

    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '8%',
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
            name:'流失比',
            type:'bar',
            barWidth: '60%',
            data:[0.000, 0.420, 0.501, 0.394, 0.420,0.410, 0.380, 0.450, 0.440, 0.440, 0.452, 0.440, 0.430, 0.460,0.320, 0.400, 0.390, 0.452]
        }
    ]
};
	
	//到这里结束
	
	
	
	
	
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	</script>
	<!-- Table goes in the document BODY -->
<table class="hovertable">
<tr>
   <th>地区</th><td>北京市地方税务局第二直属...</td><td>北京市地方税务局开发区分...</td><td>北京市地方税务局燕山分局...</td><td>昌平区</td><td>朝阳区</td><td>大兴区</td> <td>东城区</td><td>房山区</td><td>丰台区</td>
</tr>
<tr>
   <th>金额</th><td>0.000</td><td>0.420</td><td>0.501</td><td>0.394</td><td>0.420</td><td>0.410</td> <td>0.380</td><td>0.450</td><td>0.440</td>
</tr>
<tr>
   <th>地区</th><td>海淀区</td><td>怀柔区</td><td>门头沟区</td><td>密云区</td><td>平谷区</td> <td>石景山区</td><td>通州区</td><td>西城区</td> <td>延庆区</td>
</tr>
<tr>
   <th>金额</th><td>0.440</td><td>0.452</td><td>0.440</td><td>0.430</td><td>0.460</td> <td>0.320</td><td>0.400</td><td>0.390</td> <td>0.452</td>
</tr>
</table>
</body>



</html>