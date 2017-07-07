<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="taglib.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit">
<meta charset="utf-8" />
<link rel="shortcut icon" type="image/x-icon" href="${ctxPath}/static/source/img/favicon.ico">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="format-detection" content="telephone=no" />
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    

    	<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/font-awesome.css" />



		<!-- page specific plugin styles -->
		<link rel="stylesheet" href="${ctxPath}/static/source/style/global.css" />
		<link rel="stylesheet" href="${ctxPath}/static/source/style/showBo.css" />

		<!-- text fonts -->
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-fonts.css" />

		<!-- page specific plugin styles -->
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/jquery-ui.custom.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/chosen.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/datepicker.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap-timepicker.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/daterangepicker.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/bootstrap-datetimepicker.css" />
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/colorpicker.css" />
		
		<!-- ace styles -->
		<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-part2.css" class="ace-main-stylesheet" />
		<![endif]-->

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="${ctxPath}/static/ace/css/ace-ie.css" />
		<![endif]-->
		<!-- change ace style-->
<link rel="stylesheet" href="${ctxPath}/static/source/style/changeace.css" />
		<!-- inline styles related to this page -->
<script src='${ctxPath}/static/ace/js/jquery.min.js'></script>
<script src='${ctxPath}/static/source/js/cookie.js'></script>
<script src="${ctxPath}/static/source/js/jquery.form.js"></script>
		<!-- ace settings handler -->
		<script src="${ctxPath}/static/ace/js/ace-extra.js"></script>

		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

		<!--[if lte IE 8]>
		<script src="${ctxPath}/static/ace/js/html5shiv.js"></script>
		<script src="${ctxPath}/static/ace/js/respond.js"></script>
		<![endif]-->
		
		<!-- basic scripts -->

		<!--[if !IE]> -->
		<!-- <script type="text/javascript">
			window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery.min.js'>"+"<"+"/script>");
		</script>
 -->
		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='${ctxPath}/static/ace/js/jquery1x.js'>"+"<"+"/script>");
</script>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='${ctxPath}/static/ace/js/jquery.mobile.custom.js'>"+"<"+"/script>");
		</script>
		<script src="${ctxPath}/static/ace/js/bootstrap.js"></script>
<script src="${ctxPath}/static/source/js/showBo.js"></script>
		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="${ctxPath}/static/ace/js/excanvas.js"></script>
		<![endif]-->
		<script src="${ctxPath}/static/ace/js/jquery-ui.custom.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.ui.touch-punch.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.easypiechart.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.sparkline.js"></script>
		<script src="${ctxPath}/static/ace/js/flot/jquery.flot.js"></script>
		<script src="${ctxPath}/static/ace/js/flot/jquery.flot.pie.js"></script>
		<script src="${ctxPath}/static/ace/js/flot/jquery.flot.resize.js"></script>
		
		<script src="${ctxPath}/static/ace/js/chosen.jquery.js"></script>
		<script src="${ctxPath}/static/ace/js/bootbox.js"></script>
		<script src="${ctxPath}/static/ace/js/fuelux/fuelux.spinner.js"></script>
		<script src="${ctxPath}/static/ace/js/date-time/bootstrap-datepicker.js"></script>
		<script src="${ctxPath}/static/ace/js/date-time/bootstrap-timepicker.js"></script>
		<script src="${ctxPath}/static/ace/js/date-time/moment.js"></script>
		<script src="${ctxPath}/static/ace/js/date-time/daterangepicker.js"></script>
		<script src="${ctxPath}/static/ace/js/date-time/bootstrap-datetimepicker.js"></script>
		<script src="${ctxPath}/static/ace/js/bootstrap-colorpicker.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.knob.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.autosize.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.inputlimiter.1.3.1.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.maskedinput.js"></script>
		<script src="${ctxPath}/static/ace/js/bootstrap-tag.js"></script>
		
		
		
		<script src="${ctxPath}/static/ace/js/jquery.dataTables.js"></script>
		<script src="${ctxPath}/static/ace/js/jquery.dataTables.bootstrap.js"></script>
		



		<!-- ace scripts -->
		<script src="${ctxPath}/static/ace/js/ace/elements.scroller.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.colorpicker.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.fileinput.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.typeahead.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.wysiwyg.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.spinner.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.treeview.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.wizard.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/elements.aside.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.ajax-content.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.touch-drag.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.sidebar.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.sidebar-scroll-1.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.submenu-hover.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.widget-box.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.settings.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.settings-rtl.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.settings-skin.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.widget-on-reload.js"></script>
		<script src="${ctxPath}/static/ace/js/ace/ace.searchbox-autocomplete.js"></script>
<script>
//fck路径
var fckPath="${ctxPath}/static/";
</script>