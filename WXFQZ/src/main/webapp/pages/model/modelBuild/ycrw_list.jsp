<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>任务跟踪</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
</head>
<body>
	<div class="col-xs-12">
	<div class="header smaller lighter blue">
			<h1>任务跟踪</h1>
	</div>
	<div class="widgetDiv">
		<c:forEach items="${ycrwList}" var="bean" varStatus='status'>
				<div class="row">
	           	<span class="widgetMc">${bean.mc}</span>
	            <span class="rightCirContent">
	           		<span class="proCircle">
	           			<span class="progessCircle zhuan <c:if test='${(bean.jd== 0 && bean.zt<2)||(bean.jd+1== 0 && bean.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${bean.jd >0 || (bean.zt==2 && bean.jd ==0)}'>active</c:if> <c:if test="${bean.zt==3 && bean.jd ==0}"> circleError</c:if>">1</span><br>
			           	<span class="progessTitle">数据采集</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars" style="height:6px">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${bean.jd >1 ||(bean.zt==2&&bean.jd>0)}'>default</c:if><c:if test='${(bean.jd== 1 && bean.zt<2)||(bean.jd+1== 1 && bean.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${bean.jd >1 ||(bean.zt==2&&bean.jd>0)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${(bean.jd== 1 && bean.zt<2)||(bean.jd+1== 1 && bean.zt==2)}'>active</c:if>" style="position:absolute"></span>
		          	 	<span class="progessCircle <c:if test='${bean.jd >1 || (bean.zt==2 && bean.jd ==1)}'>active</c:if><c:if test="${bean.zt==3 && bean.jd ==1}"> circleError</c:if>">2</span><br>
		           		<span class="progessTitle">数据清洗</span>
	           		</span>
	           		<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${bean.jd >2  ||(bean.zt==2&&bean.jd>1)}'>default</c:if><c:if test='${(bean.jd== 2 && bean.zt<2)||(bean.jd+1== 2 && bean.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${bean.jd >2  ||(bean.zt==2&&bean.jd>1)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           	<span class="progessCircle zhuan <c:if test='${(bean.jd== 2 && bean.zt<2)||(bean.jd+1== 2 && bean.zt==2)}'>active</c:if>" style="position:absolute"></span>
			           	<span class="progessCircle <c:if test='${bean.jd >2 || (bean.zt==2 && bean.jd ==2)}'>active</c:if><c:if test="${bean.zt==3 && bean.jd ==2}"> circleError</c:if>">3</span><br>
			           		<span class="progessTitle">训练预测</span>
		           	</span>
		           	<span class="progessSpan">
			           	<span class="progessBars">
				           	<div class="progress progress-striped pos-rel">
								<div class="progress-bar  <c:if test='${bean.jd >3  ||(bean.zt==2&&bean.jd>2)}'>default</c:if> <c:if test='${(bean.jd== 3 && bean.zt<2)||(bean.jd+1== 3 && bean.zt==2)}'> active</c:if>" style="width:100%"></div>
							</div>
			           	</span>
			           	<span class="rightArrow <c:if test='${bean.jd >3  ||(bean.zt==2&&bean.jd>2)}'>default</c:if>"></span>
		           	</span>
		           	<span class="proCircle">
		           		<span class="progessCircle zhuan <c:if test='${bean.jd== 3 && bean.zt<2}'>active</c:if>" style="position:absolute"></span>
		           		<span class="progessCircle <c:if test='${bean.jd >3 || (bean.zt==2 && bean.jd ==3)}'>active</c:if> <c:if test="${bean.zt==3 && bean.jd ==3}"> circleError</c:if>">4</span><br>
		           		<span class="progessTitle">结果处理</span>
		           	</span>
	           	</span>
			</div>
		</c:forEach>
			</div>
	</div>
<script src="${ctxPath}/static/source/js/dragWindow.js"></script>
	<script type="text/javascript">
	$(function(){
		 $("[data-toggle='tooltip']").tooltip();
		var oTable1 =$('#menuList').dataTable( {
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
	function resizeIsoAlert(){
		 var isoAlert = {height:0,width:0,left:0,top:0};
		 isoAlert.height = $(".iso_alertKuang").height();
		 isoAlert.width = $(".iso_alertKuang").width();
		 isoAlert.top = (document.documentElement.clientHeight- isoAlert.height)/2;
		 if(document.documentElement.clientWidth<768){
			 isoAlert.left = 0;
		 }else{
			 isoAlert.left = (document.documentElement.clientWidth- isoAlert.width)/2;
		 }
		 $(".iso_alertKuang").css({
			 left:isoAlert.left,
			 top:isoAlert.top
		 });
	}
	 $(window).resize(function(){
		 resizeIsoAlert();
	 });
	//删除任务
	$('.iso_alertKuang').drag();
	function deleteTask(el,rwh){
		var taskStatus = $(el).parent().parent().find(".taskStatus").html();
		var jieduan = $(el).parent().parent().find(".jieduan").html();
		Showbo.Msg.confirm("您确定要删除该任务吗",function(){
			 if($(".btnfocus").val() =="确定"){
				 if(taskStatus.indexOf("待处理")>=0&&jieduan.indexOf("数据采集")>=0){
						$.ajax({
							url:"${ctxPath}/v1/html/task/predict/delete.do",
							dataType:"json",
							type:"post",
							data:{taskId:rwh},
							success:function(data){
								if(data.result=="ok"){
									Showbo.Msg.alert("删除成功",function(){
										window.location.reload();
									});
								}else{
									Showbo.Msg.alert(data.errormsg);
								}
							},
							error:function(){
								Showbo.Msg.alert("服务器异常");
							}
						});
					}else{
						Showbo.Msg.alert("任务已经开始，无法删除");
					}
			}
		});
		
	}
	//弹出编辑框
	function editTask(rwh){
		$(".editTask").show();
		$(".iso_alert").show();
		resizeIsoAlert();
		$.ajax({
			url:"${ctxPath}/v1/html/task/predict/update.do",
			dataType:"json",
			type:"post",
			data:{taskId:rwh},
			success:function(data){
				if(data.result=="ok"){
					$("#taskNameInp").val(data.values.mc);
					$("#taskDecInp").val(data.values.ms);
					$("#editTaskBtn").attr("data-rwh",rwh);
					
				}else{
					Showbo.Msg.alert(data.errormsg);
				}
			},
			error:function(){
				Showbo.Msg.alert("服务器异常");
			}
		});
	}
	//关闭编辑框
	$("#closeEditTask").click(function(){
		$(".editTask").hide();
		$(".iso_alert").hide();
		$("#taskNameInp").val("");
		$("#taskDecInp").val("");
	});
	//提交修改
	$("#editTaskBtn").click(function(){
		var taskName = $("#taskNameInp").val();
		var taskDec = $("#taskDecInp").val();
		var rwh = $(this).attr("data-rwh");
		if(taskName==""){
			Showbo.Msg.alert("任务名称不能为空");
		}else{
			$.ajax({
				url:"${ctxPath}/v1/html/task/predict/confirmUpdate.do",
				dataType:"json",
				type:"post",
				data:{
					taskId:rwh,
					taskName:taskName,
					taskDesc:taskDec
				},
				success:function(data){
					if(data.result=="ok"){
						Showbo.Msg.alert("修改成功",function(){
							window.location.reload();
						});
					}else{
						Showbo.Msg.alert(data.errormsg);
					}
				},
				error:function(){
					Showbo.Msg.alert("服务器异常");
				}
			});
		}
	});
	</script>
</body>
</html>