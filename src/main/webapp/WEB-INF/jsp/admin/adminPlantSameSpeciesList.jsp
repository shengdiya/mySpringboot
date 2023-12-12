<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringManagementService" %>

<%
    User admin = (User) request.getSession().getAttribute("admin");
    List<Plant> plants = (List<Plant>) request.getAttribute("plantsInSameSpecies");
    MonitoringManagementService monitoringmanagementservice = (MonitoringManagementService) request.getAttribute("monitoringManagementService");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">

<%--    <style type="text/css">--%>
<%--        .edit-button {--%>
<%--            background-color: #f1c40f; width: 55px; height: 25px; font-size:15px;--%>
<%--        }--%>

<%--    </style>--%>
</head>

<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">

<script>
    document.addEventListener("DOMContentLoaded", function() {
        setTimeout(function() {
            <% if(request.getAttribute("modifyPlantDetails") != null) { %>
                alert("${modifyPlantDetails}");
            <% } else if(request.getAttribute("modifyPlantPhoto") != null) { %>
                alert("${modifyPlantPhoto}");
            <% } else if(request.getAttribute("deletePlant") != null) { %>
                alert("${deletePlant}");
            <% } %>
        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
    });
</script>

<h2>"<%= plants.get(0).getPlantName() %>"植物列表</h2>
<table class="table-style">
    <tr>
        <th>植物编号</th>
        <th>植物种名</th>
        <th>基本信息管理</th>
        <th>添加检测记录</th>
    </tr>
    <% for (int i = 0; i < plants.size(); i++) {
        Plant plant = plants.get(i);
    %>
    <tr>
        <td><%= plant.getNumber() %></td>
        <td><%= plant.getPlantName() %></td>
        <td>
            <!-- 前两个需要跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
            <form action="/plant?method=deletePlant" method="post">
                <a href="/plant/adminSeePlantDetails?plantId=<%= plant.getPlantId() %>" class="action-button detail-button">详情</a>
                <a href="/plant/adminModifyPlantDetails?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">修改</a>
                <a href="/plant/adminModifyPlantPhoto?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">配图</a>
                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
                <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="删除" class="action-button delete-button">
            </form>
        </td>

        <td>
            <a href="/MonitorManagement/MonitorManagementAdd?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">添加</a>
        </td>

<%--        <td>--%>
<%--            <!--以下两条为超链接，点击后跳转到增加养护/监测任务的界面，--%>
<%--                跳转前要先判断该植物有没有正在进行的养护/监测任务，如果有则不允许跳转，或者直接禁用超链接，或者不让在增加界面中提交增加记录，反正就想办法不让增加-->--%>
<%--            <a href="#?plant=<%= plant.getPlantId() %>" class="action-button detail-button">添加养护记录</a>-- 齐贇博TODO%>

<%--        </td>--%>
    </tr>
    <% } %>
</table>
    <form action="/plant?method=returnPlantList" method="post">
        <div class="form-group">
            <input type="submit" value="返回">
        </div>
    </form>
</body>
</html>