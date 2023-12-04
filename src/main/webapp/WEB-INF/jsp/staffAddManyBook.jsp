<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
 %>

<!DOCTYPE html>
<html lang="en">
  <head> 
    <title>批量导入图书</title>
    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">

  </head>
  
  <body>
  <input name="safe" type="hidden" value="<%= staff.getUserName() %>">
    <div class="container">
        <h2>批量添加图书</h2>
        
         <form action="/book?method=StaffAddManyBooks" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="excelFile">选择Excel文件:</label>
                <input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls" required>
            </div>
            <div class="form-group">
                <input type="submit" value="上传并导入">
            </div>
        </form>

    </div>
  </body>
</html>
