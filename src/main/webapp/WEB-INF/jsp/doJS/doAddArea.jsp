<%@ page import="com.myapp.demo.Entiy.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="com.myapp.demo.Service.AreaService" %>
<%@ page import="java.util.Random" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    ServletContext context = request.getServletContext();
    AreaService areaService = (AreaService) context.getAttribute("areaService");
    ArrayList< Integer > Areas = (ArrayList<Integer>) context.getAttribute("Areas");
    int provinceId = 0;
    int cityId = 0;
    int countyId = 0;
    JSONArray jsonArray = new JSONArray();
    JSONObject jsonObject = new JSONObject();
    if(!request.getParameter("provinceId").isEmpty()) {
        provinceId = Integer.parseInt(request.getParameter("provinceId"));
        if(!request.getParameter("cityId").isEmpty()){
            cityId = Integer.parseInt(request.getParameter("cityId"));
            if(!request.getParameter("countyId").isEmpty()) {
                countyId = Integer.parseInt(request.getParameter("countyId"));
                Areas.add(countyId);
                jsonObject.put("cityName", areaService.selectAreaById(countyId).getCityName());
                jsonObject.put("Id", countyId);
            }
            else {
                Areas.add(cityId);
                jsonObject.put("cityName", areaService.selectAreaById(cityId).getCityName());
                jsonObject.put("Id", cityId);
            }
        }
        else {
            Areas.add(provinceId);
            jsonObject.put("cityName", areaService.selectAreaById(provinceId).getCityName());
            jsonObject.put("Id", provinceId);
        }
    }
    context.setAttribute("Areas", Areas);
    jsonArray.add(jsonObject);
    System.out.println(provinceId + " " + areaService.selectAreaById(provinceId));
    System.out.println(cityId + " " + areaService.selectAreaById(cityId));
    System.out.println(countyId + " " + areaService.selectAreaById(countyId));
    //genus family species
    String family = request.getParameter("family");
    String genus = request.getParameter("genus");
    String species = request.getParameter("species");
    System.out.println("genus:" + genus);
    System.out.println("family:" + family);
    System.out.println("species:" + species);
    List<Area> cities = areaService.selectAreaByPid(1);
    for (Area city : cities) {
        jsonObject = new JSONObject();
        jsonObject.put("cityName", city.getCityName());
        jsonObject.put("Id", city.getId().toString());
        jsonArray.add(jsonObject);
    }
    out.print(jsonArray.toJSONString());
%>
