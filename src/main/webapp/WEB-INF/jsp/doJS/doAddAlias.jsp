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
    String alias = request.getParameter("alias");
    ArrayList< String > Aliass = (ArrayList<String>) context.getAttribute("Aliass");
    Aliass.add(alias);
    JSONObject jsonObject = new JSONObject();
    jsonObject.put("alias", alias);
    out.print(jsonObject);
%>
