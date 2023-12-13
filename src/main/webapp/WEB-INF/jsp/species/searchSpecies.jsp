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
        <input type="text" id="alias" name="alias" placeholder="请输入别名">
    </div>

    <div>
        <input type="text" id="genus" name="genus" placeholder="请输入科名">
        <input type="text" id="family" name="family" placeholder="请输入属名">
        <input type="text" id="species" name="species" placeholder="请输入种名">
    </div>

    <button onclick="onclickselect1()">查询</button>

    <div id="tableContainer"></div>

</body>
</html>
