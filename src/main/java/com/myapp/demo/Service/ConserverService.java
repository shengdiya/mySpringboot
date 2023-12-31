package com.myapp.demo.Service;

import com.myapp.demo.Dao.ConserverDao;
import com.myapp.demo.Entiy.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("conserverService")
public class ConserverService {
    @Resource(name = "conserverDao")
    private ConserverDao conserverDao;

    //根据养护人员ID查找他的任务
    public List<ConserveTask> selectConserveTaskByUserId(int executionPersonnel) {
        return conserverDao.selectConserveTaskByUserId(executionPersonnel);
    }

    public List<ConserveTask> selectAllConserveTasks() {
        return conserverDao.selectAllConserveTasks();
    }

    public int statusChangeToInProgress(int taskId) {
        return conserverDao.statusChangeToInProgress(taskId);
    }

    public int statusChangeToFinished(int taskId) {
        return conserverDao.statusChangeToFinished(taskId);
    }

    public int deleteTaskByTaskId(int taskId) {
        return conserverDao.deleteTaskByTaskId(taskId);
    }

    public int addTask(ConserveTask conserveTask) {
        return conserverDao.insertTask(conserveTask);
    }

    public List<Plant> selectAllPlants() {
        return conserverDao.selectAllPlants();
    }

    public List<Garden_pest> selectAllPests() {
        return conserverDao.selectAllPests();
    }

    public int insertPlantPest(int plantId, int pestId) {
        return conserverDao.insertPlantPest(plantId, pestId);
    }

    public int deletePestById(int pestId) {
        return conserverDao.deletePestById(pestId);
    }

    public int addPest(Garden_pest pest) {
        return conserverDao.addPest(pest);
    }

    public int deletePlantPestByPlantIdAndPestId(int plantId, int pestId) {
        return conserverDao.deletePlantPestByPlantIdAndPestId(plantId, pestId);
    }

    public List<Integer> selectPestByPlantId(int plantId) {
        return conserverDao.selectPestByPlantId(plantId);
    }

    public Garden_pest selectPestByPestId(int pestId) {
        return conserverDao.selectPestByPestId(pestId);
    }

    public List<Integer> selectPlantByPestId(int pestId) {
        return conserverDao.selectPlantByPestId(pestId);
    }

    public Plant selectPlantByPlantId(int plantId) {
        return conserverDao.selectPlantByPlantId(plantId);
    }

    public List<ConserveTask> selectConserveTaskByPestId(int pestId) {
        return conserverDao.selectConserveTaskByPestId(pestId);
    }

    public String selectConserverNameByConserverId(int userId) {
        return conserverDao.selectConserverNameByConserverId(userId);
    }

    //以下为5个模糊匹配
    public List<ConserveTask> LikeSelectTaskByTaskName(String searchContent) {
        return conserverDao.LikeSelectTaskByTaskName(searchContent);
    }

    public List<ConserveTask> LikeSelectTaskByPlantName(String searchContent) {
        return conserverDao.LikeSelectTaskByPlantName(searchContent);
    }

    public List<ConserveTask> LikeSelectTaskByRealName(String searchContent) {
        return conserverDao.LikeSelectTaskByRealName(searchContent);
    }

    public List<ConserveTask> LikeSelectTaskByPestName(String searchContent) {
        return conserverDao.LikeSelectTaskByPestName(searchContent);
    }

    public List<ConserveTask> LikeSelectTaskByPlace(String searchContent) {
        return conserverDao.LikeSelectTaskByPlace(searchContent);

    }

    public List<Pesticide> selectAllPesticide() {
        return conserverDao.selectAllPesticide();
    }

    public int insertPesticide(Pesticide pesticide) {
        return conserverDao.insertPesticide(pesticide);
    }

    public List<Pest_control_plan> selectAllControlPlan() {
        return conserverDao.selectAllControlPlan();
    }

    public Pesticide selectPesticideByPesticideId(int pesticideId) {
        return conserverDao.selectPesticideByPesticideId(pesticideId);
    }

    public int deletePestControlPlanById(int pestId, int pesticideId) {
        return conserverDao.deletePestControlPlanById(pestId, pesticideId);
    }

    public int insertControlPlan(Pest_control_plan pestControlPlan) {
        return conserverDao.insertControlPlan(pestControlPlan);
    }

    public int deletePesticideByPesticideId(int pesticideId) {
        return conserverDao.deletePesticideByPesticideId(pesticideId);
    }

    public String viewsSelectConservePlant(int taskId) {
        return conserverDao.viewsSelectConservePlant(taskId);
    }

    public List<String> viewsSelectPestPlant(int taskId) {
        return conserverDao.viewsSelectPestPlant(taskId);
    }

    public String viewsSelectConservePest(int pestId) {
        return conserverDao.viewsSelectConservePest(pestId);
    }

    public List<String> viewsSelectPestConserveTask(int pestId) {
        return conserverDao.viewsSelectPestConserveTask(pestId);
    }
    public int viewsSelectPestPlantNumber(int pestId) {
        return conserverDao.viewsSelectPestPlantNumber(pestId);
    }

}