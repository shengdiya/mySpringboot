<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
	List<FlowBookOrder> orders = (List<FlowBookOrder>) request.getAttribute("ordersFromOtherUnitsWating");
	BookService bookservice = (BookService) request.getAttribute("bookservice");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
<h2>待审核订单</h2>
<table class="table-style">
    <tr>
        <th>ID</th>
        <th>图书名称</th>
        <th>流出单位</th>
        <th>借阅账户Id</th>
        <th>流出时间</th>
        <th>归还时间</th>      
        <th>流出理由</th>
        <th>申请人</th>
        <th>联系电话</th>
        <th>备注</th>
        <th>订单状态</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < orders.size(); i++) {
        FlowBookOrder order = orders.get(i);
    %>
        <tr>
            <td><%= order.getFlowId() %></td>
			<td><%= bookservice.selectBookById(order.getBookId()).getBookName() %></td>           
			<td><%= order.getWhichUnit() %></td>
            <td><%= order.getUserId() %></td>
            <td><%= order.getOutTime() %></td>
            <td><%= order.getReturnTime() %></td>
            <td><%= order.getReason() %></td>
            <td><%= order.getRealName() %></td>
            <td><%= order.getTelephone() %></td>
            <td><%= order.getDetail() %></td>    
			<td><%= order.getStatus() %></td>                   
            <td>
            	<form action="/book?method=agreeRequest" method="post"> 
            		<input type="hidden" name="flowId" value="<%= order.getFlowId() %>">               
                	<input type="submit" value="同意" class="action-button detail-button">
                </form>
            
                <form action="/book?method=refuseRequest" method="post">  
                	<input type="hidden" name="flowId" value="<%= order.getFlowId() %>">                
                	<input type="submit" value="拒绝" class="action-button edit-button">
                </form>
            </td>
        </tr>
    <% } %>
</table> 	

</body>
</html>
