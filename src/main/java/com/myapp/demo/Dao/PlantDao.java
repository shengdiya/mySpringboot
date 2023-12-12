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
    public List<Plant> selectPlantsByPlantName(String plantName);
    public List<Plant> selectPlantsByGroup();
    public Photo selectPhotoByPlantId(Integer plantId);
    public Plant selectPlantByPlantId(Integer plantId);
    public Integer modifyPlantInfo(Plant plant);
    public Integer modifyPlantPhoto(Photo photo);
    public List<String> getAllSpecies();
    public List<Plant> LikeSearchPlantByName(String searchQuery);
    public Plant selectPlantInfoByPlantId(Integer plantId);
    public Integer deletePlantById(String plantId);
}
