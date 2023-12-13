<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	List<Book> books = (List<Book>) request.getAttribute("booksAllowed");
	User user = (User) request.getSession().getAttribute("reader");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
	<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<h2>借阅书籍</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>图书名称</th>
        <th>作者</th>
        <th>图书类别</th>
        <th>剩余数量</th>
        <th>所属单位</th>
        <th>所在单位</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < books.size(); i++) {
        Book book = books.get(i);
    %>
        <tr>
            <td><%= (i + 1) %></td>
            <td><%= book.getBookName() %></td>
            <td><%= book.getAuthorName() %></td>
            <td><%= book.getType() %></td>
            <td><%= book.getLeft() %></td>
            <td><%= book.getWhichUnit() %></td>
            <td><%= book.getNowWhere() %></td>
            <td>
                <a href="/book/readerSeeBookDetails?bookId=<%= book.getBookId() %>" 
                	class="action-button detail-button">详情</a>
                	
	            <a href="/book/readerBorrowNext?bookId=<%= book.getBookId() %>" 
	            	class="action-button edit-button">借阅</a>
            </td>
        </tr>
    <% } %>
</table> 	

</body>
</html>
