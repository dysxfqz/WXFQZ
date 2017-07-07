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
<title>广东地区各行业税负对比图</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
<style type="text/css">
table.hovertable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #999999;
    border-collapse: collapse;
    margin-left: 5%;
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
		<h1>广东地区各行业税负对比图</h1>
		<a href="${ctxPath}/v1/html/modelReport/intermediate/list.do"
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
app.title = '广东地区各行业税负对比图';

option = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['行业1','行业2','行业3','行业4','行业5','行业6']
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
            data : ['韶关市','湛江市','珠海市','汕头市','广州市','东莞市','佛山市']
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
            type:'bar',
            data:[320, 332, 301, 334, 390, 330, 320]
        },
        {
            name:'行业2',
            type:'bar',
            stack: '行业2',
            data:[120, 132, 101, 134, 90, 230, 210]
        },
        {
            name:'行业3',
            type:'bar',
            stack: '行业3',
            data:[220, 182, 191, 234, 290, 330, 310]
        },
        {
            name:'行业4',
            type:'bar',
            stack: '行业4',
            data:[150, 232, 201, 154, 190, 330, 410]
        },
        {
            name:'行业5',
            type:'bar',
            data:[862, 1018, 964, 1026, 1679, 1600, 1570],
            markLine : {
                lineStyle: {
                    normal: {
                        type: 'dashed'
                    }
                },
                data : [
                    [{type : 'min'}, {type : 'max'}]
                ]
            }
        },
        {
            name:'行业6',
            type:'bar',
            barWidth : 5,
            stack: '行业6',
            data:[620, 732, 701, 734, 1090, 1130, 1120]
        },
    ]
};

	
	//到这里结束
	
	
	
	
	
	
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	</script>
	<!-- Table goes in the document BODY -->
	<div class="col-xs-10">
	<div style="margin-top:20px;" class="table-header">广东地区各行业税负对比图</div>
<table class="resultTable table table-info table-striped table-bordered table-hover">
<thead>
<tr>
   <th>行业/地区</th><th>旅游业</th><th>餐饮业</th><th>广告业</th><th>金融业</th><th>IT业</th><th>制造业</th>
</tr>
</thead>
<tbody>
<tr>
   <th>韶关市</th><td>320</td><td>120</td><td>220</td><td>150</td><td>862</td><td>620</td>
</tr>
<tr>
   <th>湛江市</th><td>332</td><td>132</td><td>182</td><td>232</td><td>1018</td><td>732</td>
</tr>
<tr>
   <th>珠海市</th><td>301</td><td>101</td><td>191</td><td>201</td><td>964</td> <td>701</td>
</tr>
<tr>
   <th>汕头市</th><td>334</td><td>134</td><td>234</td><td>154</td><td>1026</td> <td>734</td>
</tr>
<tr>
   <th>广州市</th><td>390</td><td>90</td><td>290</td><td>190</td><td>1679</td> <td>1090</td>
</tr>
<tr>
   <th>东莞市</th><td>330</td><td>230</td><td>330</td><td>330</td><td>1600</td> <td>1130</td>
</tr>
<tr>
   <th>佛山市</th><td>320</td><td>210</td><td>310</td><td>410</td><td>1570</td> <td>1120</td>
</tr>
</tbody>
</table>
</div>
</body>



</html>