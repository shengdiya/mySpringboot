<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
	List<Unit> units = (List<Unit>) request.getSession().getAttribute("unitsSearched");
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>管理员搜索单位信息</title>
	<link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
<h2>单位列表</h2>
<form action="/unit?method=searchUnit" method="post">
	<input type="text" name="unitName" placeholder="输入单位名查询">
	<input type="submit" value="查询">
</form>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>单位名</th>
        <th>联系人</th>
        <th>联系电话</th>
        <th>操作</th>
    </tr>
    <% for (int i = 0; i < units.size(); i++) {
        Unit unit = units.get(i);
    %>
        <tr>
            <td><%= (i + 1) %></td>
            <td><%= unit.getUnitName() %></td>
            <td><%= unit.getContact() %></td>
            <td><%= unit.getTelephone() %></td>
            <td>
                <!-- 前两个需要跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
                <form action="/unit?method=deleteUnit" method="post">
	                <a href="/unit/adminSeeUnitDetails?unitId=<%= unit.getUnitId() %>" class="action-button detail-button">详情</a>
	                <a href="/unit/adminModifyUnitDetails?unitId=<%= unit.getUnitId() %>" class="action-button edit-button">修改</a>
	                
	                <!-- 隐藏的unitId，用于删除时向后端传递参数，后端可以通过request.getParameter("unitId")得到这个Id -->
	                <input type="hidden" name="unitId" value="<%= unit.getUnitId() %>">
	                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                	<input type="submit" value="删除" class="action-button delete-button">
                </form>
            </td>
        </tr>
    <% } %>
</table>

</body>
</html>
