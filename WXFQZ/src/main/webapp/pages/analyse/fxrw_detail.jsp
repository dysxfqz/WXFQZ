<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>任务详情</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
<div class="row" style="margin-left:0;margin-right:0">
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>任务详情</h1>
			<span class="detailGoBack">返回</span>
		</div>
		<div class="widgetDiv">
		
			<%-- <div class="row">
	           	<span class="widgetMc">${fxrw.mc}</span>
	            <span class="rightCirContent">
	           		<span class="proCircle">
	           			<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 0 && fxrw.zt<2)||(fxrw.jd+1== 0 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${fxrw.jd >0 || (fxrw.zt==2 && fxrw.jd ==0)}'>active</c:if> <c:if test="${fxrw.zt==3 && fxrw.jd ==0}"> circleError</c:if>">1</span><br>
			           	<span class="progessTitle">数据采集</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars" style="height:6px">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >1 ||(fxrw.zt==2&&fxrw.jd>0)}'>default</c:if><c:if test='${(fxrw.jd== 1 && fxrw.zt<2)||(fxrw.jd+1== 1 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >1 ||(fxrw.zt==2&&fxrw.jd>0)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 1 && fxrw.zt<2)||(fxrw.jd+1== 1 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
		          	 	<span class="progessCircle <c:if test='${fxrw.jd >1 || (fxrw.zt==2 && fxrw.jd ==1)}'>active</c:if><c:if test="${fxrw.zt==3 && fxrw.jd ==1}"> circleError</c:if>">2</span><br>
		           		<span class="progessTitle">数据清洗</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >2  ||(fxrw.zt==2&&fxrw.jd>1)}'>default</c:if><c:if test='${(fxrw.jd== 2 && fxrw.zt<2)||(fxrw.jd+1== 2 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >2  ||(fxrw.zt==2&&fxrw.jd>1)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           	<span class="progessCircle zhuan <c:if test='${(fxrw.jd== 2 && fxrw.zt<2)||(fxrw.jd+1== 2 && fxrw.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${fxrw.jd >2 || (fxrw.zt==2 && fxrw.jd ==2)}'>active</c:if><c:if test="${fxrw.zt==3 && fxrw.jd ==2}"> circleError</c:if>">3</span><br>
			           		<span class="progessTitle">训练预测</span>
		           	</span>
		           	<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${fxrw.jd >3  ||(fxrw.zt==2&&fxrw.jd>2)}'>default</c:if> <c:if test='${(fxrw.jd== 3 && fxrw.zt<2)||(fxrw.jd+1== 3 && fxrw.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${fxrw.jd >3  ||(fxrw.zt==2&&fxrw.jd>2)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${fxrw.jd== 3 && fxrw.zt<2}'>active</c:if>" style="position:absolute"></span>
		           		<span class="progessCircle <c:if test='${fxrw.jd >3 || (fxrw.zt==2 && fxrw.jd ==3)}'>active</c:if> <c:if test="${fxrw.zt==3 && fxrw.jd ==3}"> circleError</c:if>">4</span><br>
		           		<span class="progessTitle">结果处理</span>
		           	</span>
	           	</span>
			</div> --%>
		
			<table class="table table-info table-striped table-bordered danHTable1" >
				<tbody>
					<tr>
						<td style="width:110px;">任务名称:</td>
						<td>${fxrw.mc}</td>
					</tr>
					<tr>
						<td style="width:110px;">任务描述:</td>
						<td>${fxrw.ms}</td>
					</tr>
					<tr>
						<td>税种:</td>
						<td>${fxrw.sz}</td>
					</tr>
					<tr>
						<td>行业:</td>
						<td>
							<div class="danDiv">
								<c:if test="${fxrw.hy==''}">全部</c:if>
								<c:if test="${fxrw.hy!=''}">${fxrw.hy}</c:if>
							</div>
							<div class="zhedie"><a href="javascript:void(0)">展开</a></div>
						</td>
					</tr>
					<tr>
						<td>主管税务机关:</td>
						<td>
						<div class="danDiv">
								<c:if test="${fxrw.hy==''}">全部</c:if>
								<c:if test="${fxrw.hy!=''}">${fxrw.swjgCjMc}</c:if>
							</div>
							<div class="zhedie"><a href="javascript:void(0)">展开</a></div>
						</td>
					</tr>
					<tr>
						<td>登记注册类型:</td>
						<td>
							<div class="danDiv">
								<c:if test="${fxrw.djzclx==''}">全部</c:if>
								<c:if test="${fxrw.djzclx!=''}">${fxrw.djzclx}</c:if>
							</div>
							<div class="zhedie"><a href="javascript:void(0)">展开</a></div>
						</td>
					</tr>
					<tr>
						<td>核算方式:</td>
						<td>
							<c:if test="${fxrw.hsfsmc==''}">全部</c:if>
							<c:if test="${fxrw.hsfsmc!=''}">${fxrw.hsfsmc}</c:if>
						</td>
					</tr>
					<tr>
						<td>企业规模:</td>
						<td>${fxrw.qygm}</td>
					</tr>
					<tr>
						<td>税款所属期:</td>
						<td>
							<c:if test="${(fxrw.sjkssj == '' || fxrw.sjkssj == null) && (fxrw.sjjssj == '' || fxrw.sjjssj == null)}">所有 </c:if>
							<c:if test="${(fxrw.sjkssj != null && fxrw.sjkssj != '') || (fxrw.sjjssj != null && fxrw.sjjssj != '')}">
								<fmt:formatDate value="${fxrw.sjkssj }" pattern="yyyy-MM"/>~<fmt:formatDate value="${fxrw.sjjssj }" pattern="yyyy-MM"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>任务阶段:</td>
						<td class="jieduan"><c:if test="${fxrw.jd == 0}">数据采集 </c:if><c:if test="${fxrw.jd == 1}">数据清洗</c:if><c:if test="${fxrw.jd == 2}">训练预测</c:if><c:if test="${fxrw.jd == 3}">结果处理</c:if><c:if test="${fxrw.jd == 4}">生成报告</c:if></td>
					</tr>
					<tr>
						<td>任务状态:</td>
						<td class="taskStatus"><c:if test="${fxrw.zt == 0}">待处理 </c:if><c:if test="${fxrw.zt == 1}">处理中</c:if><c:if test="${fxrw.zt == 2}">处理成功</c:if><c:if test="${fxrw.zt == 3}">处理失败</c:if></td>
					</tr>
					<c:if test="${fxrw.zt == 3}">
						<tr>
							<td>失败原因:</td>
							<td class="taskStatus">${fxrw.sbyy}</td>
						</tr>
					</c:if>
					<tr>
						<td>任务用时:</td>
						<td class="lostTime"></td>
					</tr>
				</tbody>
			</table>
				<div class="resultContent">
				<div class="right_content">
					 <div id="talbeContentDiv">
					 <div class="table-header">数据分布情况</div>
						<div id="economicsDiv">
							<table class="table table-striped table-bordered table-hover" id="dataMsg">
								<thead>
									<tr>
										<th>No.</th>
										<th>表名</th>
										<th>户数</th>
										<th>指标数</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${dataList}" var="p" varStatus='status'>
										<tr>
											<td>${status.index+1 }</td>
											<td>${p.BZWM }</td>
											<td>${p.HS }</td>
											<td>${p.ZBS }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
		</div>
			
			
		</div>
	</div>
</div>
<input type="hidden" value="${fxrw.cjsj }" id="startTime">
<input type="hidden" value="${fxrw.gxsj }" id="endTime">
<script>
		var oTable1 =$('#dataMsg').DataTable( {
				bStateSave: false,
				bAutoWidth: false,
				"aaSorting": [],
				"aoColumnDefs": [
					{
					 sDefaultContent: '',
					 aTargets: [ '_all' ]
					  }
					],
		    } );
		
	</script>
<script>

$(function(){
	var oTable1 =$('#resultDetailList').dataTable( {
			bStateSave: true,
			bAutoWidth: false,
			"aaSorting": [],
			"aoColumnDefs": [
				{
				 sDefaultContent: '',
				 aTargets: [ '_all' ]
				  }
				],
	    } );
});
$(".detailGoBack").click(function(){
	window.location.href="${ctxPath}/v1/html/analyse/taskManage/list.do";
});




function intervalTime(){
	
}
showtime();
function showtime() {
	var startTime = $("#startTime").val();
	var endTime = $("#endTime").val();
	//new Date(endTime.substr(0,10)+"T"+endTime.substr(11,8));
	Today = new Date(startTime.substr(0,10)+"T"+startTime.substr(11,8)); 
	//开始时间
	var NowHour = Today.getHours(); 
	var NowMinute = Today.getMinutes(); 
	var NowMonth = Today.getMonth(); 
	var NowDate = Today.getDate(); 
	var NowYear = Today.getYear(); 
	var NowSecond = Today.getSeconds();
	//结束时间
	EndToday = new Date(endTime.substr(0,10)+"T"+endTime.substr(11,8)); 
	var endHour = EndToday.getHours(); 
	var endMinute = EndToday.getMinutes(); 
	var endMonth = EndToday.getMonth(); 
	var endDate = EndToday.getDate(); 
	var endYear = EndToday.getYear(); 
	var endSecond = EndToday.getSeconds();
	if (NowYear <2000){
		NowYear=1900+NowYear; 
	} 
	Today = null; 
	Hourleft = endHour - NowHour;
	Minuteleft = endMinute - NowMinute;
	Secondleft = endSecond - NowSecond;
	Yearleft = endYear - endYear;
	Monthleft = endMonth - NowMonth;
	Dateleft = endDate - NowDate;
	if (Secondleft<0){ 
		Secondleft=60+Secondleft; 
		Minuteleft=Minuteleft-1; 
	} 
	if (Minuteleft<0){ 
		Minuteleft=60+Minuteleft; 
		Hourleft=Hourleft-1; 
	} 
	if (Hourleft<0){ 
		Hourleft=24+Hourleft; 
		Dateleft=Dateleft-1; 
	} 
	if (Dateleft<0){ 
		Dateleft=31+Dateleft; 
		Monthleft=Monthleft-1; 
	} 
	if (Monthleft<0){ 
		Monthleft=12+Monthleft; 
		Yearleft=Yearleft-1; 
	}
	if($(".jieduan").html().indexOf("生成报告")>=0&&($(".taskStatus").html().indexOf("成功")>=0||$(".taskStatus").html().indexOf("失败")>=0)){
		Temp=Dateleft+'天'+Hourleft+'小时'+Minuteleft+'分钟'; 
	}else{
		Temp='--天--小时--分钟'; 
	}
	$(".lostTime").html(Temp);
}
$(".zhedie a").click(function(){
	if($(this).parent().prev().attr("class").indexOf("danDiv")>=0){
		$(this).parent().prev().removeClass("danDiv");
		$(this).html("收起");
	}else{
		$(this).parent().prev().addClass("danDiv");
		$(this).html("展开");
	}
});
</script>
</body>

</html>
