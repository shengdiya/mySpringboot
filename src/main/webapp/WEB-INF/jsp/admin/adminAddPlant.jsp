<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>增加用户</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
	<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
	
    <div class="container">
        <h2>添加植物</h2>
        <form action="/plant?method=GetAdminAddPlant" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="plantName" class="required">植物种名：</label>
                <input type="text" id="plantName" name="plantName" required>
            </div>     
            <div class="form-group">
                <label for="feature" class="required">形态特征：</label>
                <textarea rows="4" cols="50" id="feature" name="feature" required></textarea>
            </div>
             <div class="form-group">
                <label for="cultivation" class="required">栽培技术要点：</label>
                <textarea rows="4" cols="50" id="cultivation" name="cultivation" required></textarea>
            </div>
            <div class="form-group">
                <label for="value" class="required">应用价值：:</label>
                <textarea rows="4" cols="50" id="value" name="value" required></textarea>
            </div>

            <div class="form-group">
                <label for="plantImg">植物图片:</label>
                <input type="file" id="plantImg" name="plantImg" accept=".jpg, .png" >
            </div>
            <div class="form-group">
                <label for="photoPlace">图片拍摄地点：</label>
                <input type="text" id="photoPlace" name="photoPlace">
            </div>
            <div class="form-group">
                <label for="photographer">图片拍摄人：</label>
                <input type="text" id="photographer" name="photographer">
            </div>
            <div class="form-group">
                <label for="photoDescribe">图片描述：</label>
                <input type="text" id="photoDescribe" name="photoDescribe">
            </div>

            <div class="form-group">
                <input type="submit" value="提交">
            </div>
        </form>
    </div>
</body>
</html>