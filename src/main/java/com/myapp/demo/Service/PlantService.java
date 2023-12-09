package com.myapp.demo.Service;

import com.myapp.demo.Dao.PlantDao;
import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("plantService")
public class PlantService {
    @Resource(name="plantDao")
    private PlantDao plantDao;

    //得到所有的种名
    public List<String> getAllSpecies() {
        return plantDao.getAllSpecies();
    }

    //admin添加一株植物
    public Integer adminInsertPlant(Plant plant){
        List<Plant> plants = plantDao.selectPlantsByPlantName(plant.getPlantName());
        if(!plants.isEmpty()){ //之前就添加过此植物，找出当前编号的最大值，将该株植物的编号设为“最大值＋1”
            int max = -1;
            for(Plant p : plants){
                if(p.getNumber()>max){
                    max = p.getNumber();
                }
            }
            plant.setNumber(max+1);
        }else{ //之前没有此种植物，就直接把数量设为1
            plant.setNumber(1);
        }
        return plantDao.adminInsertPlant(plant);
    }



    //admin添加植物的同时要插入图片
    public Integer adminInsertPlantPhoto(Photo photo){
        return plantDao.adminInsertPlantPhoto(photo);
    }

    //利用分组查找，找出同种的植物
    public List<Plant> selectPlantsByGroup(){
        return plantDao.selectPlantsByGroup();
    }

    //根据plantId查找图片
    public Photo selectPhotoByPlantId(Integer plantId){
        return plantDao.selectPhotoByPlantId(plantId);
    }

    //根据plantId查找图片
    public Plant selectPlantByPlantId(Integer plantId){
        return plantDao.selectPlantByPlantId(plantId);
    }

    //根据plantName查找所有种名为plantName的植物
    public List<Plant> selectPlantsByPlantName(String plantName){
        return plantDao.selectPlantsByPlantName(plantName);
    }

    //修改植物基本信息（包括形态特征、培养技巧和）
    public Integer modifyPlantInfo(Plant plant){
        return plantDao.modifyPlantInfo(plant);
    }

    //修改植物的图片
    public Integer modifyPlantPhoto(Photo photo) {
        return plantDao.modifyPlantPhoto(photo);
    }

    public List<Plant> LikeSearchPlantByName(String searchQuery) {
        return plantDao.LikeSearchPlantByName(searchQuery);
    }
}
