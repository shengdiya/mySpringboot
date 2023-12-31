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
    User user1 = (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");

    MonitoringManagement monitoringmanagementdetail = (MonitoringManagement) request.getAttribute("monitoringManagementmodify");
    String []monitoringindictors = monitoringmanagementdetail.getMonitoringIndicatorValues().split(";");
    String []monitoringDevices = (String[]) request.getAttribute("monitoringDevices");
    UserService userservice = (UserService) request.getAttribute("userservice");

%>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>修改监测任务</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="container">
    <h2>修改监测管理信息</h2>
    <form action="/MonitorManagement?method=modifyMonitorManagements" method="post">
        <div class="form-group">
            <label for="monitoringTime1" class="required">监测时间:</label>
            <input type="datetime-local" id="monitoringTime1" name="monitoringTime1" value="<%=monitoringmanagementdetail.getMonitoringTime()%>" required>
        </div>

        <div class="form-group">
            <label for="monitoringPersonnelId" class="required">监测人员:</label>
            <select id="monitoringPersonnelId" name="monitoringPersonnelId" required>
                <%
                    List<User> users = userservice.selectAllUsers();
                    for(User u : users){
                        if(userservice.getUserRole(u.getUserId()).equals("监测人员")){
                %>
                <option value="<%= u.getUserId() %>"><%= u.getRealName() %></option>
                <% }
                } %>
            </select>
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

    <form action="/MonitorManagement?method=returnMonitoringManagementShow" method="post">
        <div class="form-group">
            <input type="submit" value="返回">
        </div>
    </form>
</div>
</body>
</html>
