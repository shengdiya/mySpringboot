<%@ page import="com.myapp.demo.Entiy.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Random" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    String family = request.getParameter("family");
    String genus = request.getParameter("genus");
    String species = request.getParameter("species");
    ServletContext context = request.getServletContext();
    AreaService areaService = (AreaService) context.getAttribute("areaService");
    SpeciesAreaService speciesAreaService = (SpeciesAreaService) context.getAttribute("speciesAreaService");
    SpeciesAliasService speciesAliasService = (SpeciesAliasService) context.getAttribute("speciesAliasService");
    GenusfamilyService genusfamilyService = (GenusfamilyService) context.getAttribute("genusfamilyService");
    FamilyspeciesService familyspeciesService = (FamilyspeciesService) context.getAttribute("familyspeciesService");
    SpeciesService speciesService = (SpeciesService) context.getAttribute("speciesService");
    ArrayList < Integer > Areas = (ArrayList<Integer>) context.getAttribute("Areas");
    ArrayList < String > Aliass = (ArrayList<String>) context.getAttribute("Aliass");
    try{
        Species species1 = new Species();
        species1.setSpeciesName(species);
        speciesService.insertSpecies(species1);
        Familyspecies familyspecies = new Familyspecies();
        familyspecies.setSpecies(species);
        familyspecies.setFamily(family);
        familyspeciesService.insertfamilySpecies(familyspecies);
        Genusfamily genusfamily = new Genusfamily();
        genusfamily.setFamily(family);
        genusfamily.setGenus(genus);
        genusfamilyService.insertGenusfamily(genusfamily);
        int speciesId = species1.getSpeciesId();
        System.out.println();
        System.out.print("Areas");
        SpeciesArea speciesArea = new SpeciesArea();
        speciesArea.setSpeciesId(speciesId);
        for(int area : Areas) {
            System.out.print(areaService.selectAreaById(area).getCityName() + ", ");
            speciesArea.setAreaId(area);
            speciesAreaService.insertSpeciesArea(speciesArea);
        }
        SpeciesAlias speciesAlias = new SpeciesAlias();
        speciesAlias.setSpeciesId(speciesId);
        System.out.println();
        System.out.print("Alias: ");
        for(String alias : Aliass) {
            System.out.print(alias + ", ");
            speciesAlias.setSpeciesAlias(alias);
            speciesAliasService.insertSpeciesAlias(speciesAlias);
        }
        System.out.println();
        System.out.println("genus:" + genus);
        System.out.println("family:" + family);
        System.out.println("species:" + species);
        List<Area> cities = areaService.selectAreaByPid(1);
        JSONArray jsonArray = new JSONArray();
        for (Area city : cities) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("cityName", city.getCityName());
            jsonObject.put("Id", city.getId().toString());
            jsonArray.add(jsonObject);
        }
        context.setAttribute("Areas", new ArrayList < Integer >());
        out.print(jsonArray.toJSONString());
    }catch (Exception e){
        out.print("jsonArray.toJSONString()");
    }
%>
