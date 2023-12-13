package com.myapp.demo.Controller;

import com.myapp.demo.Entiy.*;
import com.myapp.demo.Entiy.Monitor.MonitoringManagement;
import com.myapp.demo.Service.ConserverService;
import com.myapp.demo.Service.PlantService;
import com.myapp.demo.Service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/conserverController")
public class ConserverController {
    @Resource(name="conserverService")
    private ConserverService conserverService;
    @Resource(name="plantService")
    private PlantService plantservice;
    @Resource(name="userService")
    private UserService userservice;

    //查看个人任务界面
    @RequestMapping("/conserverTaskList")
    public String GetTaskList(HttpServletRequest request, HttpServletResponse response) {

        List<ConserveTask> conserveTasks = conserverService.selectAllConserveTasks();
        request.setAttribute("conserveTasks",conserveTasks);
        request.setAttribute("conserverService", conserverService);
        return "conserver/conserverTaskList";
    }

    @RequestMapping("/conserverAddTask")
    public String toAddTaskPage(@RequestParam("plantId") int plantId,HttpServletRequest request, HttpServletResponse response) {
        Plant plantToConserve = plantservice.selectPlantByPlantId(plantId);
        request.setAttribute("plantToConserve",plantToConserve);
        request.setAttribute("conserverService", conserverService);
        request.setAttribute("userservice", userservice);
        return "conserver/conserverAddTask";
    }

    @RequestMapping("/conserverTODOPlant")
    public String GetPlantList(HttpServletRequest request, HttpServletResponse response) {
        List<Plant> plants = conserverService.selectAllPlants();
        request.setAttribute("plants", plants);
        request.setAttribute("conserverService", conserverService);
        return "conserver/conserverTODOPlant";
    }

    //返回conserverTODOPlant.jsp
    @RequestMapping(params = "method=returnConserverTODOPlant")
    public String returnConserverTODOPlant(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("start", "conserverController/conserverTODOPlant");
        return "admin/adminIndex";
    }

