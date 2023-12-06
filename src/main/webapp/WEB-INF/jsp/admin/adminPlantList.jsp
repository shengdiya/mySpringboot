<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
    List<Plant> plants = (List<Plant>) request.getAttribute("plantsInOneSpecies");
    User admin = (User) request.getSession().getAttribute("admin");
    PlantService plantservice = (PlantService) request.getAttribute("plantservice");
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
    </style>
</head>

<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
<h2>植物缩略图展示</h2>
<div class="grid-container">
    <% for(Plant plant : plants) { %>
    <div class="grid-item">
        <a href="/plant/adminPlantSameSpeciesList?plantName=<%= plant.getPlantName() %>">
            <img src="<%= plantservice.selectPhotoByPlantId(String.valueOf(plant.getPlantId())).getPhotoPath() %>" alt="植物缩略图">
            <p><%= plant.getPlantName() %></p>
        </a>
    </div>
    <% } %>
</div>

</body>
</html>
