<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>企业纳税遵从风险报告摘要</title>
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
		<div class="tableContent TablecompanyInfo">
			<div  class="zongTitle tableTitle" style="margin-top:30px;">纳税遵从风险报告摘要</div>
			<div>
			  <span style="margin-left: 28px;display: inline-block;"></span>根据<span  class="innerSpan">${taxRiskMap.DQ}</span>大企业<span class="innerSpan">${taxRiskMap.JQXXSFMX}</span>模型，抽取<span  class="innerSpan">${taxRiskMap.ND}</span>年度<span  class="innerSpan">${taxRiskMap.DQ}</span>地区<span  class="innerSpan">${taxRiskMap.HY}</span>行业的税务登记、申报、征收和财务等信息进行<span  class="innerSpan">${taxRiskMap.SZ}</span>纳税遵从分析，评定<span  class="innerSpan">${taxRiskMap.NSRMC}</span>存在纳税遵从风险，具体情况如下：
			</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true"></i></div>
			<div style="border: 1px solid #ccc;padding: 20px;">
			<div  class="tableTitle">一、高风险纳税人综合评价情况</div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr>
					<td>
						<div style="margin-left:28px;">本次评估共对<span  class="innerSpan">${taxRiskMap.DQ}</span>管辖范围的<span  class="innerSpan">${total}</span>户纳税人进行风险评估，以风险程度大小排名，评估结果如下：</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:54px;">1. 在所有评估对象中排名第 <span class="innerSpan">${totalRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${taxRiskMap.PGDXZFXDJ}</span>；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:54px;">2. 在 <span class="innerSpan">${taxRiskMap.NSRSSHY}</span>行业中排名第 <span class="innerSpan">${hyRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${taxRiskMap.NSRSSHYFXDJ}</span>；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:54px;">
							3. 在 <span  class="innerSpan"><c:if test="${taxRiskMap.DQ == '' || taxRiskMap.DQ == null}">所有</c:if><c:if test="${taxRiskMap.DQ != ''}">${taxRiskMap.DQ}</c:if></span>地区范围内排名第<span class="innerSpan">${dqRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${taxRiskMap.NSRSSSWJGFXDJ}</span>；
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:54px;">4. 在 <span class="innerSpan">${taxRiskMap.NSRSSDJZCLX}</span>类型中排名第<span class="innerSpan">${lxRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${taxRiskMap.NSRSSDJZCLXFXDJ}</span>；</div>
					</td>
				</tr>
			</table>
			<div  class="tableTitle">二、高风险纳税人识别结果列表  </div>
			<table class="table table-info table-striped table-bordered table-hover">
					<tr>
						<td class="center" style="width:150px;">税种</td>
						<td  class="center">企业所得税</td>
					</tr>
					<tr>
						<td>已申报税款总额</td>
						<td  class="textRight">${taxRiskMap.YSBSKZE}</td>
					</tr>
					<tr>
						<td>预测税款总额</td>
						<td  class="textRight">${taxRiskMap.YCSKZE}</td>
					</tr>
					<tr>
						<td>差额</td>
						<td  class="textRight">${taxRiskMap.CE}</td>
					</tr>
					<tr>
						<td>差额占比</td>
						<td  class="textRight"><fmt:formatNumber value="${taxRiskMap.CEZB*100}" pattern="#.##" minFractionDigits="2" />%</td>
					</tr>
				</table>
				<div  class="tableTitle">三、科目重要性排序</div>
				<table class="table table-info table-striped table-bordered table-hover">
					<tr>
						<td>中华人民共和国企业所得税年度纳税申报表.本年累计实际已预缴的所得税额</td>
						<td>中华人民共和国企业所得税年度纳税申报表.利润总额</td>
						<td>捐赠支出纳税调整明细表.按税收规定计算的扣除限额</td>
						<td>中华人民共和国企业所得税年度纳税申报表.应纳税所得额</td>
						<td>中华人民共和国企业所得税年度纳税申报表.纳税调整后所得</td>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.27.账载金额资产账载金额</td>
					</tr>
					<tr>
						<td>中华人民共和国企业所得税年度纳税申报表.营业外收入</td>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.2.税收金额累计折旧额</td>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.5.账载金额资产账载金额</td>
						<td>纳税调整项目明细表.扣除类调整项目调增金额</td>
						<td>纳税调整项目明细表.合计调减金额</td>
						<td>捐赠支出纳税调整明细表.合计税收金额</td>
					</tr>
					<tr>
						<td>期间费用明细表.各项税费管理费用</td>
						<td>期间费用明细表.合计管理费用</td>
						<td>一般企业收入明细表.营业外收入</td>
						<td>中华人民共和国企业所得税年度纳税申报表.应纳所得税额</td>
						<td>中华人民共和国企业所得税年度纳税申报表.应纳税额</td>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.2.账载金额资产计税基础</td>
					</tr>
					<tr>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.2.税收金额按税收一般规定计算的本年折旧.摊销额</td>
						<td>中华人民共和国企业所得税年度纳税申报表.管理费用</td>
						<td>中华人民共和国企业所得税年度纳税申报表.纳税调整增加额</td>
						<td>资产折旧.摊销情况及纳税调整明细表.EWBHXH.2.税收金额资产计税基础</td>
						<td>所得减免明细表.EWBHXH.17.减免所得额</td>
						<td class="center"><a href="${ctxPath}/v1/html/task/result/detail2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></td>
						<!-- <td >纳税调整项目明细表.资产减值准备金账载金额</td> -->
					</tr>
				</table>
				<div  class="tableTitle">四、参照企业列表 </div>
				<table class="table table-info table-striped table-bordered table-hover">
					<tr>
						<td class="center" style="width:150px;">序号</td>
						<td class="center">信息内容</td>
					</tr>
					<tr>
						<td class="center">1</td>
						<td  class="textRight">大唐开鲁新能源有限公司</td>
					</tr>
					<tr>
						<td class="center">2</td>
						<td  class="textRight">大唐鄂尔多斯市新能源有限公司</td>
					</tr>
					<tr>
						<td class="center">3</td>
						<td  class="textRight">大唐杭锦旗新能源有限公司</td>
					</tr>
					<tr>
						<td class="center">4</td>
						<td  class="textRight">内蒙古大唐国际托克托第二发电有限责任公司</td>
					</tr>
					<tr>
						<td class="center">5</td>
						<td  class="textRight">大唐包头新能源有限责任公司</td>
					</tr>
				</table>
				<div style="text-align:right;margin-top:-17px;margin-bottom:30px"><a title="查看更多" href="${ctxPath}/v1/html/task/result/detail1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></div>
			</div>
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
