<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
    User admin = (User) request.getSession().getAttribute("admin");
    List<Plant> plants = (List<Plant>) request.getAttribute("plantsInSameSpecies");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= admin.getUserName() %>">
<h2>全部图书信息</h2>
<table class="table-style">
    <tr>
        <th>植物编号</th>
        <th>植物种名</th>
<%--        <th>养护状态</th>--%>
<%--        <th>监测状态</th>--%>
        <th>基本信息管理</th>
<%--        <th>养护与监测管理</th>--%>
    </tr>
    <% for (int i = 0; i < plants.size(); i++) {
        Plant plant = plants.get(i);
    %>
    <tr>
        <td><%= plant.getNumber() %></td>
        <td><%= plant.getPlantName() %></td>
<%--        <td><%= if(养护任务服务类.select一条养护记录ByplantIdAndStatus(plantId,"进行中")==null) 该位置显示“未分配养护任务
                    else 此处显示“已分配养护任务” %></td>      齐贇波TODO--%>
<%--        <td><%= if(监测任务服务类.select一条监测记录ByplantIdAndStatus(plantId,"进行中")==null) 该位置显示“未分配养护任务
                    else 此处显示“已分配养护任务” %></td>      唐景瑞TODO--%>
        <!--以上两条业务逻辑可以在service层中编写函数，不一定要在这个界面用纯jsp实现-->

        <td>
            <!-- 前两个需要跳转到一个新的界面，而删除后需要留在原界面，这里采用form表单提交的方式 -->
            <form action="/plant?method=deletePlant" method="post">
                <a href="/plant/adminSeePlantDetails?plant=<%= plant.getPlantId() %>" class="action-button detail-button">详情</a>
                <a href="/plant/adminModifyPlantDetails?plant=<%= plant.getPlantId() %>" class="action-button edit-button">修改</a>

                <!-- 隐藏的userId，用于删除时向后端传递参数，后端可以通过request.getParameter("userId")得到这个Id -->
                <input type="hidden" name="plantId" value="<%= plant.getPlantId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="删除" class="action-button delete-button">
            </form>
        </td>

<%--        <td>--%>
<%--            <!--以下两条为超链接，点击后跳转到增加养护/监测任务的界面，--%>
<%--                跳转前要先判断该植物有没有正在进行的养护/监测任务，如果有则不允许跳转，或者直接禁用超链接，或者不让在增加界面中提交增加记录，反正就想办法不让增加-->--%>
<%--            <a href="#?plant=<%= plant.getPlantId() %>" class="action-button detail-button">添加养护记录</a>--%> 齐贇博TODO
<%--            <a href="#?plant=<%= plant.getPlantId() %>" class="action-button edit-button">添加监测记录</a>--%>  唐景睿TODO
<%--        </td>--%>

    </tr>
    <% } %>
</table>

</body>
</html>