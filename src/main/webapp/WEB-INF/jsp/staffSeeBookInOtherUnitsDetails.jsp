<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
    Book book = (Book) request.getAttribute("book");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>

    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css">
</head>

<body>
  <input name="safe" type="hidden" value="<%= staff.getUserName() %>">

<div class="container">
	<h2>图书详细信息</h2>
 	<form action="/book?method=staffReturnBookInOtherUnitList" method="post">  
	    
	    <div class="user-info">
	    	<div class="info-item"><span class="info-label">编号:</span> <%= book.getBookId() %></div>
	        <div class="info-item"><span class="info-label">书名:</span> <%= book.getBookName() %></div>
	        <div class="info-item"><span class="info-label">出版时间:</span> <%= book.getOutTime() %></div>
	        <div class="info-item"><span class="info-label">作者:</span> <%= book.getAuthorName() %></div>
	        <div class="info-item"><span class="info-label">出版社:</span> <%= book.getPress() %></div>
	        <div class="info-item"><span class="info-label">页数:</span> <%= book.getPageNumber() %></div>
	        <div class="info-item"><span class="info-label">价格:</span> <%= book.getPrice() %></div>
	        <div class="info-item"><span class="info-label">类别:</span> <%= book.getType() %></div>
	        <div class="info-item"><span class="info-label">所属单位:</span> <%= book.getWhichUnit() %></div>
	       	<div class="info-item"><span class="info-label">所在单位:</span> <%= book.getNowWhere() %></div>
	        <div class="info-item"><span class="info-label">剩余数量:</span> <%= book.getLeft() %></div>
	    </div> <br>
	    	
	    <div class="form-group">
	    	<input type="submit" value="返回">
	    </div>
    </form>
</div>
</body>
</html>
