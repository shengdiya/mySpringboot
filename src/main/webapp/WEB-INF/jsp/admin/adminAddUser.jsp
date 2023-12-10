<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>增加工作人员</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
	<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
	
    <div class="container">
        <h2>增加工作人员</h2>
        <form action="user?method=adminAddStaff" method="post">
            <div class="form-group">
                <label for="userName" class="required">用户名:</label>
                <input type="text" id="userName" name="userName" required>
            </div>

            <div class="form-group">
                <label for="password" class="required">密码:</label>
                <input type="number" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="realName" class="required">真实姓名:</label>
                <input type="text" id="realName" name="realName" required>
            </div>
            <div class="form-group">
                <label for="telephone" class="required">联系电话:</label>
                <input type="tel" id="telephone" name="telephone" required>
            </div>
            <div class="form-group">
                <label for="email" class="required">邮箱:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="address" class="required">住址:</label>
                <input type="text" id="address" name="address" required>
            </div>
 
			<div class="form-group">
                <label for="identity" class="required">类别:</label>
                <select id="identity" name="identity" required>
                    <option value="conserver">养护人员</option>
                    <option value="monitor">监测人员</option>
                    <option value="boss">上级主管人员</option>
                </select>
			</div>
            
            <div class="form-group">
                <input type="submit" value="提交">
            </div>
        </form>
    </div>
</body>
</html>
