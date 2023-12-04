<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %> 
<%@ page import="com.myapp.demo.Service.*" %>

<%
    Book book = (Book) request.getAttribute("book");
    User user = (User) request.getSession().getAttribute("reader");
 %>
 
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>管理员修改图书详细信息</title>
	 <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
  </head>
  
  <body>
	  <div class="containerAll" style="width: 350px">
		  <h2>借阅图书<%= book.getBookName() %></h2>
		  <form action="/book?method=GetBorrowBooks" method="post">
		 	<input type="hidden" name="bookId" value="<%= book.getBookId() %>" />
		 	<input type="hidden" name="userId" value="<%= user.getUserId() %>" />
            <div class="form-group">
                <label for="outTime" class="required">借出时间：</label>
                <input type="date" id="outTime" name="outTime" required>
            </div>
            <div class="form-group">
                <label for="returnTime" class="required">归还时间：</label>
                <input type="date" id="returnTime" name="returnTime" required>
            </div>
            <div class="form-group">
                <label for="realName" class="required">申请人姓名:</label>
                <input type="text" id="realName" name="realName"required>
            </div>
            <div class="form-group">
                <label for="telephone" class="required">联系方式:</label>
                <input type="tel" id="telephone" name="telephone" required>
            </div>
            <div class="form-group">
                <label for="reason">借书原因:</label>
                <input type="text" id="reason" name="reason">
            </div>
            <div class="form-group">
                <label for="detail">备注:</label>
                <input type="text" id="detail" name="detail">
            </div>

            <div class="form-group">
                <input type="submit" value="提交">
            </div>
		  </form>
		  
		  <form action="/book?method=raederReturnBookList" method="post">
		  	<div class="form-group">
	    		<input type="submit" value="返回">
	   		 </div>
		  </form>
		  
	  </div>
  </body>
</html>
