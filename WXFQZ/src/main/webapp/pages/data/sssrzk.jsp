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
<title>北京地区税收收入状况</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
<style type="text/css">
table.hovertable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #999999;
    border-collapse: collapse;
    margin-left: 2%;
    margin-bottom: 2%;
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
		<h1>北京地区税收收入状况</h1>
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
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['总户数','入库额']
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
            data : ['北京市地方税务局第二直属...', '北京市地方税务局开发区分...', '北京市地方税务局燕山分局...', '昌平区', '朝阳区', '大兴区', '东城区','房山区', '丰台区', '海淀区', '怀柔区', '门头沟区', '密云区', '平谷区','石景山区','通州区','西城区','延庆区'],
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'总户数',
            type:'bar',
            stack: '总户数',
            data:[15, 40, 10, 147, 401,190, 147,161, 159, 261, 297, 130, 263, 210,240, 53, 209, 20]
        },
        {
            name:'入库额',
            type:'bar',
            stack: '入库额',
            data:[20000000, 140000000, 500000000, 1470000000, 400000000,190000000, 600000000,1000000000, 800000000, 200000000, 130000000, 480000000, 280000000, 252800000,128045000, 280000000, 2510000000, 180000000]
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
		<div class="table-header">北京地区税收收入状况</div>
		<table
			class="resultTable table table-info table-striped table-bordered table-hover">
			<thead>
<tr>
   <th>数据/区域</th><td>北京市地方税务局第二直属...</td><td>北京市地方税务局开发区分...</td><td>北京市地方税务局燕山分局...</td><td>昌平区</td><td>朝阳区</td><td>大兴区</td> <td>东城区</td><td>房山区</td><td>丰台区</td>
</tr>
</thead>
<tbody>
<tr>
   <th>户数</th><td>15</td><td>40</td><td>10</td><td>147</td><td>401</td><td>190</td> <td>147</td><td>161</td><td>159</td>
</tr>
<tr>
   <th>金额</th><td>20000000</td><td>140000000</td><td>500000000</td><td>1470000000</td><td>400000000</td><td>190000000</td> <td>600000000</td><td>1000000000</td><td>800000000</td>
</tr>
<tr>
   <th>数据/区域</th><td>海淀区</td><td>怀柔区</td><td>门头沟区</td><td>密云区</td><td>平谷区</td> <td>石景山区</td><td>通州区</td><td>西城区</td> <td>延庆区</td>
</tr>
<tr>
   <th>户数</th><td>261</td><td>297</td><td>130</td><td>263</td><td>210</td> <td>240</td><td>53</td><td>209</td> <td>20</td>
</tr>
<tr>
   <th>金额</th><td>200000000</td><td>130000000</td><td>480000000</td><td>280000000</td><td>252800000</td> <td>128045000</td><td>280000000</td><td>2510000000</td> <td>180000000</td>
</tr>
</tbody>
</table>
</div>
</body>



</html>