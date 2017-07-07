<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>一般企业收入以及疑点科目指向</title>
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
			<div  class="zongTitle tableTitle">企业收入及疑点科目指向</div>
			<div class="tableRightIcon"><!-- <i class="fa fa-print" aria-hidden="true"></i> --><i class="fa fa-file-excel-o" aria-hidden="true" onclick="dowExcel('${companyInfoMap.TASKID}','${companyInfoMap.xh}');"></i></div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr class="center" style="background:#fff !important">
					<td rowspan="2">行次</td>
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
					<td>一、营业收入（2+9）</td>
					<td class="textRight">${companyIncomeMap.YYSR_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.YYSR_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.YYSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.YYSR_CE}</td>
				</tr>
				<tr>
					<td class="center" >2</td>
					<td class="tablesec">（一）主营业务收入（3+5+6+7+8）</td>
					<td class="textRight">${companyIncomeMap.ZYYWSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.ZYYWSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.ZYYWSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.ZYYWSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >3</td>
					<td class="tableThir">1. 销售商品收入</td>
					<td class="textRight">${companyIncomeMap.XSSPSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.XSSPSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.XSSPSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.XSSPSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >4</td>
					<td class="tableFour">其中：非货币性资产交换收入</td>
					<td class="textRight">${companyIncomeMap.ZYYWSRFHBXZCJHSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.ZYYWSRFHBXZCJHSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.ZYYWSRFHBXZCJHSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.ZYYWSRFHBXZCJHSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >5</td>
					<td class="tableThir">2. 提供劳务收入</td>
					<td class="textRight">${companyIncomeMap.TGLWSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.TGLWSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.TGLWSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.TGLWSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >6</td>
					<td class="tableThir"> 3. 建造合同收入</td>
					<td class="textRight">${companyIncomeMap.JZHTSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.JZHTSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.JZHTSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.JZHTSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >7</td>
					<td class="tableThir">4. 让渡资产使用权收入</td>
					<td class="textRight">${companyIncomeMap.RDZCSYQSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.RDZCSYQSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.RDZCSYQSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.RDZCSYQSR_CE }</td>
				</tr>
				<tr>
					<td class="center">8</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyIncomeMap.ZYYWSRQT_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.ZYYWSRQT_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.ZYYWSRQT_CE)}'>chayiInpo</c:if>">${companyIncomeMap.ZYYWSRQT_CE }</td>
				</tr>
				<tr>
					<td class="center" >9</td>
					<td class="tablesec">（二）其他业务收入（10+12+13+14+15）</td>
					<td class="textRight">${companyIncomeMap.QTYWSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.QTYWSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.QTYWSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.QTYWSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >10</td>
					<td class="tableThir"> 1. 销售材料收入</td>
					<td class="textRight">${companyIncomeMap.XSCLSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.XSCLSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.XSCLSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.XSCLSR_CE }</td>
				</tr>
				
				<tr>
					<td class="center" >11</td>
					<td class="tableFour">其中：非货币性资产交换收入</td>
					<td class="textRight">${companyIncomeMap.QTYWSRFHBXZCJHSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.QTYWSRFHBXZCJHSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.QTYWSRFHBXZCJHSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.QTYWSRFHBXZCJHSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >12</td>
					<td class="tableThir">2. 出租固定资产收入</td>
					<td class="textRight">${companyIncomeMap.CZGDZCSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.CZGDZCSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.CZGDZCSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.CZGDZCSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >13</td>
					<td class="tableThir">3. 出租无形资产收入</td>
					<td class="textRight">${companyIncomeMap.CZWXZCSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.CZWXZCSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.CZWXZCSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.CZWXZCSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >14</td>
					<td class="tableThir"> 4. 出租包装物和商品收入</td>
					<td class="textRight">${companyIncomeMap.CZBZWHSPSR_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.CZBZWHSPSR_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.CZBZWHSPSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.CZBZWHSPSR_CE }</td>
				</tr>
				<tr>
					<td class="center" >15</td>
					<td class="tableThir">5. 其他</td>
					<td class="textRight">${companyIncomeMap.QTYWSRQT_TB }</td>
					<td class="textRight yuceInpo">${companyIncomeMap.QTYWSRQT_YC }</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.QTYWSRQT_CE)}'>chayiInpo</c:if>">${companyIncomeMap.QTYWSRQT_CE }</td>
				</tr>
				<tr>
					<td class="center" >16</td>
					<td>二、营业外收入（17+18+19+20+21+22+23+24+25+26）</td>
					<td class="textRight">${companyIncomeMap.YYWSR_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.YYWSR_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.YYWSR_CE)}'>chayiInpo</c:if>">${companyIncomeMap.YYWSR_CE}</td>
				</tr>
				<tr>
					<td class="center" >17</td>
					<td class="tablesec">（一）非流动资产处置利得</td>
					<td class="textRight">${companyIncomeMap.FLDZCCZLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.FLDZCCZLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.FLDZCCZLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.FLDZCCZLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >18</td>
					<td class="tablesec"> （二）非货币性资产交换利得</td>
					<td class="textRight">${companyIncomeMap.FHBXZCJHLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.FHBXZCJHLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.FHBXZCJHLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.FHBXZCJHLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >19</td>
					<td class="tablesec">（三）债务重组利得</td>
					<td class="textRight">${companyIncomeMap.ZWCZLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.ZWCZLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.ZWCZLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.ZWCZLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >20</td>
					<td class="tablesec">（四）政府补助利得</td>
					<td class="textRight">${companyIncomeMap.ZFBZLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.ZFBZLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.ZFBZLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.ZFBZLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >21</td>
					<td class="tablesec">（五）盘盈利得</td>
					<td class="textRight">${companyIncomeMap.PYLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.PYLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.PYLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.PYLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >22</td>
					<td class="tablesec">（六）捐赠利得</td>
					<td class="textRight">${companyIncomeMap.JZLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.JZLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.JZLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.JZLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >23</td>
					<td class="tablesec">（七）罚没利得</td>
					<td class="textRight">${companyIncomeMap.FMLD_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.FMLD_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.FMLD_CE)}'>chayiInpo</c:if>">${companyIncomeMap.FMLD_CE}</td>
				</tr>
				<tr>
					<td class="center" >24</td>
					<td class="tablesec">（八）确实无法偿付的应付款项</td>
					<td class="textRight">${companyIncomeMap.QSWFBCDYFKX_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.QSWFBCDYFKX_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.QSWFBCDYFKX_CE)}'>chayiInpo</c:if>">${companyIncomeMap.QSWFBCDYFKX_CE}</td>
				</tr>
				<tr>
					<td class="center" >25</td>
					<td class="tablesec">（九）汇兑收益</td>
					<td class="textRight">${companyIncomeMap.HZLY_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.HZLY_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.HZLY_CE)}'>chayiInpo</c:if>">${companyIncomeMap.HZLY_CE}</td>
				</tr>
				<tr>
					<td class="center" >26</td>
					<td class="tablesec">（十）其他</td>
					<td class="textRight">${companyIncomeMap.YYWSRQT_TB}</td>
					<td class="textRight yuceInpo">${companyIncomeMap.YYWSRQT_YC}</td>
					<td class="textRight <c:if test='${!fn:contains("√o*",companyIncomeMap.YYWSRQT_CE)}'>chayiInpo</c:if>">${companyIncomeMap.YYWSRQT_CE}</td>
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
