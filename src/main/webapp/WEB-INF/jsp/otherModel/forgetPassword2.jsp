<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <title>重置密码页面2</title>
 	<link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
 	
  </head>
  
  <body>
 <div class="containerAll">
    <h2>重置密码</h2>
    <!-- 表单action根据实际处理页面进行设置 -->
    <form action="user?method=GetforgetPassword2" method="post">
        	<div class="form-group">
				<label for="code" class="required">请输入验证码：</label>
				<input type="text" id="code" name="code" required>
			</div>
			<p>${codeError}</p>
			<p>验证码已发送，请注意查收.......</p>
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

