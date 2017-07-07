<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>My JSP 'updatePersonForm.jsp' starting page</title>
  </head>
  <body>
   <form action="<%=path %>/v1/html/user/update/saveUpdateUser.do" method="post">
   	<input type="hidden" value="${user.id }" name="id"><br>
   	userName:<input type="text" value="${user.userName }" name="userName"><br>
   	password:<input type="text" value="${user.password }" name="password"><br>
   	<input type="submit" value="submit">
   </form>
  </body>
</html>
