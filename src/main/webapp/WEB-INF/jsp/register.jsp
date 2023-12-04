<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户注册</title>
	<link rel="stylesheet" type="text/css" href="/css/loginAndRegister.css">
</head>
<body>
<script>
	document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("registerStatus") != null) { %>
	                alert("${registerStatus}");
	            <% } else if(request.getAttribute("RegisterEmailError") != null){ %>
	            	alert("${RegisterEmailError}");
	            <% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
</script>

<div class="container">
    <h2>用户注册</h2>
    <form action="/user?method=Getregister" method="post">
        <div>
            <input type="text" placeholder="请输入用户名" name="userName" required>
        </div>
        <div>
            <input type="password" placeholder="请输入密码" name="password" required>
        </div>
        <div>
            <input type="text" placeholder="请输入真实姓名" name="realName" required>
        </div>
        <div style="text-align: left; margin-left: 10px; margin-bottom: 10px; ">
		性别:
            <label><input type="radio" name="sexy" value="male" checked>男</label>
            <label><input type="radio" name="sexy" value="female">女</label>
        </div>
        <div>
            <input type="text" placeholder="请输入电话号码" name="telephone" required>
        </div>
        <div>
            <input type="text" placeholder="请输入电子邮箱" name="email" required>
        </div>
        <div>
            <input type="text" placeholder="请输入住址" name="address" required>
        </div>
        <input type="submit" value="点击发送验证码">
    </form>
</div>

</body>
</html>
