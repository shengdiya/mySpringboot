<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
    Book book = (Book) request.getAttribute("book");
 %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>工作人员修改图书详细信息</title>
	 <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
  </head>
  
  <body>
    <input name="safe" type="hidden" value="<%= staff.getUserName() %>">
  
	  <div class="containerAll">
		  <h2>修改<%= book.getBookName() %>的信息</h2>
		  <form action="/book?method=StaffModifyBookDetails" method="post" enctype="multipart/form-data">
		 	<input type="hidden" name="bookId" value="<%= book.getBookId() %>" />
            <div class="form-group">
                <label for="bookName" class="required">图书名称：</label>
                <input type="text" id="bookName" name="bookName" value="<%= book.getBookName() %>" required>
            </div>

            <div class="form-group">
                <label for="outTime" class="required">出版时间：</label>
                <input type="text" id="outTime" name="outTime" value="<%= book.getOutTime() %>" required>
            </div>
            <div class="form-group">
                <label for="authorName" class="required">作者：</label>
                <input type="text" id="authorName" name="authorName" value="<%= book.getAuthorName() %>" required>
            </div>
            <div class="form-group">
                <label for="press" class="required">出版社:</label>
                <input type="text" id="press" name="press" value="<%= book.getPress() %>" required>
            </div>
            <div class="form-group">
                <label for="pageNumber" class="required">页数:</label>
                <input type="number" id="pageNumber" name="pageNumber" value="<%= book.getPageNumber() %>" required>
            </div>
            <div class="form-group">
                <label for="price" class="required">价格:</label>
                <input type="number" id="price" name="price" value="<%= book.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="type" class="required">类别:</label>
                <input type="text" id="type" name="type" value="<%= book.getType() %>" required>
            </div>
            <div class="form-group">
		        <label for="bookImage">图书图片:</label>
		        <input type="file" id="bookImage" name="bookImage" accept=".jpg, .png" >
		    </div>
            <div class="form-group">
                <input type="submit" value="提交">
            </div>
		  </form>
		  
		  <form action="/book?method=staffReturnBookList" method="post">
		  	<div class="form-group">
	             <input type="submit" value="返回">
	        </div> 
		  </form>
	  </div>
  </body>
</html>
