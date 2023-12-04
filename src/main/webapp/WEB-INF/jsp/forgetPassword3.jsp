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
	// 当文档加载完成后绑定事件到表单的提交操作
    window.onload = function() {
        var form = document.querySelector('form');
        form.onsubmit = function(event) {
            // 获取密码和确认密码的值
            var password = document.getElementById('password').value;
            var passwordAgain = document.getElementById('passwordAgain').value;

            // 检查两次输入的密码是否一致
            if(password !== passwordAgain) {
                // 如果不一致，阻止表单提交并警告用户
                alert('两次输入的密码不一致，请重新输入！');
                event.preventDefault(); // 阻止表单继续提交
            }
            // 如果一致，表单会正常提交
        };
    };
</script>
	 
 <div class="containerAll">
    <h2>重置密码</h2>
    <!-- 表单action根据实际处理页面进行设置 -->
    <form action="user?method=GetforgetPassword3" method="post">
        	<div class="form-group">
				<label for="password" class="required">请输入新密码：</label>
				<input type="text" id="password" name="password" required>
			</div>
			<div class="form-group">
				<label for="passwordAgain" class="required">确认密码：</label>
				<input type="password" id="passwordAgain" name="passwordAgain" required>
			</div>
			
			<div class="form-group">
				<div class="button-container">
					<input type="submit" value="完成">
	            	<input type="button" value="返回首页" onclick="javascript:window.location.href ='/user/login'">
            	</div>
			</div>
    </form>
</div>
  </body>
</html>

