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
		<div class="tableContent TablecompanyInfo">
			<div  class="zongTitle tableTitle" style="margin-top:30px;">纳税遵从风险报告摘要</div>
			<div>
			<span style="margin-left: 28px;display: inline-block;"></span>根据<%-- <span  class="innerSpan">${taxRiskMap.DQ}</span>大企业 --%><span class="innerSpan">${FXRW.mc}</span>模型，抽取<span  class="innerSpan"><fmt:formatDate value="${FXRW.sjkssj}" pattern="yyyy" /></span>期间<span  class="innerSpan">${FXRW.swjgSjMc}</span>管辖范围内<span  class="innerSpan">${FXRW.hy}</span>行业的税务登记、申报、征收和财务等信息进行<span  class="innerSpan">${FXRW.sz}</span>纳税遵从分析，评定<span  class="innerSpan">${taxRiskMap.NSRMC}</span>存在纳税遵从风险，具体情况如下：
			</div>
			<div class="tableRightIcon"><!-- <i class="fa fa-print" aria-hidden="true"> </i>--><i class="fa fa-file-excel-o" aria-hidden="true" onclick="dowExcel('${companyInfoMap.TASKID}','${companyInfoMap.xh}');"></i></div>
			<div style="border: 1px solid #ccc;padding: 20px;margin-bottom:110px;">
			<div  class="tableTitle">一、高风险纳税人综合评价情况</div>
			<table class="table table-info table-striped table-bordered table-hover">
				<tr>
					<td>
						<div>本次评估共对<span  class="innerSpan">${FXRW.swjgSjMc}</span>管辖范围的<span  class="innerSpan">${total}</span>户纳税人进行风险评估，以风险程度大小排名，评估结果如下：</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">1. 在所有评估对象中排名第 <span class="innerSpan">${totalRank+1}</span>名，其风险等级被评定为<span class="innerSpan">${fxdj}</span>；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">2. 在 <span class="innerSpan">
						<c:if test='${taxRiskMap.NSRSSHY=="NA"||taxRiskMap.NSRSSHY==null}'>&nbsp;&nbsp;&nbsp;</c:if>
						<c:if test='${taxRiskMap.NSRSSHY!="NA"&&taxRiskMap.NSRSSHY!=null}'>${taxRiskMap.NSRSSHY}</c:if>
						</span>行业中排名第 <span class="innerSpan"><c:if test="${taxRiskMap.NSRSSHY!=null&&taxRiskMap.NSRSSHY!='NA'}">${hyRank+1}</c:if></span>名；</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">
							3. 在 <span  class="innerSpan">
							<c:if test='${taxRiskMap.NSRSSSWJG=="NA"||taxRiskMap.NSRSSSWJG==null}'>&nbsp;&nbsp;&nbsp;</c:if>
							<c:if test='${taxRiskMap.NSRSSSWJG!="NA"&&taxRiskMap.NSRSSSWJG!=null}'>${taxRiskMap.NSRSSSWJG}</c:if></span>地区范围内排名第<span class="innerSpan">
							<c:if test="${taxRiskMap.NSRSSSWJG!=null&&taxRiskMap.NSRSSSWJG!='NA'}">${dqRank+1}</c:if></span>名；
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="margin-left:28px;">4. 在 <span class="innerSpan">
						<c:if test='${taxRiskMap.NSRSSDJZCLX=="NA"||taxRiskMap.NSRSSDJZCLX==null}'>&nbsp;&nbsp;&nbsp;</c:if>
						<c:if test='${taxRiskMap.NSRSSDJZCLX!="NA"}'>${taxRiskMap.NSRSSDJZCLX}</c:if></span>类型中排名第<span class="innerSpan">
						<c:if test="${taxRiskMap.NSRSSDJZCLX!='NA'&&taxRiskMap.NSRSSDJZCLX!=null}">${lxRank+1}</c:if></span>名；</div>
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
						<td  class="textRight"><fmt:formatNumber value="${taxRiskMap.YSBSKZE}" pattern="#,###.##" minFractionDigits="2" /></td>
					</tr>
					<tr>
						<td>预测税款总额</td>
						<td  class="textRight"><fmt:formatNumber value="${taxRiskMap.YCSKZE}" pattern="#,###.##" minFractionDigits="2" /></td>
					</tr>
					<tr>
						<td>差额</td>
						<td  class="textRight"><fmt:formatNumber value="${taxRiskMap.CE}" pattern="#,###.##" minFractionDigits="2" /></td>
					</tr>
					<tr>
						<td>差额占比</td>
						<td  class="textRight"><fmt:formatNumber value="${taxRiskMap.CEZB*100}" pattern="#.##" minFractionDigits="2" />%</td>
					</tr>
				</table>
				<div  class="tableTitle">三、科目重要性排序</div>
				<div style="text-align:center">敬请期待</div>
				<%-- <table class="table table-info table-striped table-bordered table-hover">
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
							<td class="center"><a href="${ctxPath}/v1/html/analyse/result/detail2.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></td>
						</tr>
		</tbody>
				</table> --%>
				<div  class="tableTitle">四、参照企业列表 </div>
				<div style="text-align:center">敬请期待</div>
				<%-- <table class="table table-info table-striped table-bordered table-hover">
					<tbody id="czqylbTableCont">
						<tr>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align:right;margin-top:-17px;margin-bottom:30px"><a title="查看更多" href="${ctxPath}/v1/html/analyse/result/detail1.do?TASKID=${companyInfoMap.TASKID}&xh=${companyInfoMap.xh}&NSRMC=${companyInfoMap.NSRMC}">查看更多>></a></div>
			 --%>
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
	window.location.href="${ctxPath}/v1/html/analyse/result/taxpayerList.do?TASKID="+zs_getUrlParameter("TASKID");
});
window.onscroll=function(){
	if($(document).scrollTop()>=$(".cankao").offset().top){
		$(".titlebtn").addClass("fixed-table-tool");
	}else{
		$(".titlebtn").removeClass("fixed-table-tool");
	}
}
/* $(function(){
	$(".innerSpan").each(function(i,p){
		if($(p).html()==""){
			$(p).html("所有");
		}
	});
}); */
function creatKmzyx(){
	var kmzyxArray = $("#kmzyxArray").val().split(",");
	$("#kmTableCont td").each(function(i,p){
		$(p).html(kmzyxArray[i]);
	});
}
//creatKmzyx();

function creatczqy(){
	var czqylbArray = $("#czqylbArray").val().split(",");
	var tableContent = '';
	$.each(czqylbArray,function(i,p){
		tableContent+='<tr><td>'+i+'</td><td style="text-align:right">'+p+'</td></tr>';
	});
	$("#czqylbTableCont").html(tableContent);
}
//creatczqy();

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
