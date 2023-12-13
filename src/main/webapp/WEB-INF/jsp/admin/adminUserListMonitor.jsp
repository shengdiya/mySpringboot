<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
    User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");List<User> users = (List<User>) request.getAttribute("users");
    UserService userservice = (UserService) request.getAttribute("userservice");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>管理员查看所有用户信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<h2>用户列表</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>用户名</th>
        <th>身份</th>
        <th>姓名</th>
        <th>邮箱</th>
        <th>电话号码</th>
        <th>住址</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < users.size(); i++) {
        User user = users.get(i);
    %>
    <tr>
        <td><%= (i + 1) %></td>
        <td><%= user.getUserName() %></td>
        <td><%= userservice.getUserRole(user.getUserId()) %></td>
        <td><%= user.getRealName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getTelephone() %></td>
        <th><%= user.getAddress() %></th>
        <td>
            <!-- 修改跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
            <form action="/user?method=deleteUser" method="post">
                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="删除" class="action-button delete-button">
            </form>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>
