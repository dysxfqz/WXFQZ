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
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业基本信息</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税遵从风险报告摘要</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report3.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">纳税申报及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report4.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业收入及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report5.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业成本支出及疑点科目指向</a></li>
			<li><a href="${ctxPath}/v1/html/modelBuild/modelResult/report6.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">企业期间费用及疑点科目指向</a></li>
		</ul>
		<div class="tableContent TablecompanyInfo">
			<div  class="zongTitle tableTitle" style="margin-top:30px;">纳税遵从风险报告摘要</div>
			<div>
			  <span style="margin-left: 28px;display: inline-block;"></span>根据<span  class="innerSpan">${taxRiskMap.DQ}</span>大企业<span class="innerSpan">${taxRiskMap.JQXXSFMX}</span>模型，抽取<span  class="innerSpan">${taxRiskMap.ND}</span>年度<span  class="innerSpan">${taxRiskMap.DQ}</span>地区<span  class="innerSpan">${taxRiskMap.HY}</span>行业的税务登记、申报、征收和财务等信息进行<span  class="innerSpan">${taxRiskMap.SZ}</span>纳税遵从分析，评定<span  class="innerSpan">${taxRiskMap.NSRMC}</span>存在纳税遵从风险，具体情况如下：
			</div>
			<div class="tableRightIcon"><i class="fa fa-print" aria-hidden="true"></i><i class="fa fa-file-excel-o" aria-hidden="true" onclick="dowExcel('${companyInfoMap.TASKID}','${companyInfoMap.xh}');"></i></div>
			<div style="border: 1px solid #ccc;padding: 20px;">
			<div  class="tableTitle">一、高风险纳税人综合评价情况</div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr>
					<td>
						<div>本次评估共对<span  class="innerSpan">${taxRiskMap.DQ}</span>管辖范围的<span  class="innerSpan">${total}</span>户纳税人进行风险评估，以风险程度大小排名，评估结果如下：</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">1. 在所有评估对象中排名第 <span class="innerSpan">${totalRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${fxdj}</span>；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">2. 在 <span class="innerSpan">${taxRiskMap.NSRSSHY}</span>行业中排名第 <span class="innerSpan">${hyRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${fxdj}</span>；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">
							3. 在 <span  class="innerSpan"> <c:if test="${taxRiskMap.DQ == '' || taxRiskMap.DQ == null}">所有</c:if><c:if test="${taxRiskMap.DQ != ''}">${taxRiskMap.DQ}</c:if></span>地区范围内排名第<span class="innerSpan">${dqRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${fxdj}</span>；
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">4. 在 <span class="innerSpan">${taxRiskMap.NSRSSDJZCLX}</span>类型中排名第<span class="innerSpan">${lxRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${fxdj}</span>；</div>
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
					<tbody id="kmTableCont">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td class="center"><a href="${ctxPath}/v1/html/modelBuild/modelResult/detail2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></td>
						</tr>
		</tbody>
				</table>
				<div  class="tableTitle">四、参照企业列表 </div>
				<table class="table table-info table-striped table-bordered table-hover">
					<tbody id="czqylbTableCont">
						<tr>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align:right;margin-top:-17px;margin-bottom:30px"><a title="查看更多" href="${ctxPath}/v1/html/modelBuild/modelResult/detail1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></div>
			</div>
		</div>
	</div>
</div>
<a href="" id="download"></a>
<div class="loading_chuan"><img class="load_img" src="${ctxPath}/static/source/img/loading.gif"/></div>
<input type="hidden" value="${kmzyxArray}" id="kmzyxArray">
<input type="hidden" value="${czqylbArray}" id="czqylbArray">
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

function creatKmzyx(){
	var kmzyxArray = $("#kmzyxArray").val().split(",");
	$("#kmTableCont td").each(function(i,p){
		$(p).html(kmzyxArray[i]);
	});
}
creatKmzyx();

function creatczqy(){
	var czqylbArray = $("#czqylbArray").val().split(",");
	var tableContent = '';
	$.each(czqylbArray,function(i,p){
		tableContent+='<tr><td>'+i+'</td><td style="text-align:right">'+p+'</td></tr>';
	});
	$("#czqylbTableCont").html(tableContent);
}
creatczqy();

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
