package com.myapp.demo.Controller;

import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import com.myapp.demo.Entiy.User;
import com.myapp.demo.Service.PlantService;
import com.myapp.demo.Service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

@Controller
@RequestMapping("/plant")
public class PlantController {
    @Resource(name="userService")
    private UserService userservice;

    @Resource(name="plantService")
    private PlantService plantservice;
    @RequestMapping("/adminAddPlant")
    public String login() {
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
}
