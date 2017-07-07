<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../static/inc/taglib.jsp"%>
<!DOCTYPE>  
<html>  
    <head>  
        <title>404</title>  
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <style>
        	.errorContent{
        	    text-align: center;
			    margin-top: 100px;
			    margin-bottom: 110px;
			    position: relative;
			 }
			 .otherPage{
			 	margin-top:50px;
			 }
			 .otherPage a{margin-left:30px;margin-right:30px}
        </style>
    </head>  
    <body>
    	<div class="errorContent">
	        <div>
		        <img src="${ctxPath}/static/source/img/404.png" style="max-width:100%"/>
	        
	        </div>
			<div class="otherPage">
				<a href="${ctxPath}/v1/html/user/basicData/query/userInfo.do">返回首页</a>
				<a href="javascript:window.history.back()">返回上一页</a>
			</div>	
    	</div> 
    </body>  
</html>  