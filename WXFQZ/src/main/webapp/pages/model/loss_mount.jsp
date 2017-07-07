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
<title>流失金额</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>不同类型下的流失额</h1>
		<a href="${ctxPath}/v1/html/modelReport/intermediate/list.do"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10" id=container style="height:500px;"></div>
<div class="col-xs-10">
<div class="table-header" style="margin-top:30px;">不同类型下的流失额</div>
<table class="table table-striped table-bordered table-hover">
		<tr>
		    <th>类型</th><th>流失额</th>
		</tr>
		<tr>
		    <td>股份合作企业</td><td>0</td>
		</tr>
		<tr>
		    <td>中外合资经营企业</td><td>0</td>
		</tr>
		<tr>
		    <td>国有独资公司</td><td>0</td>
		</tr>
		<tr>
		    <td>国有企业</td><td>15%</td>
		</tr>
		<tr>
		    <td>股份有限公司</td><td>10%</td>
		</tr><tr>
		    <td>集体企业</td><td>0</td>
		</tr>
		<tr>
		    <td>其他有限责任公司</td><td>20%</td>
		</tr>
		<tr>
		    <td>其他组织</td><td>0</td>
		</tr>
		<tr>
		    <td>私营股份有限公司</td><td>5%</td>
		</tr>
		<tr>
		    <td>私营有限责任公司</td><td>50%</td>
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
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: ['股份合作企业','中外合资经营企业','国有独资公司','国有企业','股份有限公司','集体企业','其他有限责任公司','其他组织','私营股份有限公司','私营有限责任公司']
		    },
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:0, name:'股份合作企业'},
		                {value:0, name:'中外合资经营企业'},
		                {value:0, name:'国有独资公司'},
		                {value:15, name:'国有企业'},
		                {value:10, name:'股份有限公司'},
		                {value:0, name:'集体企业'},
		                {value:20, name:'其他有限责任公司'},
		                {value:0, name:'其他组织'},
		                {value:5, name:'私营股份有限公司'},
		                {value:50, name:'私营有限责任公司'},
		            ],
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
	</script>
	
	
</body>

</html>