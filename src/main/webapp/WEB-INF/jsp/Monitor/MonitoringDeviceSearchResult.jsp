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
 User user1 = (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");
  List<MonitoringDevice> monitoringdevices = (List<MonitoringDevice>) request.getSession().getAttribute("monitoringdevices");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>查看详细信息</title>
  <link rel="stylesheet" type="text/css" href="/css/tables.css">
</head>

<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="searchcontainer">
  <form action="/MonitorDevice?method=deviceSearch" method="post" onsubmit="return handleSearch(this)">
    <input type="text" placeholder="输入设备名查找信息" class="search"  name="searchContent">
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
