<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringManagement" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringDeviceService" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>

<%
    User user = (User) request.getSession().getAttribute("admin");
    if(user==null){
        user = (User) request.getSession().getAttribute("monitor");
    }

    MonitoringManagement monitoringmanagementdetail = (MonitoringManagement) request.getAttribute("monitoringmanagementdetail");
    MonitoringDeviceService monitoringdeviceservice = (MonitoringDeviceService) session.getAttribute("monitoringdeviceservice");
    String []monitoringindictors = monitoringmanagementdetail.getMonitoringIndicatorValues().split(";");
    String []monitoringDevices = (String[]) request.getAttribute("monitoringDevices");
%>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>增加工作人员</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">

<div class="container">
    <h2>增加监测管理信息</h2>
    <form action="MonitorManagement?method=modifyMonitorManagements" method="post">
        <div class="form-group">
            <label for="monitoringTime1" class="required">监测时间:</label>
            <input type="datetime-local" id="monitoringTime1" name="monitoringTime1" value="<%=monitoringmanagementdetail.getMonitoringTime()%>" required>
        </div>

        <div class="form-group">
            <label for="monitoringPersonnelId" class="required">监测人员ID:</label>
            <input type="number" id="monitoringPersonnelId" name="monitoringPersonnelId" value="<%=monitoringmanagementdetail.getMonitoringPersonnelId()%>" required>
        </div>

        <div class="form-group">
            <label for="monitoringLocation" class="required">监测地点:</label>
            <input type="text" id="monitoringLocation" name="monitoringLocation" value="<%=monitoringmanagementdetail.getMonitoringLocation()%>" required>
        </div>

        <div class="form-group">
            <label for="monitoringObject" class="required">监测对象:</label>
            <input type="text" id="monitoringObject" name="monitoringObject" value="<%=monitoringmanagementdetail.getMonitoringObject()%>" required>

        </div>

        <div class="form-group">
            <label for="monitoringDeviceId" class="required">监测设备ID:</label>
            <input type="text" id="monitoringDeviceId" name="monitoringDeviceId" value="<%=monitoringmanagementdetail.getMonitoringDeviceId()%>"readonly>
        </div>

        <%
           System.out.println(1);
            int i = -1;
           for ( String monitoringindictor :monitoringindictors) {
               i++;
                System.out.println(monitoringindictor);
        %>
        <div class="form-group">
            <label for="<%= monitoringindictor+i %>"><%= monitoringDevices[i] %>监测指标:</label>
            <input type="text" id="<%= monitoringindictor+i %>" name="<%= monitoringDevices[i] %>" value="<%=monitoringindictor%>"required>
        </div>
        <%
            }
        %>
        <div class="form-group">
            <label for="monitoringStatus" class="required">监测状态:</label>
            <input type="text" id="monitoringStatus" name="monitoringStatus" value="<%=monitoringmanagementdetail.getMonitoringStatus()%>"readonly>
        </div>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>

    </form>
</div>
</body>
</html>
