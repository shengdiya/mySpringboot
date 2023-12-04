<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
    Unit unit = (Unit) request.getAttribute("unit");
 %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>管理员修改用户详细信息</title>
	 <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
  </head>
  
  <body>
  	  <input name="safe" type="hidden" value="<%= admin.getUserName() %>">
	  <div class="containerAll">
		  <h2>修改<%= unit.getUnitName() %>的信息</h2>
		  <form action="/unit?method=ModifyunitDetails" method="post">
		 	<input type="hidden" name="unitId" value="<%= unit.getUnitId() %>" />
		 	<div class="form-group">
                <label for="unitName" class="required">单位名称</label>
                <input type="text" id="unitName" name="unitName" value="<%= unit.getUnitName() %>" required>
            </div>
			<div class="form-group">
                <label for="unitType" class="required">单位类别</label>
                <input type="text" id="unitType" name="unitType" value="<%= unit.getUnitType() %>" required>
            </div>
            <div class="form-group">
                <label for="contact" class="required">联系人：</label>
                <input type="text" id="contact" name="contact" value="<%= unit.getContact() %>" required>
            </div>
            <div class="form-group">
                <label for="telephone" class="required">联系电话：</label>
                <input type="tel" id="telephone" name="telephone" value="<%= unit.getTelephone() %>" required>
            </div>
            <div class="form-group">
                <label for="email" class="required">联系邮箱:</label>
                <input type="email" id="email" name="email" value="<%= unit.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="address" class="required">联系地址:</label>
                <input type="text" id="address" name="address" value="<%= unit.getAddress() %>" required>
            </div>
            
            <div class="form-group">
                <input type="submit" value="提交">
            </div>
		  </form>
		  
		  <form action="/user?method=returnUnitList" method="post">
		  	<div class="form-group">
	             <input type="submit" value="返回">
	        </div> 
		  </form>
	  </div>
  </body>
</html>
