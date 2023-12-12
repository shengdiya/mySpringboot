<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringManagement" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringManagementService" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringDeviceService" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringIndicatorService" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringIndicator" %>

<%
    User user = (User) request.getSession().getAttribute("admin");
    if(user==null){
        user = (User) request.getSession().getAttribute("monitor");
    }
    PlantService plantService = (PlantService) request.getAttribute("plantservice");
    UserService userService = (UserService) request.getAttribute("userservice");
    MonitoringDeviceService monitoringdeviceservice = (MonitoringDeviceService) request.getAttribute("monitoringdeviceservice");
    List<MonitoringManagement> monitoringmanagementsSearchResult = (List<MonitoringManagement>) request.getSession().getAttribute("monitoringmanagementsSearchResult");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>查看详细信息</title>
    <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">

<div class="searchcontainer">
    <form action="/MonitorManagement?method=SearchMonitorTask" method="post" onsubmit="return handleSearch(this)">
        <select name="searchType" class="shortselect">
            <option value="realName" selected>养护人员真实姓名</option>
            <%--            <option value="fullname">真实姓名</option>--%>
            <%--            <option value="phone">电话</option>--%>
            <%--            <option value="email">邮箱</option>--%>
            <%--            <option value="address">地址</option>--%>
            <option value="plantName">植物种名</option>
            <option value="DeviceName">设备名</option>
            <option value="place">检测地点</option>
        </select>
        <input type="text" placeholder="输入搜索信息" class="search"  name="searchContent">
        <button class="btnsearch" type="submit">搜索</button>
    </form>
</div>

<table class="table-style">
    <thead>
    <tr>
        <th>监测管理id</th>
        <th>监测时间</th>
        <th>监测人员</th>
        <th>监测地点</th>
        <th>监测对象</th>
        <th>监测设备</th>
        <th>监测状态</th>
        <th>操作</th>
        <!-- 其他表格头部数据 -->
    </tr>

    </thead>
    <tbody>
    <% for (MonitoringManagement monitoringmanagement : monitoringmanagementsSearchResult) { %>
    <tr>
        <td><%= monitoringmanagement.getMonitoringManagementId() %></td>
        <td><%= monitoringmanagement.getMonitoringTime() %></td>
        <td><%= userService.selectUserById(monitoringmanagement.getMonitoringPersonnelId()).getRealName() %></td>
        <td><%= monitoringmanagement.getMonitoringLocation()%></td>
        <td><%= plantService.selectPlantByPlantId(monitoringmanagement.getMonitoringObject()).getPlantName()%><%= plantService.selectPlantByPlantId(monitoringmanagement.getMonitoringObject()).getNumber()%></td>
        <td><%= monitoringdeviceservice.selectMonitoringDeviceById(monitoringmanagement.getMonitoringDeviceId()).getMonitoringDeviceName() %></td>
        <td><%= monitoringmanagement.getMonitoringStatus() %></td>
        <td>
            <form action="/MonitorManagement?method=deleteMonitoringManagement" method="POST">
                <input type="hidden" name="id" value=<%=monitoringmanagement.getMonitoringManagementId()%>>
                <button type="submit">删除</button>
            </form>
            <form action="/MonitorManagement?method=modifyMonitoringManagement" method="POST">
                <input type="hidden" name="id" value=<%=monitoringmanagement.getMonitoringManagementId()%>>
                <button type="submit">修改</button>
            </form>
            <form action="/MonitorManagement?method=detailMonitoringManagement" method="POST">
                <input type="hidden" name="id" value=<%=monitoringmanagement.getMonitoringManagementId()%>>
                <button type="submit">详情</button>
            </form>
            <%if(monitoringmanagement.getMonitoringStatus().equals("进行中")) { %>

            <form action="/MonitorManagement?method=endMonitoringManagement" method="POST">
                <input type="hidden" name="id" value=<%=monitoringmanagement.getMonitoringManagementId()%>>
                <button type="submit">结束监测</button>
            </form>
            <%} %>

        </td>

    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
