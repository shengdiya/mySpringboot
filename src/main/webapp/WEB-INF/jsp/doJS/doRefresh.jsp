<%@ page import="com.myapp.demo.Entiy.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.demo.Service.AreaService" %>
<%@ page import="java.util.Random" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    ServletContext context = request.getServletContext();
    AreaService areaService = (AreaService) context.getAttribute("areaService");
    int provinceId = Integer.parseInt(request.getParameter("provinceId"));
    List<Area> cities = areaService.selectAreaByPid(provinceId);
    JSONArray jsonArray = new JSONArray();
    for (Area city : cities) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("cityName", city.getCityName()); // 假设Area类有一个名为getCityName的方法来获取城市名称
        jsonObject.put("Id", city.getId().toString());
        jsonArray.add(jsonObject);
    }
    out.print(jsonArray.toJSONString());
%>
