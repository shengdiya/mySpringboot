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
    List<Plant> plants = (List<Plant>) request.getAttribute("plants");
    ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>养护人员任务</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">
<h2>植物列表</h2>
<table class="table-style">
    <tr>
        <th>序号</th>
        <th>种名</th>
        <th>植物编号</th>
        <th>形态特征</th>
        <th>栽培技术要点</th>
        <th>应用价值</th>
        <th>植物病情</th>
        <th>操作</th>
    </tr>
    <% int plantNumber = 0; %>
    <% for (Plant plant:plants) {
    %>
    <tr>
        <td><%= ++plantNumber %></td>
        <td><%= plant.getPlantName() %></td>
        <td><%= plant.getNumber() %></td>
        <td><%= plant.getFeature() %></td>
        <td><%= plant.getCultivation() %></td>
        <td><%= plant.getValue() %></td>
        <%
            List<Integer> pestIds = conserverService.selectPestByPlantId(plant.getPlantId());
            StringBuilder pestNames = new StringBuilder();
            for (Integer pestId:pestIds) {
                Garden_pest pest = conserverService.selectPestByPestId(pestId);
                String pestName = pest.getPestName();
                pestNames.append(pestName);
                pestNames.append("、");
            }
    //        如果pestIds为空，即没有病虫害，就不用去掉尾部的"、"符号了
            if (!pestIds.isEmpty()) pestNames.deleteCharAt(pestNames.length()-1);
        %>
        <td><%= pestNames %></td>
        <td>
            <form action="conserverController/conserverAddPlantPest">
                <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>">
                <input type="hidden" name="plantName" value="<%= plant.getPlantName() %>">
                <button type="submit">添加病情</button>
            </form>
        </td>
        <% } %>
    </tr>
</table>
</body>
</html>
