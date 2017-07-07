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
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业基本信息</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税遵从风险报告摘要</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report3.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税申报及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report4.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业收入及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report5.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业成本支出及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report6.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业期间费用及疑点科目指向</a></li>
		</ul>
		<div class="tableContent">
			<div  class="zongTitle tableTitle">企业成本支出及疑点科目指向</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true" onclick="dowExcel('${companyInfoMap.TASKID}','${companyInfoMap.xh}');"></i></div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr class="center">
					<td>行次</td>
					<td>项目</td>
					<td>填报值</td>
					<td  class="yuceInpo">预测值</td>
					<td>差异值</td>
				</tr>
				<tr>
					<td class="center" >1</td>
					<td>一、营业成本（2+9）</td>
					<td class="textRight">${companyExpendMap.YYCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.YYCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.YYCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >2</td>
					<td class="tablesec">（一）主营业务成本（3+5+6+7+8）</td>
					<td class="textRight">${companyExpendMap.ZYYWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.ZYYWCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.ZYYWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >3</td>
					<td class="tableThir">1. 销售商品成本</td>
					<td class="textRight">${companyExpendMap.XSSPCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.XSSPCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.XSSPCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.XSSPCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >4</td>
					<td class="tableFour">其中:非货币性资产交换成本</td>
					<td class="textRight">${companyExpendMap.ZYYWCBFHBXZCJHCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCBFHBXZCJHCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.ZYYWCBFHBXZCJHCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.ZYYWCBFHBXZCJHCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >5</td>
					<td class="tableThir">2. 提供劳务成本</td>
					<td class="textRight">${companyExpendMap.TGLWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.TGLWCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.TGLWCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.TGLWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >6</td>
					<td class="tableThir">3. 建造合同成本</td>
					<td class="textRight">${companyExpendMap.JZHTCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.JZHTCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.JZHTCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.JZHTCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >7</td>
					<td class="tableThir">4. 让渡资产使用权成本</td>
					<td class="textRight">${companyExpendMap.RDZCSYQCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.RDZCSYQCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.RDZCSYQCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.RDZCSYQCB_CE}</td>
				</tr>
				<tr>
					<td class="center">8</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyExpendMap.ZYYWCBQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZYYWCBQT_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.ZYYWCBQT_CE)}'>chayiInpo</c:if>">${companyExpendMap.ZYYWCBQT_CE}</td>
				</tr>
				<tr>
					<td class="center" >9</td>
					<td class="tablesec">（二）其他业务成本（10+12+13+14+15）</td>
					<td class="textRight">${companyExpendMap.QTYWCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.QTYWCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.QTYWCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >10</td>
					<td class="tableThir">1. 材料销售成本</td>
					<td class="textRight">${companyExpendMap.CLXSCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CLXSCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.CLXSCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.CLXSCB_CE}</td>
				</tr>
				
				<tr>
					<td class="center" >11</td>
					<td class="tableFour">其中:非货币性资产交换成本</td>
					<td class="textRight">${companyExpendMap.QTYWCBFHBXZCJHCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCBFHBXZCJHCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.QTYWCBFHBXZCJHCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.QTYWCBFHBXZCJHCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >12</td>
					<td class="tableThir">2. 出租固定资产成本</td>
					<td class="textRight">${companyExpendMap.CZGDZCCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CZGDZCCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.CZGDZCCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.CZGDZCCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >13</td>
					<td class="tableThir">3. 出租无形资产成本</td>
					<td class="textRight">${companyExpendMap.CZWXZCCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.CZWXZCCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.CZWXZCCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.CZWXZCCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >14</td>
					<td class="tableThir">4. 包装物出租成本</td>
					<td class="textRight">${companyExpendMap.BZWCZCB_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.BZWCZCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.BZWCZCB_CE)}'>chayiInpo</c:if>">${companyExpendMap.BZWCZCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >15</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyExpendMap.QTYWCBQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.QTYWCBQT_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.QTYWCBQT_CE)}'>chayiInpo</c:if>">${companyExpendMap.QTYWCBQT_CE}</td>
				</tr>
				<tr>
					<td class="center" >16</td>
					<td>二、营业外支出（17+18+19+20+21+22+23+24+25+26）</td>
					<td class="textRight">${companyExpendMap.YYWZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYWZC_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.YYWZC_CE)}'>chayiInpo</c:if>">${companyExpendMap.YYWZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >17</td>
					<td class="tablesec">（一）非流动资产处置损失</td>
					<td class="textRight">${companyExpendMap.FLDZCCZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FLDZCCZSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.FLDZCCZSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.FLDZCCZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >18</td>
					<td class="tablesec">（二）非货币性资产交换损失</td>
					<td class="textRight">${companyExpendMap.FHBXZCJHSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FHBXZCJHSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.FHBXZCJHSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.FHBXZCJHSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >19</td>
					<td class="tablesec">（三）债务重组损失</td>
					<td class="textRight">${companyExpendMap.ZWCZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZWCZSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.ZWCZSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.ZWCZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >20</td>
					<td class="tablesec">（四）非常损失</td>
					<td class="textRight">${companyExpendMap.FCSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FCSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.FCSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.FCSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >21</td>
					<td class="tablesec">（五）捐赠支出</td>
					<td class="textRight">${companyExpendMap.JZZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.JZZC_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.JZZC_CE)}'>chayiInpo</c:if>">${companyExpendMap.JZZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >22</td>
					<td class="tablesec">（六）赞助支出</td>
					<td class="textRight">${companyExpendMap.ZZZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.ZZZC_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.ZZZC_CE)}'>chayiInpo</c:if>">${companyExpendMap.ZZZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >23</td>
					<td class="tablesec">（七）罚没支出</td>
					<td class="textRight">${companyExpendMap.FMZC_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.FMZC_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.FMZC_CE)}'>chayiInpo</c:if>">${companyExpendMap.FMZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >24</td>
					<td class="tablesec">（八）坏账损失</td>
					<td class="textRight">${companyExpendMap.HZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.HZSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.HZSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.HZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >25</td>
					<td class="tablesec">（九）无法收回的债券股权投资损失</td>
					<td class="textRight">${companyExpendMap.WFSHDZQGQTZSS_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.WFSHDZQGQTZSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.WFSHDZQGQTZSS_CE)}'>chayiInpo</c:if>">${companyExpendMap.WFSHDZQGQTZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >26</td>
					<td class="tablesec">（十）其他</td>
					<td class="textRight">${companyExpendMap.YYWZCQT_TB}</td>
					<td class="textRight yuceInpo">${companyExpendMap.YYWZCQT_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyExpendMap.YYWZCQT_CE)}'>chayiInpo</c:if>">${companyExpendMap.YYWZCQT_CE}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<a href="" id="download"></a>
<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
<script>
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/modelBuild/modelResult/taxpayerList.do?TASKID="+zs_getUrlParameter("TASKID");
});
window.onscroll=function(){
	if($(document).scrollTop()>=$(".cankao").offset().top){
		$(".titlebtn").addClass("fixed-table-tool");
	}else{
		$(".titlebtn").removeClass("fixed-table-tool");
	}
}
$(function(){
	importantWord();
});
function importantWord(){
	$(".chayiInpo").each(function(i,p){
		if("√o*".indexOf($(p).html())>=0){
			$(p).css("color","#393939");
		}
	});
}

function dowExcel(TASKID,xh){
	$(".loading_chuan").show();
		 $.ajax({
			url:"${ctxPath}/v1/html/modelBuild/modelResult/dowExcel.do",
			type:"post",
			data:{
				TASKID:TASKID,
				xh:xh
			},
			dataType:"json",
			success:function(data){
				$(".loading_chuan").hide();
				if(data.result=="ok"){
					$("#download").attr("href",data.values);
					document.getElementById("download").click(); 
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			}
		}); 
	}

</script>
</body>

</html>
