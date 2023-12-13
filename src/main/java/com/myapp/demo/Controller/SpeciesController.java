package com.myapp.demo.Controller;


import com.myapp.demo.Service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
@RequestMapping("/species")
public class SpeciesController {

    @Resource(name = "areaService")
    private AreaService areaService;

    @Resource(name = "familyspeciesService")
    private FamilyspeciesService familyspeciesService;

    @Resource(name = "genusfamilyService")
    private GenusfamilyService genusfamilyService;

    @Resource(name = "speciesAliasService")
    private SpeciesAliasService speciesAliasService;

    @Resource(name = "speciesAreaService")
    private SpeciesAreaService speciesAreaService;

    @Resource(name = "speciesService")
    private SpeciesService speciesService;

    @RequestMapping("/adminAddSpecies")
    public String adminAddSpecies(HttpServletRequest request) {
        ServletContext context = request.getServletContext();
        ArrayList<Integer> Areas = new ArrayList<>();
        ArrayList<String> Aliass = new ArrayList<>();
        context.setAttribute("areaService", areaService);
        context.setAttribute("familyspeciesService", familyspeciesService);
        context.setAttribute("genusfamilyService", genusfamilyService);
        context.setAttribute("speciesAliasService", speciesAliasService);
        context.setAttribute("speciesAreaService", speciesAreaService);
        context.setAttribute("speciesService", speciesService);
        context.setAttribute("Areas", Areas);
        context.setAttribute("Aliass", Aliass);
        return "species/addSpecies";
    }

    //admin_test
    @RequestMapping("/adminSpeciesList")
    public String adminSpeciesList(HttpServletRequest request) {
        ServletContext context = request.getServletContext();
        ArrayList<Integer> Areas = new ArrayList<>();
        ArrayList<String> Aliass = new ArrayList<>();
        context.setAttribute("areaService", areaService);
        context.setAttribute("familyspeciesService", familyspeciesService);
        context.setAttribute("genusfamilyService", genusfamilyService);
        context.setAttribute("speciesAliasService", speciesAliasService);
        context.setAttribute("speciesAreaService", speciesAreaService);
        context.setAttribute("speciesService", speciesService);
        context.setAttribute("Areas", Areas);
        context.setAttribute("Aliass", Aliass);
        System.out.println(genusfamilyService.selectGenusfamily("AAA").getGenus());
        return "species/searchSpecies";
    }

    @RequestMapping("/adminRE1")
    public String adminRE1() {
        return "doJS/doRefresh";
    }

    @RequestMapping("/adminRE2")
    public String adminRE2() {
        return "doJS/doAdd";
    }

    @RequestMapping("/adminRE3")
    public String adminRE3() {
        return "doJS/doAddArea";
    }

    @RequestMapping("/adminRE4")
    public String adminRE4() {
        return "doJS/doAddAlias";
    }

    @RequestMapping("/adminRE7")
    public String adminRE5() {
        return "doJS/doResearch";
    }

    @PostMapping("/species_distribution_area_Add")
    public String species_distribution_area_Add(@RequestParam("Province") String province,
                                                @RequestParam("City") String city,
                                                @RequestParam("County") String county,
                                                HttpServletRequest request) {
        ServletContext context = request.getServletContext();
        context.setAttribute("areaService", areaService);
        System.out.println(province + " " + city + " " + county);
        return "redirect:/species/adminSpeciesList";
    }


}
