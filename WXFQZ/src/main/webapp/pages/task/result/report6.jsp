<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>企业期间费用以及疑点科目指向</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<style>
	table th,table td{ white-space: nowrap !important;}
</style>
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
				<h1>一户式报告</h1>
				<span class="detailGoBack">返回</span>
			</div>
			<div>
				<ul class="comLabel">
					<li><span class="comLeft">纳税人名称：</span>${companyInfoMap.NSRMC}</li>
					<li><span class="comLeft">企业信用代码：</span>******</li>
					<!--${companyInfoMap.TAXID}  -->
				</ul>
			</div>
			<hr>
		<div class="cankao"></div>
		<ul class="titlebtn">
			<li><a href="${ctxPath}/v1/html/task/result/report1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业基本信息</a></li>
			<li><a href="${ctxPath}/v1/html/task/result/report2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税遵从风险报告摘要</a></li>
			<li><a href="${ctxPath}/v1/html/task/result/report3.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税申报及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/task/result/report4.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业收入及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/task/result/report5.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业成本支出及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/task/result/report6.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业期间费用及疑点科目指向</a></li>
		</ul>
			<div  class="zongTitle tableTitle">企业期间费用及疑点科目指向</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true"></i></div>
		<div class="tableContent" style="width:100%;max-width:none;overflow-x: auto;">
			<table class="table table-info table-striped table-bordered table-hover">
				<tr class="center">
					<td rowspan="3">行次</td>
					<td rowspan="3">项目</td>
					<td colspan="6">销售费用</td>
					<td colspan="6">管理费用</td>
					<td colspan="6">财务费用</td>
				</tr>
				<tr class="center">
					<td colspan="3">销售费用</td>
					<td colspan="3">其中：境外支付</td>
					<td colspan="3">管理费用</td>
					<td colspan="3">其中：境外支付</td>
					<td colspan="3">财务费用</td>
					<td colspan="3">其中：境外支付</td>
				</tr>
				<tr class="center">
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
					<td>填报值</td>
					<td>预测值</td>
					<td>差异值</td>
				</tr>
				
				<tr>
					<td>1</td>
					<td>一、职工薪酬</td>
					<td  class="textRight">${companyCostMap.ZGXCXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZGXCXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZGXCXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.ZGXCGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZGXCGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZGXCGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>2</td>
					<td>二、劳务费</td>
					<td  class="textRight">${companyCostMap.LWFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.LWFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.LWFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.LWFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.LWFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.LWFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.LWFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>3</td>
					<td>三、咨询顾问费</td>
					<td  class="textRight">${companyCostMap.ZXGWFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZXGWFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZXGWFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.ZXGWFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZXGWFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZXGWFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.ZXGWFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>4</td>
					<td>四、业务招待费</td>
					<td  class="textRight">${companyCostMap.YWZDFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.YWZDFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.YWZDFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.YWZDFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.YWZDFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.YWZDFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>5</td>
					<td>五、广告费和业务宣传费</td>
					<td  class="textRight">${companyCostMap.GGXCFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.GGXCFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.GGXCFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.GGXCFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.GGXCFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.GGXCFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>6</td>
					<td>六、佣金和手续费</td>
					<td  class="textRight">${companyCostMap.YJSXFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.YJSXFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF1_CE}</td>
					<td  class="textRight">${companyCostMap.YJSXFCWFY_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFCWFY_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFCWFY_CE}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF2_TB}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF2_YC}</td>
					<td  class="textRight">${companyCostMap.YJSXFJWZF2_CE}</td>
				</tr>
				<tr>
					<td>7</td>
					<td>七、资产折旧摊销费</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZCZJTXFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>8</td>
					<td>八、财产损耗、盘亏及毁损损失</td>
					<td  class="textRight">${companyCostMap.CCSHPKXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.CCSHPKXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.CCSHPKXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.CCSHPKGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.CCSHPKGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.CCSHPKGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>9</td>
					<td>九、办公费</td>
					<td  class="textRight">${companyCostMap.BGFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.BGFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.BGFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.BGFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.BGFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.BGFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>10</td>
					<td>十、董事会费</td>
					<td  class="textRight">${companyCostMap.DSHFXSFY_TB }</td>
					<td  class="textRight">${companyCostMap.DSHFXSFY_YC }</td>
					<td  class="textRight">${companyCostMap.DSHFXSFY_CE }</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.DSHFGLFY_TB }</td>
					<td  class="textRight">${companyCostMap.DSHFGLFY_YC }</td>
					<td  class="textRight">${companyCostMap.DSHFGLFY_CE }</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>11</td>
					<td>十一、租赁费</td>
					<td  class="textRight">${companyCostMap.ZLFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZLFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZLFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.ZLFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.ZLFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.ZLFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.ZLFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>12</td>
					<td>十二、诉讼费</td>
					<td  class="textRight">${companyCostMap.SSFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.SSFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.SSFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.SSFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.SSFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.SSFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>13</td>
					<td>十三、差旅费</td>
					<td  class="textRight">${companyCostMap.CLFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.CLFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.CLFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.CLFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.CLFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.CLFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>14</td>
					<td>十四、保险费</td>
					<td  class="textRight">${companyCostMap.BXFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.BXFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.BXFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.BXFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.BXFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.BXFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>15</td>
					<td>十五、运输、仓储费</td>
					<td  class="textRight">${companyCostMap.YSCCFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.YSCCFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.YSCCFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.YSCCFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.YSCCFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.YSCCFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.YSCCFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>16</td>
					<td>十六、修理费</td>
					<td  class="textRight">${companyCostMap.XLFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.XLFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.XLFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.XLFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.XLFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.XLFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.XLFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>17</td>
					<td>十七、包装费</td>
					<td  class="textRight">${companyCostMap.BZFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.BZFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.BZFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.BZFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.BZFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.BZFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>18</td>
					<td>十八、技术转让费</td>
					<td  class="textRight">${companyCostMap.JSZRFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.JSZRFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.JSZRFXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.JSZRFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.JSZRFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.JSZRFGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.JSZRFJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>19</td>
					<td>十九、研究费用</td>
					<td  class="textRight">${companyCostMap.YJFYXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.YJFYXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.YJFYXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.YJFYGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.YJFYGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.YJFYGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.YJFYJWZF1_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>20</td>
					<td>二十、各项税费</td>
					<td  class="textRight">${companyCostMap.GXSFXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.GXSFXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.GXSFXSFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.GXSFGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.GXSFGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.GXSFGLFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>21</td>
					<td>二十一、利息收支</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.LXSZCWFY_TB}</td>
					<td  class="textRight">${companyCostMap.LXSZCWFY_YC}</td>
					<td  class="textRight">${companyCostMap.LXSZCWFY_CE}</td>
					<td  class="textRight">${companyCostMap.LXSZJWZF2_TB}</td>
					<td  class="textRight">${companyCostMap.LXSZJWZF2_YC}</td>
					<td  class="textRight">${companyCostMap.LXSZJWZF2_CE}</td>
				</tr>
				<tr>
					<td>22</td>
					<td>二十二、汇兑差额</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.HDCECWFY_TB}</td>
					<td  class="textRight">${companyCostMap.HDCECWFY_YC}</td>
					<td  class="textRight">${companyCostMap.HDCECWFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>23</td>
					<td>二十三、现金折扣</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="textRight">${companyCostMap.XJZKCWFY_TB}</td>
					<td  class="textRight">${companyCostMap.XJZKCWFY_YC}</td>
					<td  class="textRight">${companyCostMap.XJZKCWFY_CE}</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
					<td  class="center">*</td>
				</tr>
				<tr>
					<td>24</td>
					<td>二十四、其他</td>
					<td  class="textRight">${companyCostMap.QTXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.QTXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.QTXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.QTJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.QTJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.QTJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.QTGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.QTGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.QTGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.QTJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.QTJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.QTJWZF1_CE}</td>
					<td  class="textRight">${companyCostMap.QTCWFY_TB}</td>
					<td  class="textRight">${companyCostMap.QTCWFY_YC}</td>
					<td  class="textRight">${companyCostMap.QTCWFY_CE}</td>
					<td  class="textRight">${companyCostMap.QTJWZF2_TB}</td>
					<td  class="textRight">${companyCostMap.QTJWZF2_YC}</td>
					<td  class="textRight">${companyCostMap.QTJWZF2_CE}</td>
				</tr>
				<tr>
					<td>25</td>
					<td>合计(1+2+3+…24)</td>
					<td  class="textRight">${companyCostMap.HJXSFY_TB}</td>
					<td  class="textRight">${companyCostMap.HJXSFY_YC}</td>
					<td  class="textRight">${companyCostMap.HJXSFY_CE}</td>
					<td  class="textRight">${companyCostMap.HJJWZF_TB}</td>
					<td  class="textRight">${companyCostMap.HJJWZF_YC}</td>
					<td  class="textRight">${companyCostMap.HJJWZF_CE}</td>
					<td  class="textRight">${companyCostMap.HJGLFY_TB}</td>
					<td  class="textRight">${companyCostMap.HJGLFY_YC}</td>
					<td  class="textRight">${companyCostMap.HJGLFY_CE}</td>
					<td  class="textRight">${companyCostMap.HJJWZF1_TB}</td>
					<td  class="textRight">${companyCostMap.HJJWZF1_YC}</td>
					<td  class="textRight">${companyCostMap.HJJWZF1_CE}</td>
					<td  class="textRight">${companyCostMap.HJCWFY_TB}</td>
					<td  class="textRight">${companyCostMap.HJCWFY_YC}</td>
					<td  class="textRight">${companyCostMap.HJCWFY_CE}</td>
					<td  class="textRight">${companyCostMap.HJJWZF2_TB}</td>
					<td  class="textRight">${companyCostMap.HJJWZF2_YC}</td>
					<td  class="textRight">${companyCostMap.HJJWZF2_CE}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<script>
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/task/result/taxpayerList.do?TASKID="+zs_getUrlParameter("TASKID");
});
window.onscroll=function(){
	if($(document).scrollTop()>=$(".cankao").offset().top){
		$(".titlebtn").addClass("fixed-table-tool");
	}else{
		$(".titlebtn").removeClass("fixed-table-tool");
	}
}
</script>
</body>

</html>
