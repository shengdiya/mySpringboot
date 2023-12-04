<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	List<Book> books = (List<Book>) request.getAttribute("booksInThisUnit");
	User staff = (User) request.getSession().getAttribute("staff");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看本单位图书</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
	<style>
		.delete-button { background-color: #e74c3c; width: 55px; height: 30px; font-size:15px; }
		.open-button {background-color: #00FF00; width: 50px; height: 30px; font-size:15px;}
		.close-button {background-color: #006400; width: 50px; height: 30px; font-size:15px;}
	</style>

</head>
<!-- 图书名、图书编号、出版时间、作者、出版社、图书分类、页数、价格、借阅状态 -->
<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
<h2>借阅书籍</h2>
<form id="searchForm" action="/book?method=searchBook" method="post">
    <input type="radio" id="bookName" name="searchType" value="bookName" checked>
    <label for="bookName">图书名</label>

    <input type="radio" id="bookId" name="searchType" value="bookId">
    <label for="bookId">图书编号</label>

    <input type="radio" id="author" name="searchType" value="author">
    <label for="author">作者</label>

    <input type="radio" id="press" name="searchType" value="press">
    <label for="press">出版社</label>

    <input type="text" id="searchInput" name="searchQuery" >

    <button type="submit">搜索</button>
</form>

<table class="table-style">
    <tr>
        <th>编号</th>
        <th>书名</th>
        <th>作者</th>
        <th>类别</th>
        <th>出版时间</th>
        <th>出版社</th>
        <th>价格</th>
        <th>所在单位</th>
        <th>是否隐藏</th>
        <th>借阅状态</th>
        <th>操作</th>
        <th>开放和隐藏</th>
    </tr>
    <% for (int i = 0; i < books.size(); i++) {
        Book book = books.get(i);
    %>
        <tr>
            <td><%= book.getBookId() %></td>
            <td><%= book.getBookName() %></td>
            <td><%= book.getAuthorName() %></td>
            <td><%= book.getType() %></td>
            <td><%= book.getOutTime() %></td>
            <td><%= book.getPress() %></td>
            <td><%= book.getPrice() %></td>
            <td><%= book.getNowWhere() %></td>
            <td><%= book.isAllowed() == true ? "否" : "是" %></td>
            <td><%= book.getLeft() == 0 ? "已借出" : "未借出" %></td>
            <td>
           	 	<form action="/book?method=staffDeleteBook" method="post">
	                <a href="/book/StaffSeeBookDetails?bookId=<%= book.getBookId() %>" class="action-button detail-button">详情</a>
	                <a href="/book/StaffModifyBookDetails?bookId=<%= book.getBookId() %>" class="action-button edit-button">修改</a>
	                
	                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
	                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
	                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                	<input type="submit" value="删除" class="action-button delete-button">
                </form>
            </td>
            
            <td>
            	 <form action="/book?method=StaffAllowBook" method="post">
                	<input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                	<input type="submit" value="开放" class="action-button open-button">
               	 </form>
                
                 <form action="/book?method=StaffNotAllowBook" method="post">
                	<input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                	<input type="submit" value="隐藏" class="action-button close-button">
                 </form>
            </td>
        </tr>
    <% } %>
</table> 

</body>
</html>
