package com.myapp.demo.Service;

import com.myapp.demo.Dao.PlantDao;
import com.myapp.demo.Dao.UserDao;
import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("plantService")
public class PlantService {
    @Resource(name="plantDao")
    private PlantDao plantDao;
    //admin添加一株植物
    public Integer adminInsertPlant(Plant plant){
        List<Plant> plants = plantDao.selectPlantsByPlaneName(plant.getPlantName());
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
}
