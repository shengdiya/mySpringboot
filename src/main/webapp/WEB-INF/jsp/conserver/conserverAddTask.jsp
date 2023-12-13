<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="lombok.var" %>
<%
User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plantToConserve = (Plant) request.getAttribute("plantToConserve");
    ConserverService conserverService = (ConserverService) request.getAttribute("conserverService");
    UserService userService = (UserService) request.getAttribute("userservice");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>添加任务</title>

    <link rel="stylesheet" type="text/css" href="/css/addAndModifyUserDetails.css">
</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="container">
    <h2>添加任务</h2>
    <form action="/conserverController?method=AddTask" method="post">
        <div class="form-group">
            <label for="taskName" class="required">任务名称：</label>
            <input type="text" id="taskName" name="taskName" required>
        </div>
        <div class="form-group">
            <label for="executionTime" class="required">执行时间：</label>
            <input type="date" id="executionTime" name="executionTime" required>
        </div>
        <div class="form-group">
            <label for="executionLocation" class="required">执行地点：</label>
            <input type="text" id="executionLocation" name="executionLocation" required>
        </div>

        <div class="form-group">
            <label for="executionPersonnel" class="required">执行人员：</label>
            <select id="executionPersonnel" name="executionPersonnel" required>
                <%
                    List<User> users = userService.selectAllUsers();
                    for(User u : users){
                        if(userService.getUserRole(u.getUserId()).equals("养护人员")){
                            %>
                <option value="<%= u.getUserId() %>"><%= u.getRealName() %></option>
                        <% }
                    } %>

            </select>
        </div>

<%--        <div class="form-group">--%>
<%--            <input type="hidden" id="executionPersonnel" name="executionPersonnel" value="<%= user.getUserId() %>">--%>
<%--        </div>--%>

        <div class="form-group">
            <label for="taskDescription" class="required">任务描述：</label>
            <input type="text" id="taskDescription" name="taskDescription" required>
        </div>
        <div class="form-group">
            <label for="plantId" class="required">植物养护对象：</label>
            <input type="hidden" id="plantId" name="plantId" value="<%= plantToConserve.getPlantId()%>">
            <input type="text" id="show" name="show" value="<%= plantToConserve.getPlantName()%><%= plantToConserve.getNumber()%>" readonly>

<%--            <select id="plantId" name="plantId">--%>
<%--            <%--%>
<%--                List<Plant> plants = conserverService.selectAllPlants();--%>
<%--                for (Plant plant : plants) {--%>
<%--            %>--%>
<%--                <option id="plantSelect" value="<%= plant.getPlantId() %>"> <%= plant.getPlantName() %> </option>--%>
<%--                <% } %>--%>
<%--            </select>--%>
        </div>
        <div class="form-group">
            <label for="pestId" class="required">病虫害名称：</label>
            <select id="pestId" name="pestId">
                <%
                    List<Garden_pest> pests = conserverService.selectAllPests();
                    for (Garden_pest pest : pests) {
                %>
                    <option id="pestSelect" value="<%= pest.getPestId() %>"><%= pest.getPestName() %></option>
                <% } %>
            </select>
        </div>
<%--        默认设置任务状态为未开始--%>
        <div class="form-group">
            <input type="hidden" id="status" name="status" value="0" >
        </div>

        <div class="form-group">
            <input type="submit" value="提交">
        </div>
    </form>

    <form action="/plant?method=returnPlantSameSpeciesList" method="post">
        <div class="form-group">
            <input type="hidden" name="plantName" value="<%= plantToConserve.getPlantName()%>">
            <input type="submit" value="返回">
        </div>
    </form>
</div>
</body>
</html>
