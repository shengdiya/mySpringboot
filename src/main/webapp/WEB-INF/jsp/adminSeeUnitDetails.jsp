<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
    Unit unit = (Unit) request.getAttribute("unit");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>

    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
<div class="container">
	<h2>图书详细信息</h2>
 	<form action="/unit?method=returnUnitList" method="post">  
	    <div class="user-info">
	        <div class="info-item"><span class="info-label">单位名：</span> <%= unit.getUnitName() %></div>
	       	<div class="info-item"><span class="info-label">单位类别：</span> <%= unit.getUnitType() %></div>
	        <div class="info-item"><span class="info-label">联系人：</span> <%= unit.getContact() %></div>
	        <div class="info-item"><span class="info-label">联系电话：</span> <%= unit.getTelephone() %></div>
	        <div class="info-item"><span class="info-label">联系邮箱：</span> <%= unit.getEmail() %></div>
	        <div class="info-item"><span class="info-label">联系地址：</span> <%= unit.getAddress() %></div>
	    </div> <br>
	    	
	    <div class="form-group">
	    	<input type="submit" value="返回">
	    </div>
    </form>
</div>
</body>
</html>
