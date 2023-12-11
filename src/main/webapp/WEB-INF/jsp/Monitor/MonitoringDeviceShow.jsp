<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringDeviceService" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringDeviceService" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringIndicatorService" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringIndicator" %>

<%
    User user = null;
    List<String> roles = Arrays.asList("admin", "monitor", "boss");
    for(String role : roles) {
        user = (User) request.getSession().getAttribute(role);
        if(user != null) {
            break;
        }
    }
    MonitoringDeviceService monitoringdeviceservice = (MonitoringDeviceService ) session.getAttribute("monitoringdeviceservice");
    MonitoringIndicatorService monitoringindicatorservice = (MonitoringIndicatorService ) session.getAttribute("monitoringindicatorservice");
    List<MonitoringDevice> monitoringdevices = (List<MonitoringDevice>) request.getAttribute("monitoringdevices");

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
    <form action="Managershowuser" method="post" onsubmit="return handleSearch(this)">
        <select name="searchType" class="shortselect">
            <option value="username" selected>用户名</option>
            <option value="fullname">真实姓名</option>
            <option value="phone">电话</option>
            <option value="email">邮箱</option>
            <option value="address">地址</option>
            <option value="workplace">工作单位</option>
        </select>
        <input type="text" placeholder="输入搜索信息" class="search"  name="searchContent">
        <button class="btnsearch" type="submit">搜索</button>
    </form>
</div>


<table class="table-style">
    <thead>
    <tr>
        <th>监测设备id</th>
        <th>监测设备名称</th>
        <th>监测指标种类</th>
        <th>监测设备状态</th>
        <th>操作</th>
        <!-- 其他表格头部数据 -->
    </tr>


    </thead>
    <tbody>
    <% for (MonitoringDevice monitoringdevice : monitoringdevices) { %>
    <tr>


        <td><%= monitoringdevice.getMonitoringDeviceId() %></td>
        <td><%= monitoringdevice.getMonitoringDeviceName() %></td>
        <td><%= monitoringdevice.getMonitoringIndicatorCategories() %></td>
        <td><%= monitoringdevice.getMonitoringDeviceStatus()%></td>


        <td>
            <form action="/MonitorDevice?method=deleteMonitoringDevice" method="POST">
                <input type="hidden" name="id" value="<%=monitoringdevice.getMonitoringDeviceId()%>">
                <button type="submit">删除</button>
            </form>
            <form action="/MonitorDevice?method=modifyMonitoringDevice" method="POST">
                <input type="hidden" name="id" value="<%=monitoringdevice.getMonitoringDeviceId()%>">
                <button type="submit">修改</button>
            </form>

        </td>

    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
