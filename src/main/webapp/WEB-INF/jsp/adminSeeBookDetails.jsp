<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Book book = (Book) request.getAttribute("book");
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
	<h2>图书详细信息</h2>
 	<form action="/book?method=returnBookList" method="post">  
	    <img src="<%= book.getPicturePath() %>" alt="User Avatar" class="user-avatar"/>
	    <div class="user-info">
	    	<div class="info-item"><span class="info-label">图书编号:</span> <%= book.getBookId() %></div>
	        <div class="info-item"><span class="info-label">图书名称:</span> <%= book.getBookName() %></div>
	        <div class="info-item"><span class="info-label">出版时间:</span> <%= book.getOutTime() %></div>
	        <div class="info-item"><span class="info-label">作者:</span> <%= book.getAuthorName() %></div>
	        <div class="info-item"><span class="info-label">出版社:</span> <%= book.getPress() %></div>
	        <div class="info-item"><span class="info-label">页数:</span> <%= book.getPageNumber() %></div>
	        <div class="info-item"><span class="info-label">价格:</span> <%= book.getPrice() %></div>
	        <div class="info-item"><span class="info-label">类别:</span> <%= book.getType() %></div>
	        <div class="info-item"><span class="info-label">剩余数量:</span> <%= book.getLeft() %></div>
	        <div class="info-item"><span class="info-label">所属单位:</span> <%= book.getWhichUnit() %></div>
	        <div class="info-item"><span class="info-label">所在单位:</span> <%= book.getNowWhere() %></div>
	        <div class="info-item"><span class="info-label">是否开放:</span> <%= book.isAllowed() == true ? "是" : "否" %></div>
	    </div> <br>
	    	
	    <div class="form-group">
	    	<input type="submit" value="返回">
	    </div>
    </form>
</div>
</body>
</html>
