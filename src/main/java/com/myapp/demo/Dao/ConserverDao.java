package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.ConserveTask;
import com.myapp.demo.Entiy.Garden_pest;
import com.myapp.demo.Entiy.Plant;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("conserverDao")
@Mapper
public interface ConserverDao {
    List<ConserveTask> selectConserveTaskByUserId(int executionPersonnel);
    int statusChangeToInProgress(int taskId);
    int statusChangeToFinished(int taskId);
    int deleteTaskByTaskId(int taskId);
    int insertTask(ConserveTask conserveTask);
    List<Plant> selectAllPlants();
    List<Garden_pest> selectAllPests();
    int insertPlantPest(int plantId, int pestId);
    int deletePestById(int pestId);
    int addPest(Garden_pest pest);
    int deletePlantPestByPlantIdAndPestId(int plantId, int pestId);
    List<Integer> selectPestByPlantId(int plantId);
    Garden_pest selectPestByPestId(int pestId);
    List<Integer> selectPlantByPestId(int pestId);
    Plant selectPlantByPlantId(int plantId);
    List<ConserveTask> selectConserveTaskByPestId(int pestId);
    String selectConserverNameByConserverId(int userId);
    List<ConserveTask> selectAllConserveTasks();


    List<ConserveTask> LikeSelectTaskByTaskName(String searchContent);
    List<ConserveTask> LikeSelectTaskByPlantName(String searchContent);
    List<ConserveTask> LikeSelectTaskByRealName(String searchContent);
    List<ConserveTask> LikeSelectTaskByPestName(String searchContent);
    List<ConserveTask> LikeSelectTaskByPlace(String searchContent);
}
