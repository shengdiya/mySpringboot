package com.myapp.demo.Controller;

import com.myapp.demo.Entiy.Photo;
import com.myapp.demo.Entiy.Plant;
import com.myapp.demo.Service.Monitor.MonitoringManagementService;
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
    @Resource(name="plantService")
    private PlantService plantservice;
    @Resource(name="MonitoringManagementService")
    private MonitoringManagementService monitoringmanagementservice;
    @RequestMapping("/adminAddPlant")
    public String adminAddPlant(HttpServletRequest request) {
        List<String> plantsSpecies = plantservice.getAllSpecies();
        request.setAttribute("plantsSpecies", plantsSpecies);
        return "admin/adminAddPlant";
    }

    //管理员添加一株植物
    @RequestMapping(params = "method=GetAdminAddPlant")
    public ModelAndView GetAdminAddPlant(Integer total, Plant plant, Photo photo, MultipartFile plantImg, ModelAndView mav, HttpServletRequest request) throws IOException {
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
        //植物的种名、形态特征、栽培技术要点、应用价值由前端输入
        //植物的编号plantId由自增约束自动生成，株数编号number由添加函数plantservice.adminInsertPlant(plant)生成
        for(int i = 0; i<total ; i++){
            insertOnePlant(plant,photo,plantImg,request);
            plant.setPlantId(null); //把主键设置为null是为了多次添加，不设置为null的话主键就不会自增
        }

        mav.setViewName("admin/adminIndex");
        mav.addObject("addPlant","添加植物成功"); //传给前端需要弹窗的内容
        mav.addObject("start","plant/adminAddPlant");
        return mav;
    }
    //插入一株植物，为GetAdminAddPlant插入多株植物所用
    private void insertOnePlant(Plant plant, Photo photo, MultipartFile plantImg, HttpServletRequest request) throws IOException {
        plantservice.adminInsertPlant(plant); // 将植物插入plant表

        //以下为图片处理
        photo.setPlantId(plant.getPlantId()); //绑定植物_图片映射
        if (plantImg != null && !plantImg.isEmpty()) {
            String originalFilename = plantImg.getOriginalFilename();
            // 获取服务器中图片存储路径
            String storagePath = request.getSession().getServletContext().getRealPath("/imgs/plants");
            File storageDir = new File(storagePath);
            // 确保目录存在
            if (!storageDir.exists()) {
                storageDir.mkdirs();
            }
            File destinationFile = new File(storageDir, originalFilename); // 创建一个指向要保存或者检查的文件的引用
            // 检查文件是否已经存在于目录中
            if (!destinationFile.exists()) {
                // 如果文件不存在，保存上传的文件
                plantImg.transferTo(destinationFile);
            }
            // 文件已存在或者刚刚被保存，设置图片路径
            photo.setPhotoPath("/imgs/plants/" + originalFilename);
        } else {
            // 没上传图片就使用默认图片
            photo.setPhotoPath("/imgs/plants/plantDefault.jpg");
        }
        plantservice.adminInsertPlantPhoto(photo);
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
    public String adminPlantSameSpeciesList(@RequestParam("plantName") String plantName, HttpServletRequest request) {
        //@RequestParam注解用于获取名为 plantName 的请求参数。这个参数对应于超链接中传递的植物种名（adminPlantList.jsp中传来的）。
        //根据种名得到植物列表后，用request的setAttribute方法传给前端adminPlantSameSpeciesList.jsp
        //adminPlantSameSpeciesList.jsp再用request的getAttribute方法得到这个植物列表plantsInSameSpecies
        //该plantsInSameSpecies列表返回的是所有种名为plantName的植物，在adminPlantSameSpeciesList界面中展示的是所有种名为plantName的植物
        List<Plant> plantsInSameSpecies = plantservice.selectPlantsByPlantName(plantName);
        request.setAttribute("plantsInSameSpecies", plantsInSameSpecies);
        request.setAttribute("monitoringManagementService",monitoringmanagementservice);
        return "admin/adminPlantSameSpeciesList";
    }

    //管理员查看植物详细信息
    @RequestMapping("/adminSeePlantDetails")
    public String adminSeePlantDetails(@RequestParam("plantId") int plantId, HttpServletRequest request){
        Plant plantToBeShow = plantservice.selectPlantByPlantId(plantId);
        Photo photoToBeShow = plantservice.selectPhotoByPlantId(plantId);
        request.setAttribute("plantToBeShow", plantToBeShow);
        request.setAttribute("photoToBeShow", photoToBeShow);
        return "admin/adminSeePlantDetails";
    }

    //管理员修改植物详细信息的界面
    @RequestMapping("/adminModifyPlantDetails")
    public String adminModifyPlantDetails(@RequestParam("plantId") int plantId, HttpServletRequest request){
        Plant plantToBeModified = plantservice.selectPlantInfoByPlantId(plantId);
        request.setAttribute("plantToBeModified", plantToBeModified);
        return "admin/adminModifyPlantDetails";
    }
    //执行修改操作
    @RequestMapping(params = "method=ModifyPlantDetails")
    public String ModifyPlantDetails(Plant plant, HttpServletRequest request){
        //前端传来了隐藏的PlantId和三个修改后的信息，可以根据PlantId修改该条记录
        plantservice.modifyPlantInfo(plant);
        plant = plantservice.selectPlantByPlantId(plant.getPlantId()); //通过plantId找到这一条记录，将此处的Plat对象信息补全
        request.setAttribute("modifyPlantDetails","修改成功");
        return adminPlantSameSpeciesList(plant.getPlantName(),request); //修改后返回adminPlantSameSpeciesList.jsp界面
    }

    //修改植物图片的界面
    @RequestMapping("/adminModifyPlantPhoto")
    public String adminModifyPlantPhoto(@RequestParam("plantId") int plantId, HttpServletRequest request){
        Plant plantToBeModified = plantservice.selectPlantByPlantId(plantId);
        Photo photoToBeModify = plantservice.selectPhotoByPlantId(plantId);
        request.setAttribute("plantToBeModified", plantToBeModified);
        request.setAttribute("photoToBeModify", photoToBeModify);
        return "admin/adminModifyPlantPhoto";
    }
    //执行修改图片操作
    @RequestMapping(params = "method=ModifyPlantPhoto")
    public String ModifyPlantPhoto(Plant plant, Photo photo, MultipartFile plantImg, HttpServletRequest request) throws IOException {
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
        }
        plantservice.modifyPlantPhoto(photo);

        plant = plantservice.selectPlantByPlantId(plant.getPlantId());
        request.setAttribute("modifyPlantPhoto","修改成功");
        return adminPlantSameSpeciesList(plant.getPlantName(),request); //修改后返回adminPlantSameSpeciesList.jsp界面
    }

    //搜索结果界面
    @RequestMapping("/adminPlantListSearchResult")
    public String adminPlantListSearchResult(){
        return "admin/adminPlantListSearchResult";
    }

    //执行搜索
    @RequestMapping(params = "method=searchPlant")
    public ModelAndView searchPlant(ModelAndView mav, HttpServletRequest request){
        String searchQuery = request.getParameter("searchQuery");
        List<Plant> TargetPlants = plantservice.LikeSearchPlantByName(searchQuery);
        if(TargetPlants.isEmpty()) { //如果没查出来，就给一个弹窗
            mav.addObject("LikeSearchPlantByName", "查询无结果");
        }
        request.getSession().setAttribute("TargetPlants",TargetPlants); //更新要展示的植物
        request.getSession().setAttribute("plantservice", plantservice);
        mav.setViewName("admin/adminIndex");
        mav.addObject("start", "plant/adminPlantListSearchResult");

        return mav;
    }

    //返回adminPlantList.jsp界面
    @RequestMapping(params = "method=returnPlantList")
    public ModelAndView returnPlantList(ModelAndView mav){
        mav.setViewName("admin/adminIndex");
        mav.addObject("start","plant/adminPlantList");
        return mav;
    }

    //返回adminPlantSameSpeciesList.jsp界面
    @RequestMapping(params = "method=returnPlantSameSpeciesList")
    public String returnPlantSameSpeciesList(String plantName, HttpServletRequest request){
        return adminPlantSameSpeciesList(plantName,request);
    }


}
