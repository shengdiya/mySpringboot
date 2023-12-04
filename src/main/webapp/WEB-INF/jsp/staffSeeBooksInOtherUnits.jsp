<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	List<Book> books = (List<Book>) request.getAttribute("booksAllowed");
	User staff = (User) request.getSession().getAttribute("staff");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看其它单位书籍</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
    <style>
        .submitbuttom{
        	background-color: #5cb85c;
		    color: white;
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    margin: 5px; 
        }
    </style>
</head>
<!-- 图书名、图书编号、出版时间、作者、出版社、图书分类、页数、价格、借阅状态 -->
<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
<h2>查看其它单位书籍</h2>
<table class="table-style">
    <tr>
        <th>编号</th>
        <th>书名</th>
        <th>作者</th>
        <th>类别</th>
        <th>价格</th>
        <th>所在单位</th>
        <th>流通状态</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < books.size(); i++) {
        Book book = books.get(i);
    %>
        <tr>
            <td><%= book.getBookId() %></td>
            <td><%= book.getBookName() %></td>
            <td><%= book.getAuthorName() %></td>
            <td><%= book.getType() %></td>
            <td><%= book.getPrice() %></td>
            <td><%= book.getNowWhere() %></td>
            <td><%= book.isIsflowed() ? "已流出" : "未流出" %></td>
            <td>
           	 	<a href="/book/staffSeeBookInOtherUnitsDetails?bookId=<%= book.getBookId() %>" 
                	class="action-button detail-button">详情</a>
                	
	            <a href="/book/staffRequestNext?bookId=<%= book.getBookId() %>" 
	            	class="action-button edit-button">请求</a>
            </td>
        </tr>
    <% } %>
</table> 
        <form action="/book?method=goBackToStaffIndex" method="post" >
             <input type="submit" value="返回" class="submitbuttom">
        </form>
</body>
</html>
