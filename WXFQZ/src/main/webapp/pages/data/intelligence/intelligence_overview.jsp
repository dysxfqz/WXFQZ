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
<title>数据概览</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>数据概览</h1>
			<a href="${ctxPath}/v1/html/data/sampleData/cleverImport/list.do" class="detailGoBack">返回</a>
		</div>
		<div class="row" style="margin-bottom:20px;margin-bottom: 20px; border: 1px solid #ccc; padding-top: 15px; padding-bottom: 15px;border-radius: 5px; background: #f9f9f9;">
			<div style="float:left">
				<c:forEach items="${dataList}" var="p" begin="0" end="0" varStatus='status'>
				<div><span class="dataViewTitle">名称:</span>${p.MC }</div>
				<div><span class="dataViewTitle">数据源编号:</span>${p.SJYBH }</div>
				<div>
					<span><span class="dataViewTitle">总户数:</span>${p.ZHS }</span>
				</div>
				<div>
					<span><span class="dataViewTitle">总指标数:</span>${p.ZZBS }</span>
				</div>
				</c:forEach>
			</div>
			<div class="col-xs-12 col-sm-9" id=container style="height: 500px;margin-left:40px;"></div>
		</div>
		<div class="resultContent">
				<div class="right_content">
					 <div id="talbeContentDiv">
						<div id="economicsDiv">
							<table class="table table-striped table-bordered table-hover" id="dataMsg">
								<thead>
									<tr>
										<th>No.</th>
										<th>数据库名</th>
										<th>表名</th>
										<th>户数</th>
										<th>指标数</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${dataList}" var="p" varStatus='status'>
										<tr>
											<td>${status.index+1 }</td>
											<td>${p.SJKM }</td>
											<td>${p.BM }</td>
											<td>${p.HS }</td>
											<td>${p.ZBS }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
		</div>
	</div>
	<script>
		var oTable1 =$('#dataMsg').DataTable( {
				bStateSave: false,
				bAutoWidth: false,
				"aaSorting": [],
				"aoColumnDefs": [
					{
					 sDefaultContent: '',
					 aTargets: [ '_all' ]
					  }
					],
		    } );
		
	</script>
	<script src="${ctxPath}/static/source/js/echarts.js"></script>
	<script>
		var dom = document.getElementById("container");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;

		option = {
			tooltip : {
				trigger : 'item',
				backgroundColor : 'rgba(0,0,250,0.2)'
			},
			legend : {
				orient: 'vertical',
			    left: 'right',
				data : (function() {
					var list = [];
					for (var i = 1; i <= 28; i++) {
						list.push(i + 2000 + '');
					}
					return list;
				})()
			},
			visualMap : {
				color : [ 'red', 'yellow' ]
			},
			radar : {
				indicator : [ {
					text : '税务登记信息',
					max : 400
				}, {
					text : '申报信息',
					max : 400
				}, {
					text : '征收信息',
					max : 400
				}, {
					text : '财务信息',
					max : 400
				}, {
					text : '发票信息',
					max : 400
				} ]
			},
			series : (function() {
				var series = [];
				for (var i = 1; i <= 28; i++) {
					series.push({
						name : '浏览器（数据纯属虚构）',
						type : 'radar',
						symbol : 'none',
						itemStyle : {
							normal : {
								lineStyle : {
									width : 1
								}
							},
							emphasis : {
								areaStyle : {
									color : 'rgba(0,250,0,0.3)'
								}
							}
						},
						data : [ {
							value : [ (40 - i) * 10, (38 - i) * 4 + 60,
									i * 5 + 10, i * 9, i * i / 2 ],
							name : i + 2000 + ''
						} ]
					});
				}
				return series;
			})()
		};

		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}
	</script>
</body>

</html>