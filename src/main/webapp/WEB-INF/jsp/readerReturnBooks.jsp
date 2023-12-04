<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User user = (User) request.getSession().getAttribute("reader");
	BorrowBookOrderService borrowBookOrderService = (BorrowBookOrderService) request.getAttribute("borrowBookOrderService");
	BookService bookservice = (BookService) request.getAttribute("bookservice");
	List<BorrowBookOrder> orders = borrowBookOrderService.selectOrderByUserIdAndStatus(user.getUserId(),"已借出");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>已结束订单信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
	<input name="safe" type="hidden" value="<%= user.getUserName() %>">
<h2>已借出订单信息</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>图书名称</th>
        <th>借阅时间</th>
        <th>归还时间</th>
        <th>订单状态</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < orders.size(); i++) {
        BorrowBookOrder order = orders.get(i);
    %>
        <tr>
            <td><%= (i+1) %></td>
            <td><%= bookservice.selectBookById(order.getBookId()).getBookName() %></td>
            <td><%= order.getOutTime() %></td>
            <td><%= order.getReturnTime() %></td>
			<td><%= order.getStatus() %></td>             
			<td>
                <form action="/book?method=GetReturnBooks" method="post">
	                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
	                <input type="hidden" name="bookId" value="<%= order.getBookId() %>">
	                <input type="hidden" name="BorrowId" value="<%= order.getBorrowId() %>">
	                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                	<input type="submit" value="归还" class="action-button delete-button">
                </form>
            </td>
        </tr>
    <% } %>
</table> 	

</body>
</html>
