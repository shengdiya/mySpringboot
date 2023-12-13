<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");List<ConserveTask> conserveTasks = (List<ConserveTask>) request.getAttribute("conserveTasks");
    ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>养护人员任务</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">
<h2>任务列表</h2>

<div class="searchcontainer">
    <form action="/conserverController?method=SearchTask" method="post" onsubmit="return handleSearch(this)">
        <select name="searchType" class="shortselect">
            <option value="taskName" selected>任务名称</option>
            <option value="realName">养护人员姓名</option>
            <option value="plantName">植物种名</option>
            <option value="pestName">病虫害名称</option>
            <option value="place">检测地点</option>
        </select>
        <input type="text" placeholder="输入搜索信息" class="search"  name="searchContent">
        <button class="btnsearch" type="submit">搜索</button>
    </form>
</div>

<table class="table-style">
    <tr>
        <th>序号</th>
        <th>任务名称</th>
        <th>执行时间</th>
        <th>执行地点</th>
        <th>执行人员</th>
        <th>任务描述</th>
        <th>植物养护对象</th>
        <th>病虫害名称</th>
        <th>任务状态</th>
        <th>操作</th>
    </tr>
    <% int conserveTaskNumber = 0; %>
    <% for (ConserveTask conserveTask:conserveTasks) {
    %>
    <tr>
        <td><%= ++conserveTaskNumber %></td>
        <td><%= conserveTask.getTaskName() %></td>
        <td><%= conserveTask.getExecutionTime() %></td>
        <td><%= conserveTask.getExecutionLocation() %></td>
        <td><%= conserverService.selectConserverNameByConserverId(conserveTask.getExecutionPersonnel()) %></td>
        <td><%= conserveTask.getTaskDescription() %></td>
        <th><%= conserverService.viewsSelectConservePlant(conserveTask.getTaskId()) %><%= conserverService.selectPlantByPlantId(conserveTask.getPlantId()).getNumber()%></th>
        <th><%= conserverService.viewsSelectConservePest(conserveTask.getTaskId()) %></th>
        <td>
            <%
                if (conserveTask.getStatus() == conserveTask.STATUS_NOT_START) {
            %>
            未开始
            <%
                } else if (conserveTask.getStatus() == conserveTask.STATUS_IN_PROGRESS) {
            %>
            进行中
            <%
                } else if (conserveTask.getStatus() == conserveTask.STATUS_FINISHED) {
            %>
            已完成
            <%
                } else {
            %>
            任务状态不合法
            <%
                }
            %>
        </td>
        <%if(roleId == 1 || roleId == 2) { %>
        <td>
            <% if (conserveTask.getStatus() == conserveTask.STATUS_NOT_START) {%>
            <form action="conserverController?method=status_start" method="post">
                <!-- 隐藏的taskId，用于修改任务状态为开始时向后端传递参数，后端可以通过request.getParameter("taskId")得到这个Id -->
                <input type="hidden" name="taskId" value="<%= conserveTask.getTaskId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="开始" class="action-button edit-button" required>
            </form>
            <% } else if (conserveTask.getStatus() == conserveTask.STATUS_IN_PROGRESS) { %>
            <form action="conserverController?method=status_finish" method="post">
                <!-- 隐藏的taskId，用于修改任务状态为开始时向后端传递参数，后端可以通过request.getParameter("taskId")得到这个Id -->
                <input type="hidden" name="taskId" value="<%= conserveTask.getTaskId() %>">
                <input type="hidden" name="plantId" value="<%= conserveTask.getPlantId() %>">
                <input type="hidden" name="pestId" value="<%= conserveTask.getPestId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="完成" class="action-button edit-button">
            </form>
            <% } else if (conserveTask.getStatus() == conserveTask.STATUS_FINISHED) { %>
            <form action="conserverController?method=deleteTaskByTaskId" method="post">
                <!-- 隐藏的taskId，用于修改任务状态为开始时向后端传递参数，后端可以通过request.getParameter("taskId")得到这个Id -->
                <input type="hidden" name="taskId" value="<%= conserveTask.getTaskId() %>">
                <!-- input按钮用CSS时鼠标悬浮时变小手 -->
                <input type="submit" value="删除" class="action-button edit-button">
            </form>
            <% } else { %>
            <p>任务状态不合法</p>
            <% } %>
        </td>
        <% } %>
    </tr>
    <% } %>
</table>

</body>
</html>

