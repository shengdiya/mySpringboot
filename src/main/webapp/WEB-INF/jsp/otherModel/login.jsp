<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>图书馆借阅系统-登录</title>

    <link rel="stylesheet" type="text/css" href="/css/loginAndRegister.css">

    <script type="text/javascript">
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("modifyPasswordSeccuss") != null) { %>
	                	alert("${modifyPasswordSeccuss}");
	                // request.removeAttribute("modifyPasswordSeccuss");  //getAttribute用完了就删掉，防止回来的时候还弹窗
	            <% } else if(request.getAttribute("registerSuccess") != null){ %>
	            		alert("${registerSuccess}");
	            	// request.removeAttribute("registerStatus");
	           	<% } else if(request.getAttribute("noSuchUser") != null){ %>
		            	alert("${noSuchUser}");
		            // 	request.removeAttribute("noSuchUser"); 
	            <% } %> 
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
    </script>
</head>

<body>
    <div class="container" style="width: 300px;">
        <h2>用户登录</h2>
        <form action="/user?method=Getlogin" method="post">

            <div id="admin-input">
                用户名: <input type="text" name="userName"><br>
            </div>

            	密码: <input type="password" name="password">
            <a href="/user/forgetPassword1" class="modifyPassword">忘记密码？</a>
            <br><br>
            <input type="submit" value="Login">
           
        </form>
    </div>
</body>
</html>