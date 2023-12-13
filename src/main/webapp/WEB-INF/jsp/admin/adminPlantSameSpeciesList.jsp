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
    User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");List<Plant> plants = (List<Plant>) request.getAttribute("plantsInSameSpecies");
    FamilyspeciesService familyspeciesService = (FamilyspeciesService) request.getAttribute("familyspeciesService");
    GenusfamilyService genusfamilyService = (GenusfamilyService)  request.getAttribute("genusfamilyService");
    SpeciesAliasService speciesAliasService = (SpeciesAliasService) request.getAttribute("speciesAliasService");
    SpeciesService speciesService = (SpeciesService) request.getAttribute("speciesService");
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
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

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
        <th>植物分类</th>
        <th>基本信息管理</th>
        <%if(roleId == 1 || roleId == 3) { %>
        <th>添加检测记录</th>
        <%} %>
        <%if(roleId == 1 || roleId == 2) { %>
        <th>添加养护记录</th>
        <%} %>
    </tr>
    <% for (int i = 0; i < plants.size(); i++) {
        Plant plant = plants.get(i);
    %>
    <%
        StringBuilder category = new StringBuilder();
        String family = familyspeciesService.selectfamilyspeciesBySpecies(plant.getPlantName()).getFamily();
        String genus = genusfamilyService.selectGenusfamily(family).getGenus();
        List<SpeciesAlias> alias = speciesAliasService.selectSpeciesAliasBySpeciesId(speciesService.findSpeciesIdByName(plant.getPlantName()));

        category.append("科名：" + genus);
        category.append("属名：" + family);
        category.append("种名：" + plant.getPlantName());
        category.append("别名：");
        for(SpeciesAlias alia : alias){
            category.append(alia.getSpeciesAlias() + ";");
        }
        String categoryResult = category.toString();
    %>
    <tr>
        <td><%= plant.getNumber() %></td>
        <td><%= plant.getPlantName() %></td>
        <td><%= categoryResult %></td>
        <td>
            <!-- 前两个需要跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
            <form action="/plant?method=deletePlant" method="post">
                <a href="/plant/adminSeePlantDetails?plantId=<%= plant.getPlantId() %>" class="action-button detail-button">详情</a>
                <%if(roleId == 1 ) { %>

                <a href="/plant/adminModifyPlantDetails?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">修改</a>
                <a href="/plant/adminModifyPlantPhoto?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">配图</a>
                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->

                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="删除" class="action-button delete-button">
                <%} %>
                <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>">
            </form>
        </td>
        <%if(roleId == 1 || roleId == 3) { %>
        <td>
            <a href="/MonitorManagement/MonitorManagementAdd?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">添加</a>
        </td>
        <%} %>
        <%if(roleId == 1 || roleId == 2) { %>
        <td>
            <a href="/conserverController/conserverAddTask?plantId=<%= plant.getPlantId() %>" class="action-button edit-button">添加</a>
        </td>
        <%} %>
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