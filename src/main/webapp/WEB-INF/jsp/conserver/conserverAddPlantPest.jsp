<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
  User user = null;
  List<String> roles = Arrays.asList("admin", "monitor", "boss", "conserver");
  for(String role : roles) {
    user = (User) request.getSession().getAttribute(role);
    if(user != null) {
      break;
    }
  }
  ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>添加任务</title>
  <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">

<div class="container">
  <h2>添加植物病虫害</h2>
  <form action="/conserverController?method=addPlantPest" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="plantId" class="required">关联植物编号：</label>
      <input id="plantId" name="plantId" required readonly value="<%=request.getAttribute("plantId")%>">
    </div>
    <div class="form-group">
      <label for="plantName" class="required">关联植物名称：</label>
      <input id="plantName" name="plantName" required readonly value="<%=request.getAttribute("plantName")%>">
    </div>
    <div class="form-group">
      <label for="pestId" class="popup_title">请选择植物感染的病虫害种类：</label>
<%--name标签要放在select里而不是option里，用于传递键值对--%>
      <select id="pestId" name="pestId">
        <%
          List<Garden_pest> pests = conserverService.selectAllPests();
          for (Garden_pest pest : pests) {
        %>
        <%--在选中某一个病虫害名称时，指定它对应的ID，传出去的是病虫害ID--%>
        <option id="pestSelect" value="<%= pest.getPestId() %>"><%= pest.getPestName() %></option>
        <% } %>
      </select>
    </div>
    <div class="form-group">
      <input type="submit" value="提交">
    </div>
  </form>
</div>
</body>
</html>
