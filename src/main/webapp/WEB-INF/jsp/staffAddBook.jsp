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
    <title>工作人员增加图书</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
    <div class="container">
        <h2>添加图书</h2>
        <!-- 图书名、图书编号、出版时间、作者、出版社、图书分类、页数、价格 -->
        <form action="/book?method=StaffAddBook" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="bookName" class="required">图书名:</label>
                <input type="text" id="bookName" name="bookName" required>
            </div>
            
            <div class="form-group">
                <label for="outTime" class="required">出版时间:</label>
                <input type="date" id="outTime" name="outTime" required>
            </div>
            
             <div class="form-group">
                <label for="press" class="required">出版社:</label>
                <input type="text" id="press" name="press" required>
            </div>
            
            <div class="form-group">
                <label for="authorName" class="required">作者:</label>
                <input type="text" id="authorName" name="authorName" required>
            </div>
            <div class="form-group">
                <label for="type" class="required">类别:</label>
                <select id="type" name="type" required>
		            <option value="type1">Type 1</option>
		            <option value="type2">Type 2</option>
		            <option value="type3">Type 3</option>
		        </select>
            </div>
            <div class="form-group">
                <label for="pageNumber" class="required">页数:</label>
                <input type="number" id="pageNumber" name="pageNumber" required>
            </div>
            <div class="form-group">
                <label for="price" class="required">价格:</label>
                <input type="number" id="price" name="price" required>
            </div>
            <div class="form-group">
		        <label for="bookImage">图书图片:</label>
		        <input type="file" id="bookImage" name="bookImage" accept=".jpg, .png" >
		    </div>
            
            <div class="form-group">
            	<!-- 隐藏的把这本书属于哪个单位也传过去 -->
<%--            	<input type="hidden" name="whichUnit" value="<%= staff.getWhichUnit() %>">--%>
                <input type="submit" value="提交">
            </div>
        </form>
    </div>
</body>
</html>
