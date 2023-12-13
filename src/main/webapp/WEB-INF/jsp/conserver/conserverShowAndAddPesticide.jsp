<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
  User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plantToConserve = (Plant) request.getAttribute("plantToConserve");
  ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
  List<Pesticide> pesticides = (List<Pesticide>) request.getAttribute("pesticides");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>展示与添加药剂</title>

  <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
  <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    setTimeout(function() {
      <% if(request.getAttribute("SQLMessage") != null) { %>
          alert("${SQLMessage}");
      <% } %>
    }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
  });
</script>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="container" >
  <h2>展示与添加药剂</h2>
  <form action="/conserverController?method=addPesticide" method="post">
    <div class="form-group">
      <label for="pesticideName" class="required">药剂名称：</label>
      <input type="text" id="pesticideName" name="pesticideName" required>
    </div>
    <div class="form-group">
      <input type="submit" value="添加">
    </div>
  </form>
  <form action="/conserverController?method=returnToConserverControlPlan" method="post">
    <div class="form-group">
      <input type="submit" value="返回">
    </div>
  </form>
</div>
<div class="container">
<h4>注意：删除药剂种类会清除相应的防治方案！</h4>
<table class="table-style">
  <tr>
    <th>序号</th>
    <th>药剂名称</th>
    <th>操作</th>
  </tr>
  <% int pesticideNumber = 0; %>
  <% for (Pesticide pesticide:pesticides) {
  %>
  <tr>
    <td><%= ++pesticideNumber %></td>
    <%--    <td><%= pest.getPestId() %></td>--%>
    <td><%= pesticide.getPesticideName() %></td>
    <td>
<%--      todo:删除操作--%>
      <%--由于外键的设置，在删除药剂记录的时候，会一并把关联的养护任务、植物病虫害记录删除--%>
      <form action="/conserverController?method=deletePesticide" method="post">
        <input type="hidden" name="pesticideId" value="<%= pesticide.getPesticideId() %>">
        <input type="submit" value="删除">
      </form>
    </td>
  </tr>
  <% } %>
</table>
</div>
</body>
</html>
