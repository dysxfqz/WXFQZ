<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>税收大数据各区块信息密布图</title>
<link rel="stylesheet"
	href="${ctxPath}/static/source/style/tableView.css">
	<style type="text/css">
table.hovertable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#333333;
    border-width: 1px;
    border-color: #999999;
    border-collapse: collapse;
    margin: 0 auto;
    
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
		<h1>税收大数据各区块信息密布图</h1>
		<a href="${ctxPath}/v1/html/modelReport/macroscopic/list.do"
			class="detailGoBack">返回</a>
	</div>
	</div>
	<div class="col-xs-10" id=container style="height: 500px;"></div>

	<script src="${ctxPath}/static/source/js/echarts.js"></script>
	<script>
		var dom = document.getElementById("container");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;

		option = {
			title : {
				text : '税收大数据各区块信息密布图',
				x : 'right',
				y : 'bottom'
			},
			tooltip : {
				trigger : 'item',
				backgroundColor : 'rgba(0,0,250,0.2)'
			},
			legend : {
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
		<!-- Table goes in the document BODY -->
<table class="hovertable">
<tr>
   <th>年度</th><th>税务登记信息</th><th>申报信息</th><th>征收信息</th><th>财务信息</th><th>发票信息</th>
</tr>
<tr>
   <td>2001</td><td>390</td><td>280</td><td>15</td><td>9</td><td>0.5</td>
</tr>
<tr>
   <td>2002</td><td>380</td><td>204</td><td>20</td><td>18</td><td>2</td>
</tr>
<tr>
   <td>2003</td><td>370</td><td>200</td><td>25</td><td>27</td><td>4.5</td>
</tr>
<tr>
   <td>2004</td><td>360</td><td>196</td><td>30</td><td>36</td><td>8</td>
</tr>
<tr>
   <td>2005</td><td>350</td><td>192</td><td>35</td><td>45</td><td>12.5</td>
</tr>
<tr>
   <td>2006</td><td>340</td><td>188</td><td>40</td><td>54</td><td>18</td>
</tr>
<tr>
   <td>2007</td><td>330</td><td>184</td><td>45</td><td>63</td><td>24.5</td>
</tr>
<tr>
   <td>2008</td><td>320</td><td>180</td><td>50</td><td>72</td><td>32</td>
</tr>
<tr>
   <td>2009</td><td>310</td><td>176</td><td>55</td><td>81</td><td>40.5</td>
</tr>
<tr>
   <td>2010</td><td>300</td><td>172</td><td>60</td><td>90</td><td>50</td>
</tr>
<tr>
   <td>2011</td><td>290</td><td>168</td><td>65</td><td>99</td><td>60.5</td>
</tr>
<tr>
   <td>2012</td><td>280</td><td>164</td><td>70</td><td>108</td><td>72</td>
</tr>
<tr>
   <td>2013</td><td>270</td><td>160</td><td>75</td><td>117</td><td>84.5</td>
</tr>
<tr>
   <td>2014</td><td>260</td><td>156</td><td>80</td><td>126</td><td>98</td>
</tr>
<tr>
   <td>2015</td><td>250</td><td>152</td><td>85</td><td>135</td><td>112.5</td>
</tr>
<tr>
   <td>2016</td><td>240</td><td>148</td><td>90</td><td>144</td><td>128</td>
</tr>
<tr>
   <td>2017</td><td>230</td><td>144</td><td>95</td><td>153</td><td>144.5</td>
</tr>
<tr>
   <td>2018</td><td>220</td><td>140</td><td>100</td><td>162</td><td>162</td>
</tr>
<tr>
   <td>2019</td><td>201</td><td>136</td><td>105</td><td>171</td><td>180.5</td>
</tr>
<tr>
   <td>2020</td><td>200</td><td>132</td><td>110</td><td>180</td><td>200</td>
</tr>
<tr>
   <td>2021</td><td>190</td><td>128</td><td>115</td><td>189</td><td>220.5</td>
</tr>
<tr>
   <td>2022</td><td>180</td><td>124</td><td>120</td><td>198</td><td>242</td>
</tr>
<tr>
   <td>2023</td><td>170</td><td>120</td><td>125</td><td>207</td><td>264.5</td>
</tr>
<tr>
   <td>2024</td><td>160</td><td>116</td><td>130</td><td>216</td><td>288</td>
</tr>
<tr>
   <td>2025</td><td>150</td><td>112</td><td>135</td><td>225</td><td>312.5</td>
</tr>
<tr>
   <td>2026</td><td>140</td><td>108</td><td>140</td><td>234</td><td>338</td>
</tr>
<tr>
   <td>2027</td><td>130</td><td>104</td><td>145</td><td>243</td><td>364.5</td>
</tr>
<tr>
   <td>2028</td><td>120</td><td>100</td><td>150</td><td>252</td><td>392</td>
</tr>
</table>
</body>

</html>