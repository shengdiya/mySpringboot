<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
  User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plantToConserve = (Plant) request.getAttribute("plantToConserve");
  ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>添加防治方案</title>

  <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="container">
  <h2>添加防治方案</h2>
  <form action="/conserverController?method=addControlPlan" method="post">
    <div class="form-group">
      <label for="pestId" class="required">病虫害名称：</label>
      <select id="pestId" name="pestId">
        <%
          List<Garden_pest> pests = conserverService.selectAllPests();
          for (Garden_pest pest : pests) {
        %>
        <option id="pestSelect" value="<%= pest.getPestId() %>"><%= pest.getPestName() %></option>
        <% } %>
      </select>
    </div>
    <div class="form-group">
      <label for="pesticideId" class="required">药剂名称：</label>
      <select id="pesticideId" name="pesticideId">
        <%
          List<Pesticide> pesticides = conserverService.selectAllPesticide();
          for (Pesticide pesticide : pesticides) {
        %>
        <option id="pesticideSelect" value="<%= pesticide.getPesticideId() %>"><%= pesticide.getPesticideName() %></option>
        <% } %>
      </select>
    </div>
    <div class="form-group">
      <label for="controlMethod" class="required">防治方法：</label>
      <input type="text" id="controlMethod" name="controlMethod" required>
    </div>

    <div class="form-group">
      <label for="pesticideDose" class="required">药剂用量：</label>
      <input type="text" id="pesticideDose" name="pesticideDose" required>
    </div>

    <div class="form-group">
      <label for="effectDuration" class="required">作用期限：</label>
      <input type="text" id="effectDuration" name="effectDuration" required>
    </div>

    <div class="form-group">
      <input type="submit" value="提交">
<%--      <input type="submit" formaction="conserverController?method=returnToconserverControlPlan" value="返回">--%>
    </div>
  </form>
  <div class="form-group">
    <form action="/conserverController?method=returnToConserverControlPlan" method="post">
      <input type="submit" value="返回">
    </form>
  </div>
</div>
</body>
</html>
