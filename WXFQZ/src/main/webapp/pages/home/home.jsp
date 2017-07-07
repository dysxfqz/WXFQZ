<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>首页功能模块</title>
<link rel="stylesheet" href="${ctxPath}/static/source/style/tableInfo.css">
<link rel="stylesheet" href="${ctxPath}/static/source/style/animate.min.css">
<link rel="stylesheet" type="text/css" href="${ctxPath}/static/source/widget/css/jquery.gridster.min.css">
</head>
<body>
	<div class="col-xs-12">
		<div class="indexBtn">
			<a href="${ctxPath}/v1/html/modelBuild/newMission/add.do">新建任务</a>
			<a href="${ctxPath}/v1/html/modelBuild/missionTrack/list.do">任务跟踪</a>
			<a href="${ctxPath}/v1/html/modelBuild/modelResult/list.do">模型结果</a>
		</div>
	<div class="gridster">
		<div class="gridster">
			<ul style="padding:0">
			<li style="width:850px;" data-row="<c:if test='${cookie.zsdatarow0==null}'>1</c:if><c:if test='${cookie.zsdatarow0!=null}'>${cookie.zsdatarow0.value}</c:if>" data-col="<c:if test='${cookie.zsdatacol0==null}'>1</c:if><c:if test='${cookie.zsdatacol0!=null}'>${cookie.zsdatacol0.value}</c:if>" data-sizex="<c:if test='${cookie.zsdatasizex0==null}'>11</c:if><c:if test='${cookie.zsdatasizex0!=null}'>${cookie.zsdatasizex0.value}</c:if>" data-sizey="<c:if test='${cookie.zsdatasizey0==null}'>3</c:if><c:if test='${cookie.zsdatasizey0!=null}'>${cookie.zsdatasizey0.value}</c:if>">
				<div class="gridsterHeader">
					<div class='dragsty'>任务进度</div>
					<a href="${ctxPath}/v1/html/modelBuild/missionTrack/list.do" class="progessMore">更多</a>
				</div>
				<div class="widgetDiv">
				<c:forEach items="${executeList}" var="bean" varStatus='status'>
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
			</li>
			<li style="width:850px;" data-row="<c:if test='${cookie.zsdatarow1==null}'>4</c:if><c:if test='${cookie.zsdatarow1!=null}'>${cookie.zsdatarow1.value}</c:if>" data-col="<c:if test='${cookie.zsdatacol1==null}'>1</c:if><c:if test='${cookie.zsdatacol1!=null}'>${cookie.zsdatacol1.value}</c:if>" data-sizex="<c:if test='${cookie.zsdatasizex1==null}'>11</c:if><c:if test='${cookie.zsdatasizex1!=null}'>${cookie.zsdatasizex1.value}</c:if>" data-sizey="<c:if test='${cookie.zsdatasizey1==null}'>3</c:if><c:if test='${cookie.zsdatasizey1!=null}'>${cookie.zsdatasizey1.value}</c:if>">
			<div class="gridsterHeader">
					<div class='dragsty'>告警信息</div>
					<a href="${ctxPath}/v1/html/logManage/alarm/log.do" class="progessMore">更多</a>
				</div>
				<div class="widget-box">
						<div class="widget-body">
							<div class="widget-main no-padding">
								<!-- #section:pages/dashboard.conversations -->
								<div class="dialogs">
									<c:forEach items="${esAlarmLogList}" var="p" varStatus="status">
										<div class="itemdiv dialogdiv">
											<div class="user"><fmt:formatDate value="${p.alarmTime }" pattern="yyyy-MM-dd"/><span class="positionPoint"></span></div>
											<div class="body">
												<div class="text">${p.alarmContent}</div>
												<div class="tools">
													<i class="fa fa-exclamation-triangle" aria-hidden="true" style="color:<c:if test='${p.alarmLevel==2}'>blue</c:if><c:if test='${p.alarmLevel==1}'>orange</c:if><c:if test='${p.alarmLevel==0}'>red</c:if>"></i>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div><!-- /.widget-main -->
						</div><!-- /.widget-body -->
					</div><!-- /.widget-box -->
			</li>
			</ul>
		</div>
		<!-- <button id="upload">上传位置</button> -->
	</div>
	</div>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/jquery.collision.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/jquery.coords.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/jquery.draggable.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/jquery.gridster.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/utils.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/jquery.gridster.extras.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/cufon-yui.js"></script>
<script type="text/javascript" src="${ctxPath}/static/source/widget/js/voxBOX_400.font.js"></script>
	<script type="text/javascript">
	$(function(){
		 $("[data-toggle='tooltip']").tooltip();
			
		    //初始化Gridster对象
		    gridster = new Gridster($(".gridster ul"),{    //通过jquery选择DOM实现gridster
	            widget_base_dimensions: [100, 120],    //模块的宽高 [宽,高]
	            widget_margins: [5, 5],    //模块的间距 [上下,左右]
	            draggable: {
	              handle: '.dragsty'    //模块内定义拖动的元素
	            },
	            //设置resize句柄
		    resize:{
		       enabled: 'true',//允许放缩
		       handle:'.resize'//html标签的css类名，按住此标签可以对网格进行放缩
		    },
		    //设置serialize()方法的返回值
			serialize_params: function($w, wgd) {//$w为要输出位置的网格对象（li），wgd为该网格对象的坐标对象，包括col，row，size                                                     //_x,size_y四个成员
				return { col: wgd.col, 
					 row: wgd.row, 
					 size_x: wgd.size_x, 
					 size_y: wgd.size_y,
				         url:$w.find("a").attr("href"), //这里对官网的样例进行了扩展，不仅上传坐标信息，还上传了url和title
				         title:$w.find("a").html()
					} 
			},
				
	        });
	});
	$('ul').on("click",".close",function(){
		   gridster.remove_widget( $(this).parents("li"));
		});
	$("#upload").click(function(){
		$(".gridster").find("li").each(function(i,p){
			 setCookie('zsdatarow'+i,$(p).attr("data-row"),1000);
			setCookie('zsdatacol'+i,$(p).attr("data-col"),1000);
			setCookie('zsdatasizex'+i,$(p).attr("data-sizex"),1000);
			setCookie('zsdatasizey'+i,$(p).attr("data-sizey"),1000); 
	 	});
	});
	</script>
</body>
</html>