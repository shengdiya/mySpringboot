package com.myapp.demo.Controller;

import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import com.myapp.demo.Service.PlantService;
import com.myapp.demo.Service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/plant")
public class PlantController {
    @Resource(name="userService")
    private UserService userservice;

    @Resource(name="plantService")
    private PlantService plantservice;
    @RequestMapping("/adminAddPlant")
    public String adminAddPlant() {
        return "admin/adminAddPlant";
    }

    //管理员添加一株植物
    @RequestMapping(params = "method=GetAdminAddPlant")
    public ModelAndView GetAdminAddPlant(Plant plant, Photo photo, MultipartFile plantImg, ModelAndView mav, HttpServletRequest request) throws IOException {
        //植物的种名、形态特征、栽培技术要点、应用价值由前端输入
        //植物的编号plantId由自增约束自动生成，株数编号number由添加函数plantservice.adminInsertPlant(plant)生成
        plantservice.adminInsertPlant(plant); // 将植物插入plant表

        //以下为图片处理
        //图片的拍摄地点、图片描述、图片拍摄人由前端输入，如果没输入就在此设置为“无”
        if(photo.getPhotoPlace()==null || photo.getPhotoPlace().equals("")) {
            photo.setPhotoPlace("拍摄地点不详");
        }
        if(photo.getPhotographer()==null || photo.getPhotographer().equals("")){
            photo.setPhotographer("拍摄人不详");
        }
        if(photo.getPhotoDescribe()==null || photo.getPhotoDescribe().equals("")){
            photo.setPhotoDescribe("无");
        }
        //图片的编号photoId由自增约束自动生成，对应的植物编号PlantId在此处手动设置，blob类型的二进制数据字段photo在此处理
        photo.setPlantId(plant.getPlantId()); //绑定植物_图片映射
        if (plantImg != null && !plantImg.isEmpty()) {
            String originalFilename = plantImg.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            // 对文件名进行唯一化处理，加上时间戳
            String fileName = System.currentTimeMillis() + extension;
            String storagePath = request.getSession().getServletContext().getRealPath("/imgs/plants");
            File destinationFile = new File(storagePath, fileName);
            // 确保目录存在
            if (!destinationFile.getParentFile().exists()) {
                destinationFile.getParentFile().mkdirs();
            }
            plantImg.transferTo(destinationFile);
            // 设置植物的图片路径字段
            photo.setPhotoPath("/imgs/plants/" + fileName);
        }else {  //没上传图片就使用默认图片
            photo.setPhotoPath("/imgs/plants/plantDefault.jpg");
        }
        plantservice.adminInsertPlantPhoto(photo);

        mav.setViewName("admin/adminIndex");
        mav.addObject("addPlant","添加植物成功"); //传给前端需要弹窗的内容
        mav.addObject("start","plant/adminAddPlant");
        return mav;
    }

    //管理员缩略图方式查看所有植物
    @RequestMapping("/adminPlantList")
    public String adminPlantList(HttpServletRequest request) {
        //该plantsInOneSpecies列表返回的是所有种名不同的植物，在adminPlantList界面中展示的是所有不同种名植物的缩略图
        List<Plant> plantsInOneSpecies = plantservice.selectPlantsByGroup();
        request.setAttribute("plantsInOneSpecies", plantsInOneSpecies);
        request.setAttribute("plantservice", plantservice);
        return "admin/adminPlantList";
    }

    //管理员点击一个缩略图，进入对应种名植物的株数列表
    @RequestMapping("/adminPlantSameSpeciesList")
    public String adminSeeBookDetails(@RequestParam("plantName") String plantName, HttpServletRequest request) {
        //@RequestParam注解用于获取名为 plantName 的请求参数。这个参数对应于超链接中传递的植物种名（adminPlantList.jsp中传来的）。
        //根据种名得到植物列表后，用request的setAttribute方法传给前端adminPlantSameSpeciesList.jsp
        //adminPlantSameSpeciesList.jsp再用request的getAttribute方法得到这个植物列表plantsInSameSpecies
        //该plantsInSameSpecies列表返回的是所有种名为plantName的植物，在adminPlantSameSpeciesList界面中展示的是所有种名为plantName的植物
        List<Plant> plantsInSameSpecies = plantservice.selectPlantsByPlantName(plantName);
        request.setAttribute("plantsInSameSpecies", plantsInSameSpecies);
        return "admin/adminPlantSameSpeciesList";
    }

}