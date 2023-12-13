<%@ page import="com.myapp.demo.Entiy.Area" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Random" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setContentType("application/json;charset=UTF-8");
    String alias = request.getParameter("alias");
    String family = request.getParameter("family");
    String genus = request.getParameter("genus");
    String species = request.getParameter("species");
    ServletContext context = request.getServletContext();
    SpeciesService speciesService = (SpeciesService) context.getAttribute("speciesService");
    SpeciesAliasService speciesAliasService = (SpeciesAliasService) context.getAttribute("speciesAliasService");
    SpeciesAreaService speciesAreaService = (SpeciesAreaService) context.getAttribute("speciesAreaService");
    GenusfamilyService genusfamilyService = (GenusfamilyService) context.getAttribute("genusfamilyService");
    FamilyspeciesService familyspeciesService = (FamilyspeciesService) context.getAttribute("familyspeciesService");
    AreaService areaService = (AreaService) context.getAttribute("areaService");
    int provinceId = 0;
    int cityId = 0;
    int countyId = 0;
    int areaId = 0;
    if(!request.getParameter("provinceId").isEmpty()) {
        provinceId = Integer.parseInt(request.getParameter("provinceId"));
        areaId = provinceId;
        if(!request.getParameter("cityId").isEmpty()){
            cityId = Integer.parseInt(request.getParameter("cityId"));
            areaId = cityId;
            if(!request.getParameter("countyId").isEmpty()) {
                countyId = Integer.parseInt(request.getParameter("countyId"));
                areaId = countyId;
            }
        }
    }
    //areaId, family, genus, species, alias
    String distribution = String.valueOf(areaId);
    System.out.println(genus + " " + family + " " + species + " " + alias + " " + distribution);
    if(distribution.equals("0")) {
        distribution = null;
    }
    List < Integer > speciesIds = speciesService.findPlantIdsByParams(genus, family, species, alias, distribution);
    JSONArray speciesArray = new JSONArray();
    for(Integer speciesId : speciesIds) {
        JSONObject speciesObject = new JSONObject();
        JSONObject jsonObject = new JSONObject();
        String SpeciesName, FamilyName, GenusName;
        SpeciesName = speciesService.findSpeciesById(speciesId).getSpeciesName();
        FamilyName = familyspeciesService.selectfamilyspeciesBySpecies(SpeciesName).getFamily();
        GenusName = genusfamilyService.selectGenusfamily(FamilyName).getGenus();
        speciesObject.put("speciesName", SpeciesName);
        speciesObject.put("familyName", FamilyName);
        speciesObject.put("genusName", GenusName);
        System.out.println(speciesService.findSpeciesById(speciesId).getSpeciesName());
        List < SpeciesArea > Ares = speciesAreaService.selectSpeciesArea(speciesId);
        JSONArray areaArray = new JSONArray();
        for (SpeciesArea speciesArea : Ares) {
            String oneArea = areaService.selectAreaById(speciesArea.getAreaId()).getCityName();
            System.out.println(oneArea);
            areaArray.add(oneArea);
        }
        speciesObject.put("areas", areaArray);
        List < SpeciesAlias > Alis = speciesAliasService.selectSpeciesAliasBySpeciesId(speciesId);
        JSONArray aliasArray = new JSONArray();
        for (SpeciesAlias speciesAlias : Alis) {
            String oneAlias = speciesAlias.getSpeciesAlias();
            System.out.println(oneAlias);
            aliasArray.add(oneAlias);
        }
        speciesObject.put("aliases", aliasArray);
        speciesArray.add(speciesObject);
    }
    out.print(speciesArray);

    //    ObjectMapper objectMapper = new ObjectMapper();
//    String json = objectMapper.writeValueAsString(speciesIds);
//    out.print(json);
%>