    @RequestMapping("/conserverAddPlantPest")
    public String toAddPlantPestPage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        request.setAttribute("plantId", request.getParameter("plantId"));
        request.setAttribute("plantName", request.getParameter("plantName"));
        return "conserver/conserverAddPlantPest";
    }

    @RequestMapping("/conserverShowAndAddPest")
    public String toShowPestPage(HttpServletRequest request, HttpServletResponse response) {
        List<Garden_pest> pests = conserverService.selectAllPests();
        request.setAttribute("conserverService", conserverService);
        request.setAttribute("pests", pests);
        return "conserver/conserverShowAndAddPest";
    }
    @RequestMapping("/showAndaddPesticide")
    public String toShowPesticidePage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        List<Pesticide> pesticides = conserverService.selectAllPesticide();
        request.setAttribute("pesticides", pesticides);
        return "conserver/conserverShowAndAddPesticide";
    }

    @RequestMapping("/conserverControlPlan")
    public String toControlPlanPage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        List<Pest_control_plan> pestControlPlans = conserverService.selectAllControlPlan();
        request.setAttribute("pestControlPlans", pestControlPlans);
        return "conserver/conserverControlPlan";
    }

    @RequestMapping("/addControlPlan")
    public String toAddControlPlanPage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        return "conserver/conserverAddControlPlan";
    }
    @RequestMapping(params = "method=AddTask")
    public String AddTask(HttpServletRequest request, ConserveTask conserveTask) {
        try {
            conserverService.addTask(conserveTask);
            conserverService.insertPlantPest(conserveTask.getPlantId(),conserveTask.getPestId());
        }catch (Exception e){
//            System.out.println("添加植物_病虫害被拦截，因为已手动添加过此纪录");
            request.setAttribute("SQLMessage","添加失败，已存在相同但未开始或进行中的任务");
        }
        request.setAttribute("addConserveTask", "添加成功");
        request.setAttribute("start","conserverController/conserverTaskList");//执行完状态修改后跳转回养护人员主页，并设置加载页为任务列表
        return "admin/adminIndex";
    }

    //点了什么按钮。
    @RequestMapping(params = "method=status_start")
    public String setStatusInProgress(HttpServletRequest request, HttpServletResponse response) {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        int effectRow = conserverService.statusChangeToInProgress(taskId);
        request.setAttribute("effectRow",effectRow);
        request.setAttribute("start","conserverController/conserverTaskList");//执行完状态修改后跳转回养护人员主页，并设置加载页为任务列表
        return "admin/adminIndex";
    }

    /**
     * 这个方法需要检测完成养护任务时，养护任务中的植物ID和病虫害ID是否存在于plant_disease表
     * 如果存在，则消除对应记录，表示经过养护任务之后消除病虫害
     * 使用视图plant_disease_in_conservetask选择conservetask表中的plant_disease部分
     */
    @RequestMapping(params = "method=status_finish")
    public String setStatusFinished(HttpServletRequest request, HttpServletResponse response) {
        int plantId = Integer.parseInt(request.getParameter("plantId"));
        int pestId = Integer.parseInt(request.getParameter("pestId"));
        int effectRow_plant_disease = conserverService.deletePlantPestByPlantIdAndPestId(plantId,pestId);
//        request.setAttribute("effectRow_plant_disease",effectRow_plant_disease);
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        int effectRow = conserverService.statusChangeToFinished(taskId);
        request.setAttribute("effectRow",effectRow);
        request.setAttribute("start","conserverController/conserverTaskList");//执行完状态修改后跳转回养护人员主页，并设置加载页为任务列表
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=deleteTaskByTaskId")
    public String deleteTaskByTaskId(HttpServletRequest request, HttpServletResponse response) {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        int effectRow = conserverService.deleteTaskByTaskId(taskId);
        request.setAttribute("effectRow",effectRow);
        request.setAttribute("start","conserverController/conserverTaskList");//执行完状态修改后跳转回养护人员主页，并设置加载页为任务列表
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=addPlantPest")
    public String addPlantPest(HttpServletRequest request, HttpServletResponse response) {
        int plantId = Integer.parseInt(request.getParameter("plantId"));
        int pestId = Integer.parseInt(request.getParameter("pestId"));
        try {
            int effectRow = conserverService.insertPlantPest(plantId, pestId);
            request.setAttribute("effectRow",effectRow);
        } catch (Exception e) {
            request.setAttribute("addPlantPest", "已经添加过同名病虫害，禁止重复添加");
        }
        request.setAttribute("start","conserverController/conserverTODOPlant");//执行完状态修改后跳转回养护人员主页，并设置加载页为植物列表
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=deletePestById")
    public String deletePestById(HttpServletRequest request, HttpServletResponse response) {
        int pestId = Integer.parseInt(request.getParameter("pestId"));
        int effectRow = conserverService.deletePestById(pestId);
        request.setAttribute("effectRow",effectRow);
        request.setAttribute("start","conserverController/conserverShowAndAddPest");//执行完状态修改后跳转回养护人员主页，并设置加载页为病虫害列表
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=addPest")
    public String addPest(HttpServletRequest request, HttpServletResponse response) {
        String pestName = request.getParameter("pestName");
        Garden_pest pest = new Garden_pest();
        pest.setPestName(pestName);
        try {
            int effectRow = conserverService.addPest(pest);
            request.setAttribute("effectRow",effectRow);
        } catch (Exception e) {
            request.setAttribute("SQLMessage", "添加失败，已存在同名病虫害");
        }
        request.setAttribute("start","conserverController/conserverShowAndAddPest");//执行完状态修改后跳转回养护人员主页，并设置加载页为病虫害列表
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=addPesticide")
    public String addPesticide(HttpServletRequest request, HttpServletResponse response ,Pesticide pesticide) {
        try {
            int effectRow = conserverService.insertPesticide(pesticide);
            request.setAttribute("effectRow", effectRow);
        } catch (Exception e) {
            request.setAttribute("SQLMessage", "添加失败，已添加过同名药剂");
        }
        List<Pesticide> pesticides = conserverService.selectAllPesticide();
        request.setAttribute("pesticides", pesticides);
        return "conserver/conserverShowAndAddPesticide";
    }

    @RequestMapping(params = "method=deleteControlPlanById")
    public String deleteControlPlanById(HttpServletRequest request, HttpServletResponse response) {
        int effectRow = conserverService.deletePestControlPlanById(Integer.parseInt(request.getParameter("pestId")), Integer.parseInt(request.getParameter("pesticideId")));
        request.setAttribute("effectRow", effectRow);
        request.setAttribute("start","conserverController/conserverControlPlan");//执行完状态修改后跳转回养护人员主页，并设置加载页为防治方案展示页
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=returnToConserverControlPlan")
    public String returnToconserverControlPlan(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        List<Pest_control_plan> pestControlPlans = conserverService.selectAllControlPlan();
        request.setAttribute("pestControlPlans", pestControlPlans);
        request.setAttribute("start", "conserverController/conserverControlPlan");
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=addControlPlan")
    public String addControlPlan(HttpServletRequest request, HttpServletResponse response, Pest_control_plan pestControlPlan) {
        request.setAttribute("conserverService", conserverService);
        int effectRow = conserverService.insertControlPlan(pestControlPlan);
        request.setAttribute("effectRow", effectRow);
        request.setAttribute("start", "conserverController/conserverControlPlan");
        return "admin/adminIndex";
    }

    @RequestMapping(params = "method=deletePesticide")
    public String deletePesticide(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("conserverService", conserverService);
        int effectRow = conserverService.deletePesticideByPesticideId(Integer.parseInt(request.getParameter("pesticideId")));
        request.setAttribute("effectRow", effectRow);
        List<Pesticide> pesticides = conserverService.selectAllPesticide();
        request.setAttribute("pesticides", pesticides);
        return "conserver/conserverShowAndAddPesticide";
    }
    //以下为模糊搜索功能
    @RequestMapping("/ConserveTaskSearchResult")
    public String MonitoringManagementSearchResult(HttpServletRequest request) {
        request.setAttribute("conserverService", conserverService);
        return "conserver/ConserveTaskSearchResult";
    }

    @RequestMapping(params = "method=SearchTask")
    public ModelAndView SearchTask(HttpServletRequest request, ModelAndView mav) {
        String searchType = request.getParameter("searchType");
        String searchContent = request.getParameter("searchContent");

        List<ConserveTask> ConserveTaskSearchResult = SearchByType(searchType,searchContent);
        request.getSession().setAttribute("ConserveTaskSearchResult", ConserveTaskSearchResult); //更新要展示的列表
        mav.setViewName("admin/adminIndex");
        mav.addObject("start","conserverController/ConserveTaskSearchResult");
        return mav;
    }

    private List<ConserveTask> SearchByType(String searchType, String searchContent) {
        List<ConserveTask> result = new ArrayList<>();
        switch (searchType) {
            case "taskName":
                result = conserverService.LikeSelectTaskByTaskName(searchContent);
                break;
            case "plantName":
                result = conserverService.LikeSelectTaskByPlantName(searchContent);
                break;
            case "realName":
                result = conserverService.LikeSelectTaskByRealName(searchContent);
                break;
            case "pestName":
                result = conserverService.LikeSelectTaskByPestName(searchContent);
                break;
            default:
                result = conserverService.LikeSelectTaskByPlace(searchContent);
                break;
        }
        return result;
    }



}
