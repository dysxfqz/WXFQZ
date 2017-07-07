<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp"%>
<div id="navbar" class="navbar navbar-default navbar-fixed-top">
	<script type="text/javascript">
		try {
			ace.settings.check('navbar', 'fixed')
		} catch (e) {
		}
	</script>

	<div class="navbar-container" id="navbar-container">
		<!-- #section:basics/sidebar.mobile.toggle -->
		<button type="button" class="navbar-toggle menu-toggler pull-left"
			id="menu-toggler" data-target="#sidebar">
			<span class="sr-only">Toggle sidebar</span> <span class="icon-bar"></span>

			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>

		<!-- /section:basics/sidebar.mobile.toggle -->
		<div class="navbar-header pull-left">
			<!-- #section:basics/navbar.layout.brand -->
			<a href="${ctxPath}/v1/html/fxhome.do" class="navbar-brand"> <small><img src="${ctxPath}/static/source/img/shuiLogo.png" style="width: 37px;margin-top: 6px; margin-bottom: -7px;margin-right: 5px;"><img src="${ctxPath}/static/source/img/logo.png" style="margin-top: 13px;width: 600px;" alt="北京中数博阳信息技术有限公司">
			</small>
			</a>
		</div>

		<!-- #section:basics/navbar.dropdown -->
		<div class="navbar-buttons navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav">
				<!-- #section:basics/navbar.user_menu -->
				<li class="light-blue"><a data-toggle="dropdown" href="#"
					class="dropdown-toggle"> 
					<img class="nav-user-photo" id="img1" 
					<c:if test="${showHeadUrl == null || showHeadUrl == ''}">
						src="${ctxPath}/static/ace/avatars/user.jpg" 
					</c:if>
					<c:if test="${showHeadUrl != null}">
						src="${filePath}/${showHeadUrl}" 
					</c:if>
					alt="Jason's Photo" />
						<span class="user-info"> 
						<small>欢迎您</small> 
						<span id="header_user_name">${showUserName}</span>
					</span> <i class="ace-icon fa fa-caret-down"></i>
				</a>
					<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						<!-- <li>
									<a href="#">
										<i class="ace-icon fa fa-cog"></i>
										Settings
									</a>
								</li> -->

<%-- 						<li><a href="${ctxPath}/v1/html/user/basicData/query/userInfo.do"> <i class="ace-icon fa fa-user"></i> 个人资料</a></li> --%>

<!-- 						<li class="divider"></li> -->

						<li><a href="${ctxPath}/v1/anon/user/query/logout.do"> <i
								class="ace-icon fa fa-power-off"></i> 退出
						</a></li>
					</ul></li>

				<!-- /section:basics/navbar.user_menu -->
			</ul>
		</div>

		<!-- /section:basics/navbar.dropdown -->
	</div>
	<!-- /.navbar-container -->
</div>