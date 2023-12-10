<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>

<%
    User admin = (User) request.getSession().getAttribute("admin");
    Plant plant = (Plant) request.getAttribute("plantToBeModified");
    Photo photo = (Photo) request.getAttribute("photoToBeModify");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>admin修改植物图片</title>
    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
    <style>
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
<div class="containerAll">
    <h2>修改<%= plant.getPlantName() %><%= plant.getNumber()%>图片</h2>

    <form action="/plant?method=ModifyPlantPhoto" method="post" enctype="multipart/form-data">
        <img src="<%= photo.getPhotoPath() %>" alt="User Avatar" class="user-avatar"/>

        <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>" />
        <input type="hidden" name="photoId" value="<%= photo.getPhotoId() %>" />
        <input type="hidden" name="photoPath" value="<%= photo.getPhotoPath() %>" />
        <!--三个隐藏的属性+下面输入的属性组成一个完整的Photo对象-->
        <div class="form-group">
            <label for="plantImg">植物图片：</label>
            <input type="file" id="plantImg" name="plantImg" accept=".jpg, .png" >
        </div>
        <div class="form-group">
            <label for="photoPlace">图片拍摄地点：</label>
            <input type="text" id="photoPlace" name="photoPlace" value="<%= photo.getPhotoPlace()%>">
        </div>
        <div class="form-group">
            <label for="photographer">图片拍摄人：</label>
            <input type="text" id="photographer" name="photographer" value="<%= photo.getPhotographer()%>">
        </div>
        <div class="form-group">
            <label for="photoDescribe">图片描述：</label>
            <input type="text" id="photoDescribe" name="photoDescribe" value="<%= photo.getPhotoDescribe()%>">
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