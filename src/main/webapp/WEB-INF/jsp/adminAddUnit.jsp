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
        <h2>增加单位</h2>
        <form action="/unit?method=GetadminAddUnit" method="post">
            <div class="form-group">
                <label for="unitName" class="required">单位名称：</label>
                <input type="text" id="unitName" name="unitName" required>
            </div>     
            <div class="form-group">
                <label for="unitType" class="required">单位类别：</label>
                <input type="text" id="unitType" name="unitType" required>
            </div>
             <div class="form-group">
                <label for="contact" class="required">联系人：</label>
                <input type="text" id="contact" name="contact" required>
            </div>
            <div class="form-group">
                <label for="telephone" class="required">联系电话：:</label>
                <input type="tel" id="telephone" name="telephone" required>
            </div>
            <div class="form-group">
                <label for="email" class="required">联系邮箱:</label>
                <input type="email" id="email" name="email" required>
            </div>
             <div class="form-group">
                <label for="address" class="required">联系地址:</label>
                <input type="text" id="address" name="address" required>
            </div>          
            <div class="form-group">
                <input type="submit" value="提交">
            </div>
        </form>
    </div>
</body>
</html>
