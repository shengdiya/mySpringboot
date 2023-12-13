<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");
  List<Garden_pest> pests = (List<Garden_pest>) request.getAttribute("pests");
  ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>病虫害类型展示</title>
  <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<style>
  .head-container {
    display: flex;
    align-items: center;
  }

  #left-container {
    margin-left: auto;
  }
</style>

<div class="head-container">
  <h2>病虫害类型展示</h2>
  <div id="left-container">
      <%if(roleId == 1 || roleId == 2) { %>
    <form action="/conserverController?method=addPest" method="post">

      <div class="form-group">
        <label for="pestName">快捷添加病虫害名称：</label>
        <input id="pestName" name="pestName" required>
        <input type="submit" value="提交">
      </div>
    </form>
      <%} %>
  </div>

</div>
<h4>注意：删除病虫害种类会清除相应养护任务，也会清除植物病虫害表中植物感染相应病虫害的记录！</h4>
<table class="table-style">
  <tr>
    <th>序号</th>
    <th>名称</th>
    <th>感染植物</th>
    <th>关联养护任务</th>
    <th>操作</th>
  </tr>
    <% int pestNumber = 0; %>
  <% for (Garden_pest pest:pests) {
  %>
  <tr>
      <td><%= ++pestNumber %></td>
<%--    <td><%= pest.getPestId() %></td>--%>
    <td><%= pest.getPestName() %><%%></td>
<%--查询这种病虫害感染了哪些植物--%>
    <%
//      List<Integer> plantIds = conserverService.selectPlantByPestId(pest.getPestId());
        List<String> plantNameLists = conserverService.viewsSelectPestPlant(pest.getPestId());
        StringBuilder plantNames = new StringBuilder();
      for (String plantName:plantNameLists) {
        String plantNamePlusNumber = plantName + conserverService.viewsSelectPestPlantNumber(pest.getPestId());
        plantNames.append(plantNamePlusNumber);
        plantNames.append("、");
      }
//        如果plantIds为空，即没有病虫害，就不用去掉尾部的"、"符号了
      if (!plantNameLists.isEmpty()) plantNames.deleteCharAt(plantNames.length()-1);
    %>
    <td><%= plantNames %></td>

<%--查询这种病虫害关联哪些养护任务--%>
      <%
      List<String> conserveTaskNameLists = conserverService.viewsSelectPestConserveTask(pest.getPestId());
      StringBuilder conserveTaskNames = new StringBuilder();
      for (String conserveTask:conserveTaskNameLists) {
        conserveTaskNames.append(conserveTask);
        conserveTaskNames.append("、");
      }
//        如果conserveTasks为空，即没有关联任务，就不用去掉尾部的"、"符号了
        if (!conserveTaskNameLists.isEmpty()) conserveTaskNames.deleteCharAt(conserveTaskNames.length()-1);
      %>
    <td><%= conserveTaskNames %></td>
    <td>
<%--由于外键的设置，在删除病虫害记录的时候，会一并把关联的养护任务、植物病虫害记录删除--%>
    <%if(roleId == 1 || roleId == 2) { %>
      <form action="conserverController?method=deletePestById" method="post">
        <input type="hidden" name="pestId" value="<%= pest.getPestId() %>">
        <input type="submit" value="删除">
      </form>
    <% } %>
    </td>
  </tr>
  <% } %>
</table>

</body>
</html>