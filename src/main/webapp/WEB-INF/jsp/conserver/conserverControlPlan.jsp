<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
    User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plantToConserve = (Plant) request.getAttribute("plantToConserve");
    ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
    List<Pest_control_plan> pestControlPlans = (List<Pest_control_plan>) request.getAttribute("pestControlPlans");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>防治方案展示</title>
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
    <h2>防治方案展示</h2>
    <div id="left-container">
        <%if(roleId == 1 || roleId == 2) { %>
        <form action="/conserverController/showAndaddPesticide" method="post">
            <div class="form-group">
                <input type="submit" value="查看与添加药剂">
            </div>
        </form>
        <%} %>
    </div>
    <div>
        <%if(roleId == 1 || roleId == 2) { %>
        <form action="/conserverController/addControlPlan" method="post">
            <div class="form-group">
                <input type="submit" value="添加防治方案">
            </div>
        </form>
        <%} %>
    </div>
</div>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>病虫害名称</th>
        <th>药剂名称</th>
        <th>防治方法</th>
        <th>药剂用量</th>
        <th>作用期限</th>
        <th>操作</th>
    </tr>
    <% int controlPlanNumber = 0; %>
    <% for (Pest_control_plan pestControlPlan:pestControlPlans) {
    %>
    <tr>
        <td><%= ++controlPlanNumber %></td>
        <%
        String pestName = conserverService.selectPestByPestId(pestControlPlan.getPestId()).getPestName();
        %>
        <td><%= pestName %></td>
        <%
        String pesticideName = conserverService.selectPesticideByPesticideId(pestControlPlan.getPesticideId()).getPesticideName();
        %>
        <td><%= pesticideName %></td>
        <td><%= pestControlPlan.getControlMethod() %></td>
        <td><%= pestControlPlan.getPesticideDose() %></td>
        <td><%= pestControlPlan.getEffectDuration() %></td>
        <td>
            <%--根据病虫害ID和药剂ID联合主键执行删除--%>
                <%if(roleId == 1 || roleId == 2) { %>
            <form action="conserverController?method=deleteControlPlanById" method="post">
                <input type="hidden" name="pestId" value="<%= pestControlPlan.getPestId() %>">
                <input type="hidden" name="pesticideId" value="<%= pestControlPlan.getPesticideId() %>">
                <input type="submit" value="删除">
            </form>
                <%} %>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>