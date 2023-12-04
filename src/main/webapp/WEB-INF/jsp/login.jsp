<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>图书馆借阅系统-登录</title>

    <link rel="stylesheet" type="text/css" href="/css/loginAndRegister.css">

    <script type="text/javascript">
        function onRoleChange(role) {
            var workInput = document.getElementById('work-input');
            var readerInput = document.getElementById("reader-input");
            var adminInput = document.getElementById("admin-input")
            //根据单选框选中的角色，开放相应的输入框，隐藏其他的输入框
            if (role === 'staff') {
                workInput.style.display = 'block';
                adminInput.style.display = 'none'
                readerInput.style.display = 'none';
            } else if(role === 'user') {
            	readerInput.style.display = 'block';
                workInput.style.display = 'none';
                adminInput.style.display = 'none'
            } else{
            	adminInput.style.display = 'block';
            	workInput.style.display = 'none';
            	readerInput.style.display = 'none';
            }
        }
        
        function prepareSubmission() {
	        var role = document.querySelector('input[name="role"]:checked').value;
	        var userNameInput = document.querySelector('#reader-input input');
	        var workIdInput = document.querySelector('#work-input input');
			var adminInput = document.querySelector('#admin-input input');
			 //根据单选框选中的角色，确保其他输入框的name为空，并设置相应输入框的name
	        if(role === 'staff') {
	            workIdInput.name = 'userName';
	            userNameInput.name = '';
	            adminInput.name = '';
	        } else if(role === 'user'){
	            userNameInput.name = 'userName';
	            workIdInput.name = '';
	            adminInput.name = '';
	        } else{
	        	adminInput.name = 'userName';
	        	workIdInput.name = '';
	        	userNameInput.name = '';
	        }
	    }
	    
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
        <form action="/user?method=Getlogin" method="post" onsubmit="prepareSubmission()">
            <input type="radio" name="role" value="user" checked onchange="onRoleChange(this.value)"> 普通用户
            <input type="radio" name="role" value="staff" onchange="onRoleChange(this.value)"> 工作人员
            <input type="radio" name="role" value="admin" onchange="onRoleChange(this.value)"> 系统管理员
            <br><br>

			<div id="admin-input" class="hide">
                 	用户名: <input type="text" name="userName"><br>
            </div>
				
            <div id="work-input" class="hide">
             	           用户名: <input type="text" name="userName"><br>
            </div>
            
			<div id="reader-input">
                	用户名: <input type="text" name="userName"><br>
            </div>

            	密码: <input type="password" name="password">
            <a href="/user/forgetPassword1" class="modifyPassword">忘记密码？</a>
            <br><br>
            <input type="submit" value="Login">
           
        </form>
		
        <p>还没有账号？ <a href="/user/register">去注册</a></p> 
        <!-- 后端接受的是register这个名字，然后根据application.properties中的前后缀配置进行拼接 -->
    </div>
</body>
</html>