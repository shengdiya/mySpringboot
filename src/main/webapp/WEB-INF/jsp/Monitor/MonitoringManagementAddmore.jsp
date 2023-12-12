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
    System.out.println(2);
    MonitoringManagement monitoringManagementaddmore = (MonitoringManagement) request.getAttribute("monitoringManagementaddmore");
    MonitoringDeviceService monitoringdeviceservice = (MonitoringDeviceService) session.getAttribute("monitoringdeviceservice");
    User user = (User) request.getSession().getAttribute("admin");
    if(user==null){
        user = (User) request.getSession().getAttribute("monitor");
    }
    String []monitoringDevices = (String[]) request.getAttribute("monitoringDevices");
    System.out.println(3);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script>
        function filterOptions() {
            var inputValue = document.getElementById("inputText").value.trim();
            var selectOptions = document.getElementById("monitoringDeviceId").options;
            var isMatching = false;
            for (var i = 0; i < selectOptions.length; i++) {
                var optionValue = selectOptions[i].text.trim();
                if (optionValue.indexOf(inputValue) !== -1) {
                    selectOptions[i].style.display = "";
                    isMatching = true;
                } else {
                    selectOptions[i].style.display = "none";
                }
            }
            if (isMatching) {
                document.getElementById("monitoringDeviceId").selectedIndex = -1;
            }
        }

        function updateInputText(selectElement) {
            var selectedValue = selectElement.value;
            document.getElementById("inputText").value = selectedValue;
        }
    </script>
    <title>增加工作人员</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">

<div class="container">
    <h2>增加监测管理信息</h2>
    <form action="/MonitorManagement?method=addmoreMonitorManagement" method="post">
        <div class="form-group">
            <label for="monitoringTime1" class="required">监测时间:</label>
            <input type="datetime-local" id="monitoringTime1" name="monitoringTime1" value="<%=monitoringManagementaddmore.getMonitoringTime()%>" readonly>
        </div>

        <div class="form-group">
            <label for="monitoringPersonnelId" class="required">监测人员ID:</label>
            <input type="number" id="monitoringPersonnelId" name="monitoringPersonnelId" value="<%=monitoringManagementaddmore.getMonitoringPersonnelId()%>" readonly>
        </div>

        <div class="form-group">
            <label for="monitoringLocation" class="required">监测地点:</label>
            <input type="text" id="monitoringLocation" name="monitoringLocation" value="<%=monitoringManagementaddmore.getMonitoringLocation()%>" readonly>
        </div>

        <div class="form-group">
            <label for="monitoringObject" class="required">监测对象:</label>
            <input type="text" id="monitoringObject" name="monitoringObject" value="<%=monitoringManagementaddmore.getMonitoringObject()%>" readonly>

        </div>

        <div class="form-group">
            <label for="monitoringDeviceId" class="required">监测设备ID:</label>
            <input type="text" id="monitoringDeviceId" name="monitoringDeviceId" value="<%=monitoringManagementaddmore.getMonitoringDeviceId()%>">
        </div>

        <%
           System.out.println(1);

           for ( String monitoringdevice :monitoringDevices) {
                System.out.println(monitoringdevice);
        %>
        <div class="form-group">
            <label for="<%= monitoringdevice %>"><%= monitoringdevice %>监测指标:</label>
            <input type="text" id="<%= monitoringdevice %>" name="<%= monitoringdevice %>" required>
        </div>
        <%
            }
        %>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>
    </form>
</div>
</body>
</html>
