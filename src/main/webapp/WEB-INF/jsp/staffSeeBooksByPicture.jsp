<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
    List<Book> books = (List<Book>) request.getAttribute("booksInThisUnit");
    User staff = (User) request.getSession().getAttribute("staff");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>图书缩略图展示</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
    <style>
        /* 网格布局样式 */
        .grid-container {
            display: grid;
            grid-template-columns: auto auto auto auto; /* 按需要调整列数 */
            padding: 10px;
            gap: 15px; /* 调整间隙大小 */
        }
        .grid-item {
            text-align: center; /* 居中文本 */
            padding: 20px;
            box-shadow: 0 0 10px 0 rgba(0,0,0,0.2); /* 添加阴影效果 */
            transition: transform 0.3s ease-in-out; /* 平滑变换效果 */
        }
        .grid-item img {
            width: 100%; /* 宽度占满容器 */
            height: auto; /* 高度自适应 */
            max-width: 150px; /* 最大宽度限制，可调整 */
            max-height: 200px; /* 最大高度限制，可调整 */
        }
        .grid-item:hover {
            transform: scale(1.05); /* 鼠标悬停时放大效果 */
        }
    </style>
</head>

<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
<h2>图书缩略图展示</h2>
<div class="grid-container">
    <% for(Book book : books) { %>
        <div class="grid-item">
            <a href="/book/StaffSeeBookDetails?bookId=<%= book.getBookId() %>">
                <img src="<%= book.getPicturePath() %>" alt="图书缩略图">
                <p><%= book.getBookName() %></p>
            </a>
        </div>
    <% } %>
</div>   

</body>
</html>
