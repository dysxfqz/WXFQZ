<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>一户式报告</title>
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
			<div class="tableTitle">企业基本信息表</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true"></i></div>
			<table class="table table-info table-striped table-bordered table-hover">
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">100基本信息</td>
					</tr>
					<tr>
						<td colspan="2">101汇总纳税企业</td>
						<td colspan="6">
						<div class="checkbox">
							是(<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.HZNSQY==1 }">checked</c:if>  type="checkbox"  />
									
									<span class="lbl">总机构</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1"  <c:if test="${companyInfoMap.HZNSQY==2 }">checked</c:if> type="checkbox" />
									<span class="lbl">按比例缴纳总机构</span>
								</label>
								)
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.HZNSQY==3 }">checked</c:if> type="checkbox" />
									<span class="lbl">否</span>
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">102注册资本（万元）</td>
						<td colspan="2">${companyInfoMap.ZCZB}</td>
						<td colspan="2">106境外中资控股居民企业</td>
						<td colspan="2">
							<div class="checkbox">
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.JWZZKGJMQY=='Y' }">checked</c:if>  type="checkbox" />
									<span class="lbl">是</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.JWZZKGJMQY=='N' }">checked</c:if> type="checkbox" />
									<span class="lbl">否</span>
								</label>
							</div>
							</td>
					</tr>
					<tr>
						<td colspan="2">103所属行业明细代码</td>
						<td colspan="2">${companyInfoMap.SSHY_DM}</td>
						<td colspan="2">107从事国家非限制和禁止行业</td>
						<td colspan="2">
							<div class="checkbox">
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.CSGJFXZHJZHY=='Y' }">checked</c:if> type="checkbox" />
									<span class="lbl">是</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.CSGJFXZHJZHY=='N' }">checked</c:if>  type="checkbox" />
									<span class="lbl">否</span>
								</label>
							</div>
							</td>
					</tr>
					<tr>
						<td colspan="2">104从业人数 </td>
						<td colspan="2">${companyInfoMap.CYRS}</td>
						<td colspan="2">108存在境外关联交易</td>
						<td colspan="2">
							<div class="checkbox">
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.CZJWGLJY=='Y' }">checked</c:if> type="checkbox" />
									<span class="lbl">是</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.CZJWGLJY=='N' }">checked</c:if> type="checkbox" />
									<span class="lbl">否</span>
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">105资产总额（万元）</td>
						<td colspan="2">${companyInfoMap.ZCZE}</td>
						<td colspan="2">109上市公司</td>
						<td colspan="2">
							<div class="checkbox">
								是(<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.SSGS==0 }">checked</c:if> type="checkbox" />
										<span class="lbl">境内</span>
									</label>
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.SSGS==1 }">checked</c:if> type="checkbox" />
										<span class="lbl">境外</span>
									</label>
									)
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.SSGS==2 }">checked</c:if> type="checkbox" />
										<span class="lbl">否</span>
									</label>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">200主要会计政策和估计</td>
					</tr>
					<tr>
						<td colspan="2" class="center">201适用的会计准则或会计制度 </td>
						<td colspan="6">
							<div class="checkbox">
							企业会计准则(
							<c:set var="string" value="${companyInfoMap.CHCBJJFF}"></c:set>
							<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'0')}">checked</c:if> type="checkbox" />
									<span class="lbl">一般企业</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'1')}">checked</c:if> type="checkbox" />
									<span class="lbl">银行</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'2')}">checked</c:if> type="checkbox" />
									<span class="lbl">证券</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'3')}">checked</c:if> type="checkbox" />
									<span class="lbl">保险</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'4')}">checked</c:if> type="checkbox" />
									<span class="lbl">担保</span>
								</label>
								)
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.XQYKJZZ=='Y' }">checked</c:if>  type="checkbox" />
										<span class="lbl">小企业会计准则</span>
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.QYKJZD=='Y' }">checked</c:if>  type="checkbox" />
										<span class="lbl">企业会计制度</span>
									</label>
								</div>
								<div class="checkbox">
							事业单位会计准则(
							<c:set var="string" value="${companyInfoMap.SYDWKJZZ}"></c:set>
							<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'0')}">checked</c:if> type="checkbox" />
									<span class="lbl">事业单位会计制度</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'1')}">checked</c:if> type="checkbox" />
									<span class="lbl">科学事业单位会计制度</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'2')}">checked</c:if> type="checkbox" />
									<span class="lbl">医院会计制度</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'3')}">checked</c:if> type="checkbox" />
									<span class="lbl">高等学校会计制度</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'4')}">checked</c:if> type="checkbox" />
									<span class="lbl">中小学校会计制度</span>
								</label>
								<label>
									<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'5')}">checked</c:if> type="checkbox" />
									<span class="lbl">彩票机构会计制度</span>
								</label>
								)
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.MJFYLZZKJZD=='Y' }">checked</c:if> type="checkbox" />
										<span class="lbl">民间非营利组织会计制度</span>
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.CJTJJZZKJZD==0 }">checked</c:if> type="checkbox" />
										<span class="lbl">村集体经济组织会计制度</span>
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.NMZYHZSCWKJZD==0 }">checked</c:if> type="checkbox" />
										<span class="lbl">农民专业合作社财务会计制度（试行）</span>
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.KJZDQT=='Y' }">checked</c:if> type="checkbox" />
										<span class="lbl">其他</span>
									</label>
								</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">202会计档案的存放地</td>
						<td colspan="2">${companyInfoMap.KJDACFD}</td>
						<td colspan="2">203会计核算软件</td>
						<td colspan="2">${companyInfoMap.KJHSRJMC}</td>
					</tr>
					<tr>
						<td colspan="2">204记账本位币   </td>
						<td colspan="2">
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.KJJZBB=='Y' }">checked</c:if> type="checkbox" />
								<span class="lbl">人民币</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.KJJZBB=='N' }">checked</c:if>  type="checkbox" />
								<span class="lbl">其他</span>
							</label>
							</td>
						<td colspan="2">205会计政策和估计是否发生变化</td>
						<td colspan="2">
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.KJZCHGJSFFSBH='Y' }">checked</c:if> type="checkbox" />
								<span class="lbl">是</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.KJZCHGJSFFSBH=='N' }">checked</c:if> type="checkbox" />
								<span class="lbl">否</span>
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">206固定资产折旧方法</td>
						<td colspan="6">
						<c:set var="string" value="${companyInfoMap.GDZCZJFF}"></c:set>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'11')}">checked</c:if> type="checkbox" />
								<span class="lbl">年限平均法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'12')}">checked</c:if> type="checkbox" />
								<span class="lbl">工作量法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'21')}">checked</c:if> type="checkbox" />
								<span class="lbl">双倍余额递减法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'22')}">checked</c:if> type="checkbox" />
								<span class="lbl">年数总和法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'90')}">checked</c:if> type="checkbox" />
								<span class="lbl">其他</span>
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">207存货成本计价方法</td>
						<td colspan="6">
						<c:set var="string" value="${companyInfoMap.CHCBJJFF}"></c:set>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'0')}">checked</c:if> type="checkbox" />
								<span class="lbl">先进先出法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'1') }">checked</c:if> type="checkbox" />
								<span class="lbl">移动加权平均法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'2')}">checked</c:if> type="checkbox" />
								<span class="lbl">月末一次加权平均法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'3') }">checked</c:if> type="checkbox" />
								<span class="lbl">个别计价法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'4')}">checked</c:if> type="checkbox" />
								<span class="lbl">毛利率法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'5') }">checked</c:if> type="checkbox" />
								<span class="lbl">零售价法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'6')}">checked</c:if> type="checkbox" />
								<span class="lbl">计划成本法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'7') }">checked</c:if> type="checkbox" />
								<span class="lbl">其他</span>
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">208坏账损失核算方法</td>
						<td colspan="6">
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.HZSSHSFF=='Y' }">checked</c:if> type="checkbox" />
								<span class="lbl">备抵法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${companyInfoMap.HZSSHSFF=='N'}">checked</c:if> type="checkbox" />
								<span class="lbl">直接核销法</span>
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="2">209所得税计算方法</td>
						<td colspan="6">
						<c:set var="string" value="${companyInfoMap.SDSJSFF}"></c:set>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'0')}">checked</c:if> type="checkbox" />
								<span class="lbl">应付税款法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'1')}">checked</c:if> type="checkbox" />
								<span class="lbl">资产负债表债务法</span>
							</label>
							<label>
								<input class="ace ace-checkbox-1" <c:if test="${fn:contains(string,'2')}">checked</c:if> type="checkbox" />
								<span class="lbl">其他</span>
							</label>
						</td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">300企业主要股东及对外投资情况</td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">301企业主要股东（前5位）</td>
					</tr>
					<tr>
						<td class="center">股东名称</td>
						<td colspan="2" class="center">证件种类</td>
						<td colspan="2" class="center">证件号码</td>
						<td class="center">经济性质</td>
						<td class="center">投资比例</td>
						<td class="center">国籍（注册地址）</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">302对外投资（前5位）</td>
					</tr>
					<tr>
						<td class="center">被投资者名称</td>
						<td class="center" colspan="2">纳税人识别号</td>
						<td class="center" colspan="2">经济性质</td>
						<td class="center">投资比例</td>
						<td class="center">投资金额</td>
						<td class="center">注册地址</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">303境内关联交易（前5位）</td>
					</tr>
					<tr>
						<td class="center">关联交易者名称</td>
						<td class="center" colspan="2">纳税人识别号</td>
						<td class="center" colspan="2">经济性质</td>
						<td class="center">投资比例</td>
						<td class="center">投资金额</td>
						<td class="center">注册地址</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">304境外关联交易（前5位）</td>
					</tr>
					<tr>
						<td class="center">关联交易者名称</td>
						<td class="center" colspan="2">纳税人识别号</td>
						<td class="center" colspan="2">经济性质</td>
						<td class="center">投资比例</td>
						<td class="center">投资金额</td>
						<td class="center">注册地址</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="8" style="font-size: 16px;font-weight: bold;">305总分机构情况（前5位）</td>
					</tr>
					<tr>
						<td class="center">关联交易者名称</td>
						<td class="center" colspan="2">纳税人识别号</td>
						<td class="center" colspan="2">经济性质</td>
						<td class="center">投资比例</td>
						<td class="center">投资金额</td>
						<td class="center">注册地址</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2"></td>
						<td colspan="2"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
			</table>
			<div class="tableTip">
				注：以上信息仅供应对处理做笔记使用，可不填。
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
