<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%
    User admin = (User) request.getSession().getAttribute("admin");
    Plant plant = (Plant) request.getAttribute("plantToBeShow");
    Photo photo = (Photo) request.getAttribute("photoToBeShow");
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css">

</head>
<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">

<div class="container">
    <!--TODO植物的详细信息，要展示植物的编号、{科属种别名、分布}(这俩还显示不了，饶宇豪TODO)、形态特征、栽培技术要点、应用价值、同种植物的编号
、缩略图（图片相关）-->
    <h2>植物详细信息</h2>
    <form action="/plant?method=returnPlantSameSpeciesList" method="post">
        <img src="<%= photo.getPhotoPath() %>" alt="User Avatar" class="user-avatar"/>
        <div class="user-info">
            <div class="info-item"><span class="info-label">编号:</span> <%= plant.getNumber() %></div>
            <div class="info-item"><span class="info-label">种名:</span> <%= plant.getPlantName() %></div>
            <div class="info-item"><span class="info-label">形态特征:</span> <%= plant.getFeature() %></div>
            <div class="info-item"><span class="info-label">栽培技术要点:</span> <%= plant.getCultivation() %></div>
            <div class="info-item"><span class="info-label">应用价值:</span> <%= plant.getValue() %></div>
<%--            <div class="info-item"><span class="info-label">植物分布:</span> <%= %></div>--%>
<%--            <div class="info-item"><span class="info-label">植物分类:</span> <%= %></div>--%>
        </div> <br>

        <div class="form-group">
            <input type="hidden" name="plantName" value="<%= plant.getPlantName() %>">
            <input type="submit" value="返回">
        </div>
    </form>
</div>

</body>
</html>
