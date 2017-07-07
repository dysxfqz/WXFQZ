<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" buffer="64kb"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<html>
<head>
<title><decorator:title default="中数博阳" /></title>
<decorator:head />
<jsp:include page="../../static/inc/header.jsp" />
</head>
<body class="no-skin" style="min-width:1024px">
<jsp:include page="../../static/inc/header_menu.jsp" />
<!-- Start: Content -->
<div class="main-container" id="main-container">
<!--[if lte IE 8]>
<div id="ie8Tip">
	<div>
		<div>
			<img src="${ctxPath}/static/source/img/forie.png">
		</div>
	</div>
</div>
<![endif]-->
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>
	<jsp:include page="../../static/inc/menu.jsp" />
	<div class="main-content">
		<div class="main-content-inner">
			<decorator:body />
		</div>
	</div>
	</div>	
</body>
</html>
