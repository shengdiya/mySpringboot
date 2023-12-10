<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
  User boss = (User) request.getSession().getAttribute("boss");
  List<User> monitors = (List<User>) request.getAttribute("monitors");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>上级主管部门查看养护人员信息</title>
  <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= boss.getUserName() %>">
<h2>养护人员列表</h2>
<table class="table-style">
  <tr>
    <th>序号</th>
    <th>用户名</th>
    <th>姓名</th>
    <th>邮箱</th>
    <th>电话号码</th>
    <th>住址</th>
  </tr>
  <% for (int i = 0; i < monitors.size(); i++) {
    User user = monitors.get(i);
  %>
  <tr>
    <td><%= (i + 1) %></td>
    <td><%= user.getUserName() %></td>
    <td><%= user.getRealName() %></td>
    <td><%= user.getEmail() %></td>
    <td><%= user.getTelephone() %></td>
    <th><%= user.getAddress() %></th>
  </tr>
  <% } %>
</table>

</body>
</html>
