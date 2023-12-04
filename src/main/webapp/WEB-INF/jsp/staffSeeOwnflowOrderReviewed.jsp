<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
	FlowBookOrderService flowBookOrderService = (FlowBookOrderService) request.getAttribute("flowBookOrderService");
	BookService bookservice = (BookService) request.getAttribute("bookservice");
	List<FlowBookOrder> orders = flowBookOrderService.selectOrderByWhichUnitAndStatus(staff.getWhichUnit(), "已流出");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>本人订单信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
<h2>本单位"已审核"订单信息</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>图书名</th>
        <th>借阅时间</th>
        <th>归还时间</th>
        <th>借阅理由</th>
        <th>借阅人</th>
        <th>联系电话</th>
        <th>备注</th>
        <th>
    </tr>
    <% for (int i = 0; i < orders.size(); i++) {
        FlowBookOrder order = orders.get(i);
    %>
        <tr>
            <td><%= (i+1) %></td>
            <td><%= bookservice.selectBookById(order.getBookId()).getBookName() %></td>
            <td><%= order.getOutTime() %></td>
            <td><%= order.getReturnTime() %></td>
            <td><%= order.getReason() %></td>
            <td><%= order.getRealName() %></td>
            <td><%= order.getTelephone() %></td>
            <td><%= order.getDetail() %></td>  
            <td>
            	<form action="/book?method=GetStaffReturnBook" method="post">
	                <input type="hidden" name="bookId" value="<%= order.getBookId() %>">
	                <input type="hidden" name="flowId" value="<%= order.getFlowId() %>">
	                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                	<input type="submit" value="归还" class="action-button delete-button">
                </form>
            </td>
        </tr>
    <% } %>
</table> 	

</body>
</html>
