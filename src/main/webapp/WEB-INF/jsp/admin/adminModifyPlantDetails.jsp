<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<!--修改植物的详细信息，要修改植物的形态特征、栽培技术要点、应用价值和缩略图-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>

<%
    User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plant = (Plant) request.getAttribute("plantToBeModified");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>admin修改植物详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<div class="containerAll">
    <h2>修改<%= plant.getPlantName() %>的信息</h2>

    <form action="/plant?method=ModifyPlantDetails" method="post">
        <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>" />
        <div class="form-group">
            <label for="feature" class="required">形态特征：</label>
            <textarea rows="4" cols="50" id="feature" name="feature" ><%= plant.getFeature()%></textarea>
        </div>
        <div class="form-group">
            <label for="cultivation" class="required">栽培技术要点：</label>
            <textarea rows="4" cols="50" id="cultivation" name="cultivation" ><%= plant.getCultivation()%></textarea>
        </div>
        <div class="form-group">
            <label for="value" class="required">应用价值：</label>
            <textarea rows="4" cols="50" id="value" name="value" ><%= plant.getValue()%></textarea>
        </div>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>
    </form>


    <form action="/plant?method=returnPlantSameSpeciesList" method="post">
        <input type="hidden" name="plantName" value="<%= plant.getPlantName() %>">
        <div class="form-group">
            <input type="submit" value="返回">
        </div>
    </form>
</div>
</body>
</html>

