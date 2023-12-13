<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");User user = (User) request.getAttribute("user");
    UserService userservice = (UserService) request.getAttribute("userservice");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>

    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<div class="container">
	<h2>用户详细信息</h2>
	<!-- 在发送POST请求的时候，表单的action属性会被解析为相对路径， -->
	<!-- 提交表单后得到的URL为localhost:8888/user/user?method=returnUserList,而非localhost:8888/user?method=returnUserList -->
	<!-- 解决方法为直接使用/开头的绝对路径来修正action属性 -->
 	<form action="/user?method=returnUserList" method="post">  
	    <img src="<%= user.getPicturePath() %>" alt="User Avatar" class="user-avatar"/>
	    <div class="user-info">
	        <div class="info-item"><span class="info-label">Username:</span> <%= user.getUserName() %></div>
	        <div class="info-item"><span class="info-label">Real Name:</span> <%= user.getRealName() %></div>
	        <div class="info-item"><span class="info-label">Sexy:</span> <%= user.getSexy() %></div>
	        <div class="info-item"><span class="info-label">Phone:</span> <%= user.getTelephone() %></div>
	        <div class="info-item"><span class="info-label">Email:</span> <%= user.getEmail() %></div>
	        <div class="info-item"><span class="info-label">Address:</span> <%= user.getAddress() %></div>
	        <div class="info-item"><span class="info-label">Last Login:</span> <%= user.getLastTimeLogin() %></div>
	        <div class="info-item"><span class="info-label">status:</span> <%= user.getStatus() %></div>
	        
	        <!-- 如果是工作人员，还要显示他的工作单位 -->
	        <% 
			    String roleName = userservice.getUserRole(user.getUserId());
			    if(roleName.equals("staff")) { %>
			        <div class="info-item"><span class="info-label">Unit:</span> <%= user.getWhichUnit() %></div>
			<% } %>
			
	    </div> <br>
	    	
	    <div class="form-group">
	    	<input type="submit" value="返回">
	    </div>
    </form>
</div>
</body>
</html>
