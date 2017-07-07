<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>一般企业成本支出以及疑点科目指向</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
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
		<div class="tableContent">
			<div  class="zongTitle tableTitle">企业成本支出及疑点科目指向</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true"></i></div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr class="center">
					<td>行次</td>
					<td>项目</td>
					<td>填报值</td>
					<td  class="yuceInpo">预测值</td>
					<td  class="chayiInpo">差异值</td>
				</tr>
				<tr>
					<td class="center" >1</td>
					<td>一、营业成本（2+9）</td>
					<td class="textRight">${companyExpendMap.YYCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.YYCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >2</td>
					<td class="tablesec">（一）主营业务成本（3+5+6+7+8）</td>
					<td class="textRight">${companyExpendMap.ZYYWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.ZYYWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >3</td>
					<td class="tableThir">1. 销售商品成本</td>
					<td class="textRight">${companyExpendMap.XSSPCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.XSSPCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.XSSPCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >4</td>
					<td class="tableFour">其中:非货币性资产交换成本</td>
					<td class="textRight">${companyExpendMap.ZYYWCBFHBXZCJHCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCBFHBXZCJHCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.ZYYWCBFHBXZCJHCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >5</td>
					<td class="tableThir">2. 提供劳务成本</td>
					<td class="textRight">${companyExpendMap.TGLWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.TGLWCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.TGLWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >6</td>
					<td class="tableThir">3. 建造合同成本</td>
					<td class="textRight">${companyExpendMap.JZHTCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.JZHTCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.JZHTCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >7</td>
					<td class="tableThir">4. 让渡资产使用权成本</td>
					<td class="textRight">${companyExpendMap.RDZCSYQCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.RDZCSYQCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.RDZCSYQCB_CE}</td>
				</tr>
				<tr>
					<td class="center">8</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyExpendMap.ZYYWCBQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCBQT_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.ZYYWCBQT_CE}</td>
				</tr>
				<tr>
					<td class="center" >9</td>
					<td class="tablesec">（二）其他业务成本（10+12+13+14+15）</td>
					<td class="textRight">${companyExpendMap.QTYWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.QTYWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >10</td>
					<td class="tableThir">1. 材料销售成本</td>
					<td class="textRight">${companyExpendMap.CLXSCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CLXSCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.CLXSCB_CE}</td>
				</tr>
				
				<tr>
					<td class="center" >11</td>
					<td class="tableFour">其中:非货币性资产交换成本</td>
					<td class="textRight">${companyExpendMap.QTYWCBFHBXZCJHCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCBFHBXZCJHCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.QTYWCBFHBXZCJHCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >12</td>
					<td class="tableThir">2. 出租固定资产成本</td>
					<td class="textRight">${companyExpendMap.CZGDZCCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CZGDZCCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.CZGDZCCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >13</td>
					<td class="tableThir">3. 出租无形资产成本</td>
					<td class="textRight">${companyExpendMap.CZWXZCCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CZWXZCCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.CZWXZCCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >14</td>
					<td class="tableThir">4. 包装物出租成本</td>
					<td class="textRight">${companyExpendMap.BZWCZCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.BZWCZCB_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.BZWCZCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >15</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyExpendMap.QTYWCBQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCBQT_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.QTYWCBQT_CE}</td>
				</tr>
				<tr>
					<td class="center" >16</td>
					<td>二、营业外支出（17+18+19+20+21+22+23+24+25+26）</td>
					<td class="textRight">${companyExpendMap.YYWZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYWZC_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.YYWZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >17</td>
					<td class="tablesec">（一）非流动资产处置损失</td>
					<td class="textRight">${companyExpendMap.FLDZCCZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FLDZCCZSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.FLDZCCZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >18</td>
					<td class="tablesec">（二）非货币性资产交换损失</td>
					<td class="textRight">${companyExpendMap.FHBXZCJHSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FHBXZCJHSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.FHBXZCJHSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >19</td>
					<td class="tablesec">（三）债务重组损失</td>
					<td class="textRight">${companyExpendMap.ZWCZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZWCZSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.ZWCZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >20</td>
					<td class="tablesec">（四）非常损失</td>
					<td class="textRight">${companyExpendMap.FCSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FCSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.FCSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >21</td>
					<td class="tablesec">（五）捐赠支出</td>
					<td class="textRight">${companyExpendMap.JZZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.JZZC_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.JZZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >22</td>
					<td class="tablesec">（六）赞助支出</td>
					<td class="textRight">${companyExpendMap.ZZZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZZZC_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.ZZZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >23</td>
					<td class="tablesec">（七）罚没支出</td>
					<td class="textRight">${companyExpendMap.FMZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FMZC_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.FMZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >24</td>
					<td class="tablesec">（八）坏账损失</td>
					<td class="textRight">${companyExpendMap.HZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.HZSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.HZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >25</td>
					<td class="tablesec">（九）无法收回的债券股权投资损失</td>
					<td class="textRight">${companyExpendMap.WFSHDZQGQTZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.WFSHDZQGQTZSS_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.WFSHDZQGQTZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >26</td>
					<td class="tablesec">（十）其他</td>
					<td class="textRight">${companyExpendMap.YYWZCQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYWZCQT_YC}</td>
					<td class="textRight chayiInpo">${companyExpendMap.YYWZCQT_CE}</td>
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
