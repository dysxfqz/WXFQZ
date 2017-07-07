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
<title>企业关联关系网状图</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
<div class="col-xs-12">
	<div class="header smaller lighter blue">
		<h1>企业关联关系网状图</h1>
		<a href="${ctxPath}/v1/html/modelReport/microcosmic/list.do"
			class="detailGoBack">返回</a>
	</div>
	</div>
<div class="col-xs-10" id=container style="height:500px;margin-top:50px;"></div>

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

	    var graph = echarts.dataTool.gexf.parse(xml);
	    var categories = [];
	    for (var i = 0; i < 9; i++) {
	        categories[i] = {
	            name: '煤炭企业' + i
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
	</script>
</body>

</html>