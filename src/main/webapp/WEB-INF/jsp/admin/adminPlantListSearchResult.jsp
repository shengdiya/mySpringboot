<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/7
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="java.util.List" %>

<%
    List<Plant> TargetPlants = (List<Plant>) request.getSession().getAttribute("TargetPlants");
    User admin = (User) request.getSession().getAttribute("admin");
    PlantService plantservice = (PlantService) request.getSession().getAttribute("plantservice");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>植物缩略图展示</title>
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
        img.user-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin: 20px auto;
            display: block;
        }
    </style>
</head>

<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
<h2>植物缩略图展示</h2>
<form id="searchForm" action="/plant?method=searchPlant" method="post">
    <input type="text" id="searchInput" name="searchQuery" >
    <button type="submit">搜索</button>
</form>

<div class="grid-container">
    <% for(Plant plant : TargetPlants) { %>
    <div class="grid-item">
        <a href="/plant/adminPlantSameSpeciesList?plantName=<%= plant.getPlantName() %>">
            <img src="<%= plantservice.selectPhotoByPlantId(plant.getPlantId()).getPhotoPath() %>" alt="植物缩略图" class="user-avatar">
            <p><%= plant.getPlantName() %></p>
        </a>
    </div>
    <% } %>
</div>

</body>
</html>
