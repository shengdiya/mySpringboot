<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
	BookService bookservice = (BookService) request.getAttribute("bookservice");
	List<BorrowBookOrder> orders = (List<BorrowBookOrder>) request.getAttribute("staffBookBorrowingReviewed");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
  <input name="safe" type="hidden" value="<%= staff.getUserName() %>">

<h2>已借出订单信息</h2>
<table class="table-style">
    <tr>
        <th>ID</th>
        <th>图书名称</th>
        <th>借阅账户Id</th>
        <th>借阅时间</th>
        <th>归还时间</th>
        <th>借阅理由</th>
        <th>借阅人</th>
        <th>联系电话</th>
        <th>备注</th>
        <th>订单状态</th>
    </tr>
    <% for (int i = 0; i < orders.size(); i++) {
        BorrowBookOrder order = orders.get(i);
    %>
        <tr>
            <td><%= order.getBorrowId() %></td>
            <td><%= bookservice.selectBookById(order.getBookId()).getBookName() %></td>
            <td><%= order.getUserId() %></td>
            <td><%= order.getOutTime() %></td>
            <td><%= order.getReturnTime() %></td>
            <td><%= order.getReason() %></td>
            <td><%= order.getRealName() %></td>
            <td><%= order.getTelephone() %></td>
            <td><%= order.getDetail() %></td>    
		    <td><%= order.getStatus() %></td>                   
        </tr>
    <% } %>
</table> 	

</body>
</html>