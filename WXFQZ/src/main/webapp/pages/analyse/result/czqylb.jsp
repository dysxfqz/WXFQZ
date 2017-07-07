<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>参照企业列表</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>参照企业列表</h1>
		<a href="${ctxPath}/v1/html/analyse/result/report2.do?TASKID=${TASKID}&xh=${xh}&NSRMC=${NSRMC}"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10" id=container style="height:500px;margin-top:50px;"></div>
<div class="col-xs-10">
	<div style="margin-top:20px;" class="table-header">参照企业列表</div>
	<table class="resultTable table table-info table-striped table-bordered table-hover">
		<tbody id="highRiskTableCont">
			<tr>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>	
<input type="hidden" value="${czqylbArray}" id="czqylbArray">	
	
<script src="${ctxPath}/static/source/js/echarts.js"></script>
 <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
	<script>
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;

	myChart.showLoading();
	$.get('${ctxPath}/pages/data/les-miserables.gexf', function (xml) {
	    myChart.hideLoading();

	    var czqylbArr = $("#czqylbArray").val().split(",");
	    var graph = echarts.dataTool.gexf.parse(xml);
	    var categories = [];
	    for (var i = 0; i < czqylbArr.length; i++) {
	        categories[i] = {
	            name: ''
	        };
	    }
	    graph.nodes.forEach(function (node) {
	        node.itemStyle = null;
	        node.symbolSize = 10;
	        node.value = node.symbolSize;
	        node.category = node.attributes.modularity_class;
	        // Use random x, y
	        node.x = node.y = null;
	        node.draggable = true;
	    });
	    option = {
	        legend: [{
	            data: categories.map(function (a) {
	                return a.name;
	            }),
	            x: 'center'
	        }],
	        animation: false,
	        series : [
	            {
	                name: '内蒙地区煤炭业关联关系图',
	                type: 'graph',
	                layout: 'force',
	                data: graph.nodes,
	                links: graph.links,
	                categories: categories,
	                roam: true,
	                label: {
	                    normal: {
	                        position: 'right'
	                    }
	                },
	                force: {
	                    repulsion: 100
	                }
	            }
	        ]
	    };

	    myChart.setOption(option);
	}, 'xml');
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	}
	
	function creatHighRisk(){
		var czqylbArray = $("#czqylbArray").val().split(",");
		var tableContent = '';
		$.each(czqylbArray,function(i,p){
			tableContent+='<tr><td>'+i+'</td><td style="text-align:right">'+p+'</td></tr>';
		});
		$("#highRiskTableCont").html(tableContent);
	}
	creatHighRisk(); 
	
	</script>
</body>

</html>