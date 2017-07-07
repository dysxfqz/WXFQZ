<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>纳税申报以及疑点科目指向</title>
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
					<li><span class="comLeft">社会信用代码：</span>
					<c:if test="${companyInfoMap.NSRSSSHXYDM!='NA'}">${companyInfoMap.NSRSSSHXYDM}</c:if>
					<c:if test="${companyInfoMap.NSRSSSHXYDM=='NA'}">${companyInfoMap.TAXID}</c:if>
					<c:if test="${companyInfoMap.NSRSSSHXYDM=='NA'&&companyInfoMap.TAXID=='NA'}">${companyInfoMap.NSRSSDJZCDM}</c:if>
					</li>
					<li><span class="comLeft">纳税人名称：</span>${companyInfoMap.NSRMC}</li>
					<!--${companyInfoMap.TAXID}  -->
				</ul>
			</div>
			<hr>
			<div class="cankao"></div>
			<div  class="titlebtn">
				<ul>
					<li><a href="${ctxPath}/v1/html/analyse/result/report1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">企业基本信息</a></li>
					<li><a href="${ctxPath}/v1/html/analyse/result/report2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">纳税遵从风险报告摘要</a></li>
					<li><a href="${ctxPath}/v1/html/analyse/result/report3.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">纳税申报及疑点科目指向</a></li>
					<li><a href="${ctxPath}/v1/html/analyse/result/report4.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">企业收入及疑点科目指向</a></li>
					<li><a href="${ctxPath}/v1/html/analyse/result/report5.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">企业成本支出及疑点科目指向</a></li>
					<li><a href="${ctxPath}/v1/html/analyse/result/report6.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}&NSRSSSHXYDM=${companyInfoMap.NSRSSSHXYDM}&TAXID=${companyInfoMap.TAXID}&NSRSSDJZCDM=${companyInfoMap.NSRSSDJZCDM}">企业期间费用及疑点科目指向</a></li>
				</ul>
			</div>
		<div class="tableContent">
			<div  class="zongTitle tableTitle">纳税申报及疑点科目指向</div>
			<div class="tableRightIcon"><!-- <i class="fa fa-print" aria-hidden="true"></i> --><i class="fa fa-file-excel-o" aria-hidden="true" onclick="dowExcel('${companyInfoMap.TASKID}','${companyInfoMap.xh}');"></i></div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr class="center" style="background:#fff !important">
					<td rowspan="2">行次</td>
					<td rowspan="2" style="width:50px;">类别</td>
					<td rowspan="2">项目</td>
					<td>填报值</td>
					<td class="yuceInpo">预测值</td>
					<td>差异值</td>
				</tr>
				<tr class="center"  style="background:#fff !important">
					<td>1</td>
					<td class="yuceInpo">2</td>
					<td>2-1</td>
				</tr>
				<tr>
					<td class="center" >1</td>
					<td class="center"  rowspan="13">利润总额计算</td>
					<td>一、营业收入(填写A101010\101020\103000)</td>
					<td class="textRight">${taxReportMap.YYSR_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYSR_CE)}'>chayiInpo</c:if>">${taxReportMap.YYSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >2</td>
					<td class="tablesec">减：营业成本(填写A102010\102020\103000)</td>
					<td class="textRight">${taxReportMap.YYCB_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYCB_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYCB_CE)}'>chayiInpo</c:if>">${taxReportMap.YYCB_CE}</td>
				</tr>
				<tr>
					<td class="center" >3</td>
					<td class="tableThir"> 营业税金及附加</td>
					<td class="textRight">${taxReportMap.YYSJ_FJ_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYSJ_FJ_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYSJ_FJ_CE)}'>chayiInpo</c:if>">${taxReportMap.YYSJ_FJ_CE}</td>
				</tr>
				<tr>
					<td class="center" >4</td>
					<td class="tableThir">销售费用(填写A104000)</td>
					<td class="textRight">${taxReportMap.XSFY_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.XSFY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.XSFY_CE)}'>chayiInpo</c:if>">${taxReportMap.XSFY_CE}</td>
				</tr>
				<tr>
					<td class="center" >5</td>
					<td class="tableThir">管理费用(填写A104000)</td>
					<td class="textRight">${taxReportMap.GLFY_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.GLFY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.GLFY_CE)}'>chayiInpo</c:if>">${taxReportMap.GLFY_CE}</td>
				</tr>
				<tr>
					<td class="center" >6</td>
					<td class="tableThir">财务费用(填写A104000)</td>
					<td class="textRight">${taxReportMap.CWFY_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.CWFY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.CWFY_CE)}'>chayiInpo</c:if>">${taxReportMap.CWFY_CE}</td>
				</tr>
				<tr>
					<td class="center" >7</td>
					<td class="tableThir">资产减值损失</td>
					<td class="textRight">${taxReportMap.ZCJZSS_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.ZCJZSS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.ZCJZSS_CE)}'>chayiInpo</c:if>">${taxReportMap.ZCJZSS_CE}</td>
				</tr>
				<tr>
					<td class="center" >8</td>
					<td class="tablesec"> 加：公允价值变动收益</td>
					<td class="textRight">${taxReportMap.GYJZBDSY_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.GYJZBDSY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.GYJZBDSY_CE)}'>chayiInpo</c:if>">${taxReportMap.GYJZBDSY_CE}</td>
				</tr>
				<tr>
					<td class="center" >9</td>
					<td class="tableThir">投资收益</td>
					<td class="textRight">${taxReportMap.TZSY_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.TZSY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.TZSY_CE)}'>chayiInpo</c:if>">${taxReportMap.TZSY_CE}</td>
				</tr>
				<tr>
					<td class="center" >10</td>
					<td>二、营业利润(1-2-3-4-5-6-7+8+9)</td>
					<td class="textRight">${taxReportMap.YYLR_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYLR_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYLR_CE)}'>chayiInpo</c:if>">${taxReportMap.YYLR_CE}</td>
				</tr>
				
				<tr>
					<td class="center" >11</td>
					<td class="tablesec"> 加：营业外收入(填写A101010\101020\103000)</td>
					<td class="textRight">${taxReportMap.YYWSR_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYWSR_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYWSR_CE)}'>chayiInpo</c:if>">${taxReportMap.YYWSR_CE}</td>
				</tr>
				<tr>
					<td class="center" >12</td>
					<td class="tablesec">减：营业外支出(填写A102010\102020\103000)</td>
					<td class="textRight">${taxReportMap.YYWZC_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YYWZC_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YYWZC_CE)}'>chayiInpo</c:if>">${taxReportMap.YYWZC_CE}</td>
				</tr>
				<tr>
					<td class="center" >13</td>
					<td>三、利润总额（10+11-12）</td>
					<td class="textRight">*</td>
					<td class="textRight yuceInpo">*</td>
					<td class="textRight">*</td>
				</tr>
				<tr>
					<td class="center" >14</td>
					<td class="center" rowspan="10">应纳税所得额计算</td>
					<td  class="tablesec"> 减：境外所得（填写A108010）</td>
					<td class="textRight">${taxReportMap.JWSDJE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.JWSDJE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.JWSDJE_CE)}'>chayiInpo</c:if>">${taxReportMap.JWSDJE_CE}</td>
				</tr>
				<tr>
					<td class="center" >15</td>
					<td class="tablesec"> 加：纳税调整增加额（填写A105000）</td>
					<td class="textRight">${taxReportMap.NSTZZJE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.NSTZZJE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.NSTZZJE_CE)}'>chayiInpo</c:if>">${taxReportMap.NSTZZJE_CE}</td>
				</tr>
				<tr>
					<td class="center" >16</td>
					<td class="tablesec">减：纳税调整减少额（填写A105000）</td>
					<td class="textRight">${taxReportMap.NSTZJSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.NSTZJSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.NSTZJSE_CE)}'>chayiInpo</c:if>">${taxReportMap.NSTZJSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >17</td>
					<td  class="tablesec">减：免税、减计收入及加计扣除（填写A107010）</td>
					<td class="textRight">${taxReportMap.MSJJSRJJJKC_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.MSJJSRJJJKC_TB}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.MSJJSRJJJKC_CE)}'>chayiInpo</c:if>">${taxReportMap.MSJJSRJJJKC_CE}</td>
				</tr>
				<tr>
					<td class="center" >18</td>
					<td  class="tablesec">加：境外应税所得抵减境内亏损（填写A108000）</td>
					<td class="textRight">${taxReportMap.JWYSSDDJJNKS_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.JWYSSDDJJNKS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.JWYSSDDJJNKS_CE)}'>chayiInpo</c:if>">${taxReportMap.JWYSSDDJJNKS_CE}</td>
				</tr>
				<tr>
					<td class="center" >19</td>
					<td>四、纳税调整后所得（13-14+15-16-17+18）</td>
					<td class="textRight">${taxReportMap.NSTZHSD_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.NSTZHSD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.NSTZHSD_CE)}'>chayiInpo</c:if>">${taxReportMap.NSTZHSD_CE}</td>
				</tr>
				<tr>
					<td class="center" >20</td>
					<td class="tablesec">减：所得减免（填写A107020）</td>
					<td class="textRight">${taxReportMap.SDJM_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.SDJM_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.SDJM_CE)}'>chayiInpo</c:if>">${taxReportMap.SDJM_CE}</td>
				</tr>
				<tr>
					<td class="center" >21</td>
					<td class="tablesec">减：抵扣应纳税所得额（填写A107030）</td>
					<td class="textRight">${taxReportMap.DKYNSSDE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.DKYNSSDE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.DKYNSSDE_CE)}'>chayiInpo</c:if>">${taxReportMap.DKYNSSDE_CE}</td>
				</tr>
				<tr>
					<td class="center" >22</td>
					<td  class="tablesec"> 减：弥补以前年度亏损（填写A106000）</td>
					<td class="textRight">${taxReportMap.MBYQNDKS_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.MBYQNDKS_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.MBYQNDKS_CE)}'>chayiInpo</c:if>">${taxReportMap.MBYQNDKS_CE}</td>
				</tr>
				<tr>
					<td class="center" >23</td>
					<td>五、应纳税所得额（19-20-21-22）</td>
					<td class="textRight">${taxReportMap.YNSSDE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YNSSDE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YNSSDE_CE)}'>chayiInpo</c:if>">${taxReportMap.YNSSDE_CE}</td>
				</tr>
				<tr>
					<td class="center" >24</td>
					<td class="center" rowspan="13">应纳税额计算</td>
					<td class="tablesec">税率（25%）</td>
					<td class="textRight">${taxReportMap.SL_1_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.SL_1_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.SL_1_CE)}'>chayiInpo</c:if>">${taxReportMap.SL_1_CE}</td>
				</tr>
				<tr>
					<td class="center" >25</td>
					<td>六、应纳所得税额（23×24）</td>
					<td class="textRight">${taxReportMap.YNSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YNSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YNSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.YNSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >26</td>
					<td class="tablesec">减：减免所得税额（填写A107040）</td>
					<td class="textRight">${taxReportMap.JMSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.JMSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.JMSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.JMSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >27</td>
					<td  class="tablesec"> 减：抵免所得税额（填写A107050）</td>
					<td class="textRight">${taxReportMap.DMSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.DMSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.DMSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.DMSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >28</td>
					<td>七、应纳税额（25-26-27））</td>
					<td class="textRight">${taxReportMap.YNSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.YNSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YNSE_CE)}'>chayiInpo</c:if>">${taxReportMap.YNSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >29</td>
					<td class="tablesec"> 加：境外所得应纳所得税额（填写A108000）</td>
					<td class="textRight">${taxReportMap.JWSDYNSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.JWSDYNSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.JWSDYNSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.JWSDYNSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >30</td>
					<td class="tablesec">减：境外所得抵免所得税额（填写A108000）</td>
					<td class="textRight">${taxReportMap.JWSDDMSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.JWSDDMSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.JWSDYNSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.JWSDYNSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >31</td>
					<td>八、实际应纳所得税额（28+29-30）</td>
					<td class="textRight">${taxReportMap.SJYNSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.SJYNSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.SJYNSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.SJYNSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >32</td>
					<td class="tablesec">减：本年累计实际已预缴的所得税额</td>
					<td class="textRight">${taxReportMap.BNLJSJYYJ_SDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.BNLJSJYYJ_SDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.BNLJSJYYJ_SDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.BNLJSJYYJ_SDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >33</td>
					<td >九、本年应补（退）所得税额（31-32）</td>
					<td class="textRight">${taxReportMap.BNYBT_SDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.BNYBT_SDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.BNYBT_SDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.BNYBT_SDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >34</td>
					<td class="tablesec"> 其中：总机构分摊本年应补（退）所得税额(填写A109000)</td>
					<td class="textRight">${taxReportMap.ZJGFTBNYBTSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.ZJGFTBNYBTSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.ZJGFTBNYBTSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.ZJGFTBNYBTSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >35</td>
					<td class="tableThir">财政集中分配本年应补（退）所得税额（填写A109000）</td>
					<td class="textRight">${taxReportMap.CZJZFPBNYBTSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.CZJZFPBNYBTSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.CZJZFPBNYBTSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.CZJZFPBNYBTSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >36</td>
					<td class="tableThir">总机构主体生产经营部门分摊本年应补（退）所得税额(填写A109000)</td>
					<td class="textRight">${taxReportMap.ZJGZTSCJYBMFTBNYBTSDSE_TB}</td>
					<td class="textRight yuceInpo">${taxReportMap.ZJGZTSCJYBMFTBNYBTSDSE_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.ZJGZTSCJYBMFTBNYBTSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.ZJGZTSCJYBMFTBNYBTSDSE_CE}</td>
				</tr>
				<tr>
					<td class="center" >37</td>
					<td class="center"  rowspan="2">附列资料</td>
					<td>以前年度多缴的所得税额在本年抵减额</td>
					<td class="textRight">${taxReportMap.YQNDDJ_SDSE_BNDJE_TB }</td>
					<td class="textRight yuceInpo">${taxReportMap.YQNDDJ_SDSE_BNDJE_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YQNDDJ_SDSE_BNDJE_CE)}'>chayiInpo</c:if>">${taxReportMap.YQNDDJ_SDSE_BNDJE_CE}</td>
				</tr>
				<tr>
					<td class="center" >38</td>
					<td>以前年度应缴未缴在本年入库所得税额</td>
					<td class="textRight">${taxReportMap.YQND_YJWJZBNRKSDSE_TB }</td>
					<td class="textRight yuceInpo">${taxReportMap.YQND_YJWJZBNRKSDSE_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",taxReportMap.YQND_YJWJZBNRKSDSE_CE)}'>chayiInpo</c:if>">${taxReportMap.YQND_YJWJZBNRKSDSE_CE }</td>
				</tr>
			</table>
			<ul class="reportZhu">
				<li>注：√，表示已经过模型测算，但发现风险程度较低。</li>
				<li style="padding-left:25px;">○，表示已经过模型测算，但由于数据质量原因，所预测的结果不可靠。</li>
				<li style="padding-left:25px;">*，表示未经过模型测算。</li>
			</ul>
		</div>
	</div>
</div>
<a href="" id="download"></a>
<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
<script>
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/analyse/result/taxpayerList.do?TASKID="+zs_getUrlParameter("TASKID");
});
window.onscroll=function(){
	if($(document).scrollTop()>=$(".cankao").offset().top){
		$(".titlebtn").addClass("fixed-table-tool");
	}else{
		$(".titlebtn").removeClass("fixed-table-tool");
	}
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
$(function(){
	$(".textRight").each(function(i,p){
		if(!isNaN($(p).html())){
			var tempVal = formatNumber($(p).html(),2);
			$(p).html(tempVal)
		}
	});
});
//格式化大金额数字
function formatNumber(num, precision, separator) {
    var parts;
    // 判断是否为数字
    if (!isNaN(parseFloat(num)) && isFinite(num)) {
        // 把类似 .5, 5. 之类的数据转化成0.5, 5, 为数据精度处理做准, 至于为什么
        // 不在判断中直接写 if (!isNaN(num = parseFloat(num)) && isFinite(num))
        // 是因为parseFloat有一个奇怪的精度问题, 比如 parseFloat(12312312.1234567119)
        // 的值变成了 12312312.123456713
        num = Number(num);
        // 处理小数点位数
        num = toDecimal2(num,precision);
       // num = (typeof precision !== 'undefined' ?  parseInt(num*100)/100 : num).toString();
        // 分离数字的小数部分和整数部分
        parts = num.split('.');
        // 整数部分加[separator]分隔, 借用一个著名的正则表达式
        parts[0] = parts[0].toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1' + (separator || ','));

        return parts.join('.');
    }
    return NaN;
}
function toDecimal2(x,nums) { 
	   var f = parseFloat(x); 
	   if (isNaN(f)) { 
	    return false; 
	   } 
	   var f = Math.round(x*100)/100; 
	   var s = f.toString(); 
	   var rs = s.indexOf('.'); 
	   if (rs < 0) { 
	    rs = s.length; 
	    s += '.'; 
	   } 
	   while (s.length <= rs + nums) { 
	    s += '0'; 
	   } 
	   return s; 
	  }
</script>
</body>

</html>
