<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp"%>
<style>
	.ace-nav{
		height:auto;
	}
</style>
<!-- #section:basics/sidebar -->
<div id="sidebar" class="sidebar responsive sidebar-fixed">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>


	<input type="hidden" value="${fatherMenuId}" id="fatherMenuId">
	
	<ul class="nav nav-list" id="sideNavList">

	<c:forEach items="${systemMenuList }" var="bean">
		<shiro:hasPermission name="${bean.userPermission.name }">
		<li class="" id="${bean.htmlId }">
			<a href="<c:if test='${bean.children.size()!=0}'>#</c:if><c:if test='${bean.children.size()==0}'>${ctxPath}${bean.userPermission.url}</c:if>" <c:if test="${bean.children.size()!=0}">class="dropdown-toggle"</c:if>>
				<i class="${bean.htmlClass }"></i>
				<span class="menu-text">${bean.name }</span>
				<c:if test="${bean.children.size()!=0}"><b class="arrow fa fa-angle-down"></b></c:if>
			</a>
 			<c:if test="${bean.children.size()!=0}">
				<b class="arrow"></b>
				<ul class="submenu">
					<c:forEach items="${bean.children }" var="pean">
						<shiro:hasPermission name="${pean.userPermission.name }">
							<li class="" id="${pean.htmlId }">
								<a href="<c:if test='${pean.children.size()!=0}'>#</c:if><c:if test='${pean.children.size()==0}'>${ctxPath}${pean.userPermission.url}</c:if>" <c:if test="${pean.children.size()!=0}">class="dropdown-toggle"</c:if>>
									<i class="${pean.htmlClass }"></i>${pean.name }
 									<c:if test="${pean.children.size()!=0}"><b class="arrow fa fa-angle-down"></b></c:if>
								</a>
								<c:if test="${pean.children.size()!=0}">
								<b class="arrow"></b>
								<ul class="submenu">
									<c:forEach items="${pean.children }" var="cean">
										<shiro:hasPermission name="${cean.userPermission.name }">
											<li class="" id="${cean.htmlId }">
												<a href="${ctxPath}${cean.userPermission.url}">
													<i class="${cean.htmlClass }"></i>${cean.name }
												</a>
											</li>
										</shiro:hasPermission>
									</c:forEach>
								</ul>
								</c:if>
							</li>
						</shiro:hasPermission>
					</c:forEach>
				</ul>
 				</c:if> 
		</li>
		</shiro:hasPermission>
	</c:forEach>
	</ul><!-- /.nav-list -->

	<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
		<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
	</div>

	<!-- /section:basics/sidebar.layout.minimize -->
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
		//判断哪个菜单栏为选中状态
		
		var allMenuId = $("#fatherMenuId").val(); 
		var allMenu =allMenuId.split("|");
		
		var fatherMenuId =allMenu[0];
		var childMenuId=allMenu[1];
		var grabdChildMenuId = allMenu[2];
		var menuArray = new Array();
		var id="";
		var chilId="";
		var grandChildId = "";
		menuArray = $("#sideNavList").children("li");
		for(var i=0;i<menuArray.length;i++){
			id=$(menuArray[i]).attr("id");
			//console.log(id);
			$(menuArray[i]).removeClass("active");
			$(menuArray[i]).removeClass("open");
			if(fatherMenuId==id){
				$("#"+id).addClass("active");
				var gdChil = $($("#"+id).children("ul")[0]).children("li");
				if(gdChil.length>0){
					$("#"+id).addClass("open");
					for(var x=0;x<gdChil.length;x++){
						chilId = $(gdChil[x]).attr("id");
						$(gdChil[x]).removeClass("active");
						if(childMenuId==chilId){
							$(gdChil[x]).addClass("active");
							var grandChil = $($("#"+chilId).children("ul")[0]).children("li");
							if(grandChil.length>0){
								$("#"+chilId).addClass("open");
								for(var x=0;x<grandChil.length;x++){
									grandChildId = $(grandChil[x]).attr("id");
									$(grandChil[x]).removeClass("active");
									if(grabdChildMenuId==grandChildId){
										$(grandChil[x]).addClass("active");
									}
								}
							}
						}
					}
				}
			}
		}
		
	</script>
</div>