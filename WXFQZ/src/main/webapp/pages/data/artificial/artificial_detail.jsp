<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>数据源详情</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableView.css">
</head>
<body>
	<div class="col-xs-12">
		<div class="header smaller lighter blue">
			<h1>数据源详情</h1>
			<a href="${ctxPath}/v1/html/data/sampleData/peopleImport/list.do" class="detailGoBack">返回</a>
		</div>
		<div class="resultContent">
				<div class="right_content">
					 <div id="talbeContentDiv" style="position:relative">
					 	<div class="table-header">数据详情</div>
						<div id="economicsDiv"></div>
					</div>
				</div>
				<div class="ace-settings-container" id="ace-settings-container" style="top:0;">
					<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn" style="opacity:1">
						<i class="ace-icon fa fa-cog bigger-130"></i>
					</div>
			
					<div class="ace-settings-box clearfix" id="ace-settings-box" style="overflow-y:auto;">
						<div class="searchCon">
							<div class="searchTitle">显示的列 <span class="fa fa-angle-up angle"></span></div>
							<ul class="searchUl showSearch">
							</ul>
							<div class="searchTitle">隐藏的列<span class="fa fa-angle-down angle"></span></div>
							<ul class="searchUl hideSearch">
							</ul>
						</div>
					</div><!-- /.ace-settings-box -->
				</div><!-- /.ace-settings-container -->
		</div>
	</div>
	<div class="floatNumber">
		<ul>
			<li><span>最 小 值：</span><span id="minValue"></span></li>
			<li><span>一分位值：</span><span id="onebitValue"></span></li>
			<li><span>中 位 值：</span><span id="medianValue"></span></li>
			<li><span>平 均 值：</span><span id="averageValue"></span></li>
			<li><span>三分位值：</span><span id="threebitValue"></span></li>
			<li><span>最 大 值：</span><span id="maxValue"></span></li>
			<li><span>NA数量：</span><span id="NAcount"></span></li>
		</ul>
	</div>
	<input type="hidden" value='${colList}' id="colList">
	<input type="hidden" value='${mapList}' id="contentList">
	<input type="hidden" value='${maxCount}' id="maxCount">
	<input type="hidden" value='${sjyId}' id="sjyId">
	<script>
	var tableTh = "";
		$(document).mouseup(function(e){
			  var _con = $('#ace-settings-box');   // 设置目标区域
			  if(!_con.is(e.target) && _con.has(e.target).length === 0&&$("#ace-settings-btn").attr("class").indexOf("open")>=0){ // Mark 1
				  $('#ace-settings-btn').click()   // 功能代码
			  }
			});
		 $('#ace-settings-btn').on(ace.click_event, function(e){
				e.preventDefault();
				$(this).toggleClass('open');
				$('#ace-settings-box').toggleClass('open');
			 });
		var maxCount = $("#maxCount").val();
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
				"bMaxDataNumber":maxCount,
		    } );
		//提示工具
		 $("[data-toggle='tooltip']").tooltip(); 
		//日历工具
		 $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			})
			//show datepicker when clicking on the icon
			.next().on(ace.click_event, function(){
				$(this).prev().focus();
			});
		 $('.input-daterange').datepicker({autoclose:true,todayHighlight: true});

	
	
	var showCols = new Array();
	var hideCols = new Array();
	function rightContentWidth(){
		$(".right_content").css("width",$(".resultContent").width()-$(".left-content").width());
	}
	function tableWdith(){
		 $("#economicsDiv table th").each(function(i,p){
			var thWidth = $(p).html().length*20+16;
				$(p).css("min-width",thWidth);
		});
		 setTimeout(function(){
			$("#talbeContentDiv").css("width",$("#talbeContentDiv table").width());
		 },10);
	}
	$(".shousuoArrow .fa").click(function(){
		if($(this).attr("class").indexOf("active")>=0){
			$(this).removeClass("active");
			$(".left-content").width("20px");
			$(".searchCon").hide();
			rightContentWidth();
		}else{
			$(this).addClass("active");
			$(".left-content").width("200px");
			$(".searchCon").show();
			rightContentWidth();
		}
	});
	var mouseEnterLock = true;
	function initTableInfo(){
		var sjyId = $("#sjyId").val();
		$("#economicsDiv").html('<table class="table table-striped table-bordered table-hover" id="dataMsg"><thead></thead><tbody></tbody></table><div class="tableLodaing"><span class="fa fa-spinner fa-spin bigger-150"></span></div>');
		//table头信息
		tableTh = $("#colList").val();
		tableTh = eval("("+tableTh+")");
		var thContent='<tr>';
		var showurLiHtml = "";
		var hidurLiHtml = "";
		$.each(tableTh,function(i,p){
			thContent+='<th data-EngName='+p.english_name+'>'+p.chinese_name+'</th>';
			//thContent.push($(p).html());
			showurLiHtml+="<li data-showIndex='"+i+"'><span class='removeCol' onclick='removeCol(this)'>移除</span><span class='showColListName'>"+p.chinese_name+"</span</li>";
			hidurLiHtml+="<li data-showIndex='"+i+"'><span class='addCol' onclick='addCol(this)'>添加</span><span class='hiddenColListName'>"+p.chinese_name+"</p></li>";
		});
		$(".showSearch").html(showurLiHtml);
		$(".hideSearch").html(hidurLiHtml);
		thContent+='</tr>';
		$("#economicsDiv #dataMsg thead").html(thContent);
		var tdContent = $("#contentList").val();
		tdContent = eval("("+tdContent+")");
		var tdHtml = '';
		$.each(tdContent,function(i,p){
			var tempHtml = '<tr>';
			$.each(tableTh,function(m,n){
				var lieData = p[n.english_name];
				if(lieData == undefined) {
					lieData = '--';
				}
				tempHtml+='<td>'+lieData+'</td>';
			});
			tempHtml +='</tr>';
			tdHtml+=tempHtml;
		});
		 $("#economicsDiv #dataMsg tbody").html(tdHtml);
		 rightContentWidth();
		tableWdith();
		 oTable1 =$('#dataMsg').DataTable( {
			bStateSave: false,
			bAutoWidth: false,
			"aaSorting": [],
			"aoColumnDefs": [
				{
				 sDefaultContent: '',
				 aTargets: [ '_all' ]
				  }
				],
				"bMaxDataNumber":maxCount,
	    });
		$("#economicsDiv table th").mouseenter(function(e){
			if(mouseEnterLock){
				var enName = $(this).attr("data-EngName");
				mouseEnterLock = false;
 				$.ajax({
					url:"${ctxPath}/v1/html/data/sampleData/peopleImport/getData.do",
 					type:"post",
 					dataType:"json",
 					data:{
 						field:enName,
 						sjyId:sjyId
 					},
 					success:function(data){
 						if(data.result=="ok"){
 							if(!mouseEnterLock){
	 							$("#maxValue").html(data.values.max);
	 							$("#minValue").html(data.values.min);
	 							$("#averageValue").html(data.values.avg);
	 							$("#onebitValue").html(data.values.yifen);
	 							$("#threebitValue").html(data.values.sanfen);
	 							$("#medianValue").html(data.values.zhong);
	 							$("#NAcount").html(data.values.max);
	 							$(".floatNumber").show();
	 							var numberTop =e.clientY; 
	 							var numberLeft = e.clientX; 
	 							$(".floatNumber").css({"top":numberTop,"left":numberLeft});
 							}
 						}else{
 							//Showbo.Msg.alert(data.errormsg);
 						}
 						mouseEnterLock = true;
 					},
 					error:function(){
 						//Showbo.Msg.alert("服务器异常");
 						mouseEnterLock = true;
 					}
 				});
			}
		});
		$("#economicsDiv table th").mouseout(function(e){
			mouseEnterLock = true;
			$(".floatNumber").hide();
		});
	}
	initTableInfo();
	$(window).resize(function(){
		rightContentWidth();
		tableWdith();
	});
	$(".searchTitle").click(function(){
		if($(this).next().is(":visible")){
			$(this).find(".fa").addClass("fa-angle-down");
			$(this).find(".fa").removeClass("fa-angle-up");
		}else{
			$(this).find(".fa").removeClass("fa-angle-down");
			$(this).find(".fa").addClass("fa-angle-up");
		}
		$(this).next().slideToggle()
	});
	//点击移除按钮
	function removeCol(el){
		$("#talbeContentDiv").css("width","auto");
		var index = parseInt($(el).parent().attr("data-showIndex"));
		$(el).parent().hide();
		showCols[index]=0;
		hideCols[index]=1;
		oTable1.column(index).visible(false);
		var searchLi = $(".hideSearch li");
		$($(searchLi[index])).show();
		tableWdith();
	}
	function addCol(el){
		$("#talbeContentDiv").css("width","auto");
		var index = parseInt($(el).parent().attr("data-showIndex"));
		$(el).parent().hide();
		hideCols[index]=0;
		showCols[index]=1;
		var searchLi = $(".showSearch li");
		$($(searchLi[index])).show();
		oTable1.column(index).visible(true)
		tableWdith();
	}
	var batch = 0;
	var pageSize = 100;
	function loadNewData(el){
		var sjyId = $("#sjyId").val();
		if($(el).attr("class").indexOf("removeDisabled")>=0){
			batch++;
			$("#economicsDiv .tableLodaing").show();
			var  activePage = $("#economicsDiv .paginate_button.active a").html();
			 $.ajax({
				url:"${ctxPath}/v1/html/data/sampleData/peopleImport/getBatchData.do",
				type:"post",
				data:{
					batch:batch,
					pageSize:pageSize,
					sjyId:sjyId
				},
				dataType:"json",
				success:function(data){
					if(data.result=="ok"){
						//$("#economicsDiv table tbody").html("");
						$.each(data.values,function(i,p){
							var tempArray = [];
							$.each(tableTh,function(m,n){
								tempArray.push(p[n.english_name]);
							});
							oTable1.row.add(tempArray).draw(); 
						});
					}else{
						Showbo.Msg.alert(data.errormsg);
					}
					tableWdith();
					$("#economicsDiv .tableLodaing").hide();
					oTable1.page(parseInt(activePage)).draw(false);
				},
				error:function(){
					Showbo.Msg.alert('查询失败'); 
					//$(".gosearchBtn").html("搜索");
					//searchLock = true;
				}
			}); 
		}
	} 
	</script>
</body>

</html>