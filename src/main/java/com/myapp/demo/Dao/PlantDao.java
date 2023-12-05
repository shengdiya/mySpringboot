package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("plantDao")
@Mapper
public interface PlantDao {
    public Integer adminInsertPlant(Plant plant);
    public Integer adminInsertPlantPhoto(Photo photo);
    public List<Plant> selectAllPlants();
    public Integer countOnePlant(String plantName);
    public List<Plant> selectPlantsByPlaneName(String plantName);
}
