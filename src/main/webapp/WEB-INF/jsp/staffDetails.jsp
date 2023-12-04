<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
   User staff = (User) request.getSession().getAttribute("staff");
 %>
<!DOCTYPE html>
<html>
  <head>
    <title>管理员详细信息</title>
		 <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
	<style>
		.bottom {
		  display: flex;
		  align-items: center; /* 垂直居中 */
		  justify-content: space-between; /* 两端对齐 */
		}
		h2 {
  		  margin: 0; /* 移除h2默认的外边距 */
		}
		.modifyPassword{
        	float: right;
            padding-right: 50px;
            font-size: 20px;
            color: #009933;
            text-decoration: none;
            margin-left: auto;
        }
        .modifyPassword:hover{
        	color: #32CD32;
        }
	</style>
  </head>
  
  <body>
    <div class="container">
    	<h2>修改个人信息</h2>
		 
		  <br>
		  <form action="/user?method=ModifyStaffOwnDetails" method="post">
		 	<input type="hidden" name="userId" value="<%= staff.getUserId() %>" />

            <div class="form-group">
                <label for="realName" class="required">真实姓名:</label>
                <input type="text" id="realName" name="realName" value="<%=staff.getRealName() %>" required>
            </div>
            
            <div class="form-group radio-group">
            	<!-- 通过jsp的el表达式设置input单选框元素的checked属性 -->
                <label class="required">性别:</label>
                <input type="radio" id="male" name="sexy" value="male" ${staff.getSexy() eq 'male' ? 'checked' : ''} />
                <label for="male">男</label>
                <input type="radio" id="female" name="sexy" value="female" ${staff.getSexy() eq 'female' ? 'checked' : ''} />
                <label for="female">女</label>
            </div>
            
            <div class="form-group">
                <label for="telephone" class="required">联系电话:</label>
                <input type="tel" id="telephone" name="telephone" value="<%=staff.getTelephone() %>" required>
            </div>
            <div class="form-group">
                <label for="email" class="required">邮箱:</label>
                <input type="email" id="email" name="email" value="<%=staff.getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="address" class="required">住址:</label>
                <input type="text" id="address" name="address" value="<%=staff.getAddress() %>" required>
            </div>
            
			 <div class="bottom">
			   	<div class="form-group">
	                <input type="submit" value="提交">
	            </div>         
				<a href="/user/forgetPassword1" class="modifyPassword">重置密码</a>
			  </div>
		  </form>
		  
		  <form action="/book?method=goBackToStaffIndex" method="post">
		  	<div class="form-group">
	             <input type="submit" value="返回">
	        </div> 
		  </form>
	  </div>
  </body>
</html>
