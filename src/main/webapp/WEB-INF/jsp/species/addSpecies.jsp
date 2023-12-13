<%@ page import="com.myapp.demo.Entiy.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.demo.Service.AreaService" %>
<%
    ServletContext context = request.getServletContext();
    response.setContentType("application/json;charset=UTF-8");
    AreaService areaService = (AreaService) context.getAttribute("areaService");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div>
        <select id="Province" name="Province" onchange="onDropdownChange1()">
            <option value="">选择省</option>
            <%
                List<Area> provinces = areaService.selectAreaByPid(1);
                for (Area province : provinces) {
                    Integer identifier = province.getId();
                    String display = province.getCityName();
            %>
            <option value="<%= identifier %>"><%= display %></option>
            <% } %>
        </select>
        <select id="City" name="City" onchange="onDropdownChange2()">
            <option value="">选择市</option>
        </select>
        <select id="County" name="County" >
            <option value="">选择县</option>
        </select>
    </div>

    <div>
        <input type="text" id="alias" name="alias" required placeholder="请输入别名">
    </div>

    <button onclick="onclickupd3() ">添加别名</button>

    <button onclick="onclickupd2() ">添加分布区域</button>
    <div>
        <input type="text" id="genus" name="genus" required placeholder="请输入科名">
        <input type="text" id="family" name="family" required placeholder="请输入属名">
        <input type="text" id="species" name="species" required placeholder="请输入种名">
    </div>

    <button onclick="onclickupd1()">添加</button>

    <table id="myTable">
        <thead>
        <tr>
            <th>列1</th>
            <th>列2</th>
        </tr>
        </thead>
        <tbody>
        <!-- 表格内容将在JavaScript中动态添加 -->
        </tbody>
    </table>

    <table id="aliasTable">
        <thead>
        <tr>
            <th>列1</th>
        </tr>
        </thead>
        <tbody>
        <!-- 表格内容将在JavaScript中动态添加 -->
        </tbody>
    </table>

</body>
</html>
