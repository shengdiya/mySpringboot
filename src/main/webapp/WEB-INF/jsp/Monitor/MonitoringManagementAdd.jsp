<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>
<%@ page import="com.myapp.demo.Entiy.Monitor.MonitoringDevice" %>
<%@ page import="com.myapp.demo.Service.Monitor.MonitoringDeviceService" %>

<%
    User user = (User) request.getSession().getAttribute("admin");
    if(user==null){
        user = (User) request.getSession().getAttribute("monitor");
    }
    Plant plantToBoMonitor = (Plant) request.getAttribute("plantToBoMonitor");
    UserService userservice = (UserService) request.getAttribute("userservice");
    List<MonitoringDevice> MonitoringDevices = (List<MonitoringDevice>)request.getAttribute("MonitoringDevices");
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
    <form action="/MonitorManagement?method=addMonitorManagement" method="post">
        <div class="form-group">
            <label for="monitoringTime1" class="required">监测时间:</label>
            <input type="datetime-local" id="monitoringTime1" name="monitoringTime1" required>
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
            <input type="text" id="monitoringLocation" name="monitoringLocation" required>
        </div>

        <div class="form-group">
            <label for="monitoringObject" class="required">监测对象:</label>
            <input type="hidden" id="monitoringObject" name="monitoringObject" value="<%= plantToBoMonitor.getPlantId()%>">
            <input type="text" id="show" name="show" value="<%= plantToBoMonitor.getPlantName()%><%= plantToBoMonitor.getNumber()%>" readonly>
        </div>

        <div class="form-group">
            <label for="monitoringDeviceId" class="required">监测设备ID:</label>
            <input type="text" id="inputText" oninput="filterOptions()" placeholder="可以搜索下拉框内容">
        </div>
        <div class="form-group">
            <select id="monitoringDeviceId" name="monitoringDeviceId" onchange="updateInputText(this)" required>
                <%
                    if (MonitoringDevices != null) {
                        for (MonitoringDevice monitoringdevice : MonitoringDevices) {
                            String display = monitoringdevice.getMonitoringDeviceName();
                            int id = monitoringdevice.getMonitoringDeviceId();// 获取要显示设备名
                %>
                <option value="<%= id %>"><%= display %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>
    </form>

    <form action="/plant?method=returnPlantSameSpeciesList" method="post">
        <div class="form-group">
            <input type="submit" value="返回">
        </div>
    </form>
</div>
</body>
</html>
