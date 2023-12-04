<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>重置密码页面1</title>
 	<link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
 	
  </head>
  
  <body>
  <script>
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("userNotEmail") != null) { %>
	                alert("${userNotEmail}");
	            <% } else if(request.getAttribute("noSuchUser") != null) { %>
	                alert("${noSuchUser}");
	            <% } else if(request.getAttribute("emailError") != null) { %>
	            	alert("${emailError}");
	           	<% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
 </script>
 
 <div class="containerAll">
    <h2>重置密码</h2>
    <!-- 表单action根据实际处理页面进行设置 -->
    <form action="/user?method=GetforgetPassword1" method="post">
        	<div class="form-group">
				<label for="userName" class="required">用户名：</label>
				<input type="text" id="userName" name="userName" required>
			</div>
			<div class="form-group">
				<label for="email" class="required">邮箱：</label>
				<input type="email" id="email" name="email" required>
			</div>
			
			<div class="form-group">
				<div class="button-container">
					<input type="submit" value="下一步">
	            	<input type="button" value="返回首页" onclick="javascript:window.location.href ='/user/login'">
            	</div>
			</div>
    </form>
</div>
  </body>
</html>

