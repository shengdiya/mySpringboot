<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/6
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.annotation.Resource" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%
    User user1= (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");Plant plant = (Plant) request.getAttribute("plantToBeShow");
    Photo photo = (Photo) request.getAttribute("photoToBeShow");
    List<SpeciesArea> area = (List<SpeciesArea>) request.getAttribute("area");

    AreaService areaService = (AreaService) request.getAttribute("areaService");
    FamilyspeciesService familyspeciesService = (FamilyspeciesService) request.getAttribute("familyspeciesService");
    GenusfamilyService genusfamilyService = (GenusfamilyService)  request.getAttribute("genusfamilyService");
    SpeciesAliasService speciesAliasService = (SpeciesAliasService) request.getAttribute("speciesAliasService");
    SpeciesService speciesService = (SpeciesService) request.getAttribute("speciesService");
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css">

</head>
<body>
<input name="safe" type="hidden" value="<%= user1.getUserName() %>">

<div class="container">

    <h2><%= plant.getPlantName() %>详细信息</h2>
    <form action="/plant?method=returnPlantSameSpeciesList" method="post">
        <img src="<%= photo.getPhotoPath() %>" alt="User Avatar" class="user-avatar"/>
        <div class="user-info">
            <div class="info-item"><span class="info-label">编号:</span> <%= plant.getNumber() %></div>
            <div class="info-item"><span class="info-label">形态特征:</span> <%= plant.getFeature() %></div>
            <div class="info-item"><span class="info-label">栽培技术要点:</span> <%= plant.getCultivation() %></div>
            <div class="info-item"><span class="info-label">应用价值:</span> <%= plant.getValue() %></div>
            <%
                StringBuilder areas = new StringBuilder();
                for(SpeciesArea a : area){
                    Area ares = areaService.selectAreaById(a.getAreaId());
                    String cityName = "";
                    while(ares.getType() > 0) {
                        cityName = ares.getCityName() + cityName;
                        ares = areaService.selectAreaById(ares.getPid());
                    }
                    areaService.selectAreaByPid(a.getAreaId());
                    areas.append(cityName + ";");
                }
                areas.toString();
            %>

            <%
                StringBuilder category = new StringBuilder();
                String family = familyspeciesService.selectfamilyspeciesBySpecies(plant.getPlantName()).getFamily();
                String genus = genusfamilyService.selectGenusfamily(family).getGenus();
                List<SpeciesAlias> alias = speciesAliasService.selectSpeciesAliasBySpeciesId(speciesService.findSpeciesIdByName(plant.getPlantName()));

                category.append("科名：" + genus);
                category.append("属名：" + family);
                category.append("种名：" + plant.getPlantName());
                category.append("别名：");
                for(SpeciesAlias alia : alias){
                    category.append(alia.getSpeciesAlias() + ";");
                }
                String categoryResult = category.toString();
            %>
            <div class="info-item"><span class="info-label">植物分布:</span> <%= areas %></div>
            <div class="info-item"><span class="info-label">植物分类:</span> <%= categoryResult %></div>
        </div> <br>

        <div class="form-group">
            <input type="hidden" name="plantName" value="<%= plant.getPlantName() %>">
            <input type="submit" value="返回">
        </div>
    </form>
</div>

</body>
</html>
