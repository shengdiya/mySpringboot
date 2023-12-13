<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");
	List<Book> books = (List<Book>) request.getAttribute("books");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<h2>全部图书信息</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>图书名称</th>
        <th>作者</th>
        <th>图书类别</th>
        <th>出版社</th>
        <th>出版时间</th>      
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
            <td><%= book.getPress() %></td>
            <td><%= book.getOutTime() %> </td>
            <td>
                <!-- 前两个需要跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
                <form action="/book?method=deleteBook" method="post">
	                <a href="/book/adminSeeBookDetails?bookId=<%= book.getBookId() %>" class="action-button detail-button">详情</a>
	                <a href="/book/adminModifyBookDetails?bookId=<%= book.getBookId() %>" class="action-button edit-button">修改</a>
	                
	                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
	                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
	                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                	<input type="submit" value="删除" class="action-button delete-button">
                </form>
            </td>
        </tr>
    <% } %>
</table> 	

</body>
</html>
