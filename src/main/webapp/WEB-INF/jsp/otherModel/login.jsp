<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>图书馆借阅系统-登录</title>

    <link rel="stylesheet" type="text/css" href="/css/loginAndRegister.css">

    <script type="text/javascript">
        function onRoleChange(role) {
            var conserverInput = document.getElementById('conserver-input');
            var monitorInput = document.getElementById("monitor-input");
            var bossInput = document.getElementById("boss-input");
            var adminInput = document.getElementById("admin-input")
            //根据单选框选中的角色，开放相应的输入框，隐藏其他的输入框
            if (role === 'conserver') {
                conserverInput.style.display = 'block';
                monitorInput.style.display = 'none'
                bossInput.style.display = 'none';
                adminInput.style.display = 'none'
            } else if(role === 'monitor') {
                conserverInput.style.display = 'none';
                monitorInput.style.display = 'block'
                bossInput.style.display = 'none';
                adminInput.style.display = 'none'
            } else if(role === 'boss') {
                conserverInput.style.display = 'none';
                monitorInput.style.display = 'none'
                bossInput.style.display = 'block';
                adminInput.style.display = 'none'
            } else{
                conserverInput.style.display = 'none';
                monitorInput.style.display = 'none'
                bossInput.style.display = 'none';
                adminInput.style.display = 'block'
            }
        }
        
        function prepareSubmission() {
	        var role = document.querySelector('input[name="role"]:checked').value;
	        var conserverInput = document.querySelector('#conserver-input input');
	        var monitorInput = document.querySelector('#monitor-input input');
            var bossInput = document.querySelector('#boss-input input');
            var adminInput = document.querySelector('#admin-input input');

			 //根据单选框选中的角色，确保其他输入框的name为空，并设置相应输入框的name
	        if(role === 'conserver') {
                conserverInput.name = 'userName';
                monitorInput.name = '';
                bossInput.name =  '';
	            adminInput.name = '';
	        } else if(role === 'monitor'){
                conserverInput.name = '';
                monitorInput.name = 'userName';
                bossInput.name =  '';
                adminInput.name = '';
	        } else if(role === 'boss'){
                conserverInput.name = '';
                monitorInput.name = '';
                bossInput.name =  'userName';
                adminInput.name = '';
            }else{
                conserverInput.name = '';
                monitorInput.name = '';
                bossInput.name =  '';
                adminInput.name = 'userName';
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
            <input type="radio" name="role" value="conserver" onchange="onRoleChange(this.value)"> 养护人员
            <input type="radio" name="role" value="monitor" onchange="onRoleChange(this.value)"> 检测人员
            <input type="radio" name="role" value="boss" onchange="onRoleChange(this.value)"> 上级管理
            <input type="radio" name="role" value="admin" checked onchange="onRoleChange(this.value)"> 系统管理员
            <br><br>

			<div id="conserver-input" class="hide">
                 	用户名: <input type="text" name="userName"><br>
            </div>
				
            <div id="monitor-input" class="hide">
                    用户名: <input type="text" name="userName"><br>
            </div>
            
			<div id="boss-input" class="hide">
                	用户名: <input type="text" name="userName"><br>
            </div>

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