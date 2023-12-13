<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");User user = (User) request.getAttribute("user");
    UserService userservice = (UserService) request.getAttribute("userservice");
 %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>管理员修改用户详细信息</title>
	 <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
  </head>
  
  <body>
  	  <input name="safe" type="hidden" value="<%= user1.getUserName() %>">
  
	  <div class="containerAll">
		  <h2>修改<%=user.getUserName() %>的信息</h2>
		  <form action="/user?method=ModifyUserDetails" method="post">
		 	<input type="hidden" name="userId" value="<%= user.getUserId() %>" />
            <div class="form-group">
                <label for="realName" class="required">真实姓名:</label>
                <input type="text" id="realName" name="realName" value="<%=user.getRealName() %>" required>
            </div>
            
            <div class="form-group radio-group">
            	<!-- 通过jsp的el表达式设置input单选框元素的checked属性 -->
                <label class="required">性别:</label>
                <input type="radio" id="male" name="sexy" value="male" ${user.getSexy() eq 'male' ? 'checked' : ''} />
                <label for="male">男</label>
                <input type="radio" id="female" name="sexy" value="female" ${user.getSexy() eq 'female' ? 'checked' : ''} />
                <label for="female">女</label>
            </div>
            
            <div class="form-group">
                <label for="telephone" class="required">联系电话:</label>
                <input type="tel" id="telephone" name="telephone" value="<%=user.getTelephone() %>" required>
            </div>
            <div class="form-group">
                <label for="email" class="required">邮箱:</label>
                <input type="email" id="email" name="email" value="<%=user.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="address" class="required">住址:</label>
                <input type="text" id="address" name="address" value="<%=user.getAddress() %>" required>
            </div>
            
           	 <!-- 如果是工作人员，可以修改工作单位 -->
			 <% String roleName = userservice.getUserRole(user.getUserId());
			    if(roleName.equals("staff")) { %>
		            <div class="form-group">
		                <label for="whichUnit" class="required">所属单位:</label>
		                <input type="text" id="whichUnit" name="whichUnit" value="<%=user.getWhichUnit() %>" required>
		            </div>
             <% } %>
             
            <div class="form-group">
                <input type="submit" value="提交">
            </div>
		  </form>
		  
		  <form action="/user?method=returnUserList" method="post">
		  	<div class="form-group">
	             <input type="submit" value="返回">
	        </div> 
		  </form>
	  </div>
  </body>
</html>
