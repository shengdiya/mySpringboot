<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>

<%
    User user = (User) request.getSession().getAttribute("admin");
    if(user==null){
        user = (User) request.getSession().getAttribute("monitor");
    }
    MonitoringDevice monitoringdevice = (MonitoringDevice)request.getAttribute("monitoringDevicemodify");
    String name = monitoringdevice.getMonitoringDeviceName();


%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
    <script>

        function addInput() {
            var inputContainer = document.getElementById("inputContainer");
            var newInput = document.createElement("input");
            newInput.type = "text";
            newInput.name = "inputField[]";
            newInput.required = true;
            inputContainer.appendChild(newInput);
        }

    </script>
    <title>增加工作人员</title>


</head>
<body>
<input name="safe" type="hidden" value="<%= user.getUserName() %>">
<input name="oldname" type="hidden" value="<%= name %>">

<div class="container">
    <h2>增加监测管理信息</h2>
    <form action="MonitorDevice?method=modifyMonitorDevices" method="post">
        <div class="form-group">
            <label for="monitoringDeviceId" class="required">设备id:</label>
            <input type="text" id="monitoringDeviceId" name="monitoringDeviceId"  value="<%=monitoringdevice.getMonitoringDeviceId()%>" readonly>
        </div>
        <div class="form-group">
            <label for="monitoringIndicatorName" class="required">设备名字:</label>
            <input type="text" id="monitoringIndicatorName" name="monitoringDeviceName"  value="<%=name%>" required>
        </div>
        <div class="form-group">
            <label for="monitoringDeviceStatus" class="required">设备状态:</label>
            <input type="text" id="monitoringDeviceStatus" name="monitoringDeviceStatus"  readonly>
        </div>

        <div class="form-group">
            <input type="number" id="inputNumber" name="inputNumber"/>
            <button type="button" onclick="generateInputFields()">生成输入框</button>
            <div id="inputContainer"></div>
        </div>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>
    </form>
</div>

</body>
</html>
