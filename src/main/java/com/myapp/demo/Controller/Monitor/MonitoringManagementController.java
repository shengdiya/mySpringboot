package com.myapp.demo.Controller.Monitor;

import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.Monitor.MonitoringDevice;
import com.myapp.demo.Entiy.Monitor.MonitoringIndicator;
import com.myapp.demo.Entiy.Monitor.MonitoringManagement;
import com.myapp.demo.Entiy.Plant;
import com.myapp.demo.Entiy.Unit;
import com.myapp.demo.Entiy.User;
import com.myapp.demo.Service.BookService;
import com.myapp.demo.Service.Monitor.MonitoringDeviceService;
import com.myapp.demo.Service.Monitor.MonitoringIndicatorService;
import com.myapp.demo.Service.Monitor.MonitoringManagementService;
import com.myapp.demo.Service.PlantService;
import com.myapp.demo.Service.UserService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/MonitorManagement")
public class MonitoringManagementController {
    @Resource(name="MonitoringManagementService")
    private MonitoringManagementService monitoringmanagementservice;

    @Resource(name="MonitoringDeviceService")
    private MonitoringDeviceService monitoringdeviceservice;

    @Resource(name="plantService")
    private PlantService plantservice;

    @Resource(name="userService")
    private UserService userservice;

    //显示监测列表界面
    @RequestMapping("/MonitorManagementShow")
    public String MonitoringManagementShow(HttpServletRequest request) {
        List<MonitoringManagement> monitoringmanagements = monitoringmanagementservice.selectAllMonitoringManagement();

        //wyx------------------------
        request.setAttribute("plantservice",plantservice);
        request.setAttribute("userservice",userservice);
        request.setAttribute("monitoringdeviceservice",monitoringdeviceservice);
        //----------------------

        request.setAttribute("monitoringmanagements", monitoringmanagements);
        return "Monitor/MonitoringManagementShow";
    }

    //删除监测记录
    @RequestMapping(params = "method=deleteMonitoringManagement")
    public ModelAndView deletedeleteMonitoringManagement(ModelAndView mav, HttpServletRequest request) throws IOException {
        try {
            String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
            MonitoringManagement monitoringManagement = monitoringmanagementservice.selectMonitoringManagementById(Integer.valueOf(monitoringmanagerId));
            if(monitoringManagement.getMonitoringStatus().equals("已结束")) { //没被在监测中
                monitoringmanagementservice.deleteMonitoringManagement(Integer.valueOf(monitoringmanagerId)); //删除monitoring_management表里的
                mav.addObject("deleteMonitoringManagerment","删除成功"); //传给前端需要弹窗的内容
            }else { //借出了不能删
                mav.addObject("deleteMonitoringManagerment","该植物尚在监测，删除失败"); //传给前端需要弹窗的内容
            }
            mav.setViewName("admin/adminIndex");
        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("deleteMonitoringManagerment","删除失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorManagement/MonitorManagementShow");//删完一个用户要再跳转到admin/adminIndex.jsp，加载其中的内容为adminSeeMonitoringManagerments.jsp，让删完之后还留在图书列表的界面
        return mav;
    }

    //添加监测记录界面
    @RequestMapping("/MonitorManagementAdd")
    public String adminAddManagement(@RequestParam("plantId") int plantId, HttpServletRequest request) {
        Plant plantToBoMonitor = plantservice.selectPlantByPlantId(plantId);
        List<MonitoringDevice> MonitoringDevices =monitoringdeviceservice.selectAllMonitoringDevice();
        request.setAttribute("MonitoringDevices",MonitoringDevices);
        request.setAttribute("plantToBoMonitor",plantToBoMonitor);
        return "Monitor/MonitoringManagementAdd";
    }

    //继续增加指标
    @RequestMapping(params = "method=addMonitorManagement")
    public String MonitoringManagementAdd( MonitoringManagement monitoringmanagement, HttpServletRequest request) {
        int num = Integer.valueOf(monitoringmanagement.getMonitoringDeviceId());
        System.out.println(num);
        String monitoringTimeStr = request.getParameter("monitoringTime1");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        java.util.Date date;
        try {
            date = dateFormat.parse(monitoringTimeStr);
            Timestamp monitoringTime = new Timestamp(date.getTime());
            monitoringmanagement.setMonitoringTime(monitoringTime);
            // 在这里可以将 Timestamp 类型的 monitoringTime 设置到相应的对象属性中
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String monitoringDevicess = monitoringdeviceservice.selectMonitoringDeviceById(num).getMonitoringIndicatorCategories();
        System.out.println(monitoringDevicess);
        String[] monitoringDevices = monitoringDevicess.split(";");
        request.setAttribute("monitoringDevices",monitoringDevices);

        request.setAttribute("monitoringManagementaddmore", monitoringmanagement);

        return "Monitor/MonitoringManagementAddmore";
    }

    //增加管理记录,并返回admin/adminIndex.jsp
    @RequestMapping(params = "method=addmoreMonitorManagement")
    public ModelAndView ModifyunitDetails( MonitoringManagement monitoringmanagement, ModelAndView mav, HttpServletRequest request) {
        try {
            String monitoringTimeStr = request.getParameter("monitoringTime1");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date date;
            try {
                date = dateFormat.parse(monitoringTimeStr);
                Timestamp monitoringTime = new Timestamp(date.getTime());
                monitoringmanagement.setMonitoringTime(monitoringTime);
                // 在这里可以将 Timestamp 类型的 monitoringTime 设置到相应的对象属性中
            } catch (ParseException e) {
                e.printStackTrace();
            }

           monitoringmanagement.setMonitoringStatus("进行中");

           int deviceID = monitoringmanagement.getMonitoringDeviceId();
           MonitoringDevice monitoringDeviced = monitoringdeviceservice.selectMonitoringDeviceById(deviceID);
            String monitoringDevicess = monitoringDeviced.getMonitoringIndicatorCategories();
            String[] monitoringDevices = monitoringDevicess.split(";");
            String indicators = "";
            for ( String monitoringdevice :monitoringDevices) {
                    indicators = indicators + (String) request.getParameter(monitoringdevice) + ";";
            }
            System.out.println(indicators);
            monitoringmanagement.setMonitoringIndicatorValues(indicators);
            monitoringDeviced.setMonitoringDeviceStatus("工作中");
            monitoringdeviceservice.updateMonitoringDevice(monitoringDeviced);
            monitoringmanagementservice.insertOneMonitoringManagement(monitoringmanagement);

            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyUnit","增加监测信息成功"); //传给前端需要弹窗的内容
        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyUnit","增加监测信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorManagement/MonitorManagementShow");
        return mav;
    }

    //修改监测记录状态
    @RequestMapping(params = "method=endMonitoringManagement")
    public ModelAndView endMonitoringManagement(ModelAndView mav, HttpServletRequest request) throws IOException {
        try {
            String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
            MonitoringManagement monitoringmanagement = monitoringmanagementservice.selectMonitoringManagementById(Integer.valueOf(monitoringmanagerId));
            monitoringmanagement.setMonitoringStatus("已结束");
            monitoringmanagementservice.updateMonitoringManagement(monitoringmanagement);
            //进行更新操作
            mav.addObject("deleteMonitoringManagerment","修改成功");
            mav.setViewName("admin/adminIndex");
        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("deleteMonitoringManagerment","修改失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorManagement/MonitorManagementShow");//删完一个用户要再跳转到admin/adminIndex.jsp，加载其中的内容为adminSeeMonitoringManagerments.jsp，让删完之后还留在图书列表的界面
        return mav;
    }

    //监测记录的详细信息
    @RequestMapping(params = "method=detailMonitoringManagement")
    public String detailMonitoringManagement(HttpServletRequest request)  {

        String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
        MonitoringManagement monitoringmanagement = monitoringmanagementservice.selectMonitoringManagementById(Integer.valueOf(monitoringmanagerId));
        int num = Integer.valueOf(monitoringmanagement.getMonitoringDeviceId());
        String monitoringDevicess = monitoringdeviceservice.selectMonitoringDeviceById(num).getMonitoringIndicatorCategories();
        System.out.println(monitoringDevicess);
        String[] monitoringDevices = monitoringDevicess.split(";");
        request.setAttribute("monitoringDevices",monitoringDevices);

        request.setAttribute("monitoringmanagementdetail", monitoringmanagement);
        return "Monitor/MonitoringManagementDetail";
    }
    //修改监测记录
    @RequestMapping(params ="method=modifyMonitoringManagement")
    public String adminModifyUnitDetails( HttpServletRequest request) {
        String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
        MonitoringManagement monitoringManagement = monitoringmanagementservice.selectMonitoringManagementById(Integer.valueOf(monitoringmanagerId));
        request.setAttribute("monitoringManagementmodify", monitoringManagement);
        int num = Integer.valueOf(monitoringManagement.getMonitoringDeviceId());
        String monitoringDevicess = monitoringdeviceservice.selectMonitoringDeviceById(num).getMonitoringIndicatorCategories();
        System.out.println(monitoringDevicess);
        String[] monitoringDevices = monitoringDevicess.split(";");
        request.setAttribute("monitoringDevices",monitoringDevices);

        return "Monitor/MonitoringManagementModify";
    }

    //管理员修改监测记录信息,并返回admin/adminIndex.jsp
    @RequestMapping(params ="method=modifyMonitoringManagements")
    public ModelAndView Modifyunit1Details( MonitoringManagement monitoringmanagement, ModelAndView mav, HttpServletRequest request) {
        try {
            String monitoringTimeStr = request.getParameter("monitoringTime1");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date date;
            try {
                date = dateFormat.parse(monitoringTimeStr);
                Timestamp monitoringTime = new Timestamp(date.getTime());
                monitoringmanagement.setMonitoringTime(monitoringTime);
                // 在这里可以将 Timestamp 类型的 monitoringTime 设置到相应的对象属性中
            } catch (ParseException e) {
                e.printStackTrace();
            }
            int deviceID = monitoringmanagement.getMonitoringDeviceId();
            MonitoringDevice monitoringDeviced = monitoringdeviceservice.selectMonitoringDeviceById(deviceID);
            String monitoringDevicess = monitoringDeviced.getMonitoringIndicatorCategories();
            String[] monitoringDevices = monitoringDevicess.split(";");
            String indicators = "";
            for ( String monitoringdevice :monitoringDevices) {
                indicators = indicators + (String) request.getParameter(monitoringdevice) + ";";
            }
            monitoringmanagement.setMonitoringIndicatorValues(indicators);
            monitoringmanagementservice.updateMonitoringManagement(monitoringmanagement);
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyUnit","修改监测信息成功"); //传给前端需要弹窗的内容
        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyUnit","修改监测信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorManagement/MonitorManagementShow");
        return mav;
    }

    //搜索结果界面
    @RequestMapping("/MonitoringManagementSearchResult")
    public String MonitoringManagementSearchResult(HttpServletRequest request) {
        request.setAttribute("plantservice",plantservice);
        request.setAttribute("userservice",userservice);
        request.setAttribute("monitoringdeviceservice",monitoringdeviceservice);
        return "Monitor/MonitoringManagementSearchResult";
    }
    //执行搜索操作
    @RequestMapping(params ="method=SearchMonitorTask")
    public ModelAndView SearchMonitorTask( HttpServletRequest request,ModelAndView mav) {
        String searchType = request.getParameter("searchType");
        String searchContent = request.getParameter("searchContent");

        List<MonitoringManagement> monitoringmanagementsSearchResult = SearchByType(searchType,searchContent);
        request.getSession().setAttribute("monitoringmanagementsSearchResult", monitoringmanagementsSearchResult); //更新要展示的列表
        mav.setViewName("admin/adminIndex");
        mav.addObject("start","MonitorManagement/MonitoringManagementSearchResult");
        return mav;
    }

    private List<MonitoringManagement> SearchByType(String searchType, String searchContent) {
        List<MonitoringManagement> result = new ArrayList<>();
        switch (searchType) {
            case "realName":
                result = monitoringmanagementservice.LikeSelectMonitorTaskByRealName(searchContent);
                break;
            case "plantName":
                result = monitoringmanagementservice.LikeSelectMonitorTaskByPlantName(searchContent);
                break;
            case "DeviceName":
                result = monitoringmanagementservice.LikeSelectMonitorTaskByDeviceName(searchContent);
                break;
            default:
                result = monitoringmanagementservice.LikeSelectMonitorTaskByPlace(searchContent);
                break;
        }
        return result;
    }


    //返回MonitoringManagementShow.jsp界面
//    @RequestMapping(params ="method=returnMonitoringManagementShow")
//    public ModelAndView returnMonitoringManagementShow(ModelAndView mav,HttpServletRequest request) {
//        String userId = request.getParameter("userId");
//        if(userservice.getUserRole(Integer.valueOf(userId)).equals("管理员")){
//            mav.setViewName("admin/adminIndex");
//        } else if (userservice.getUserRole(Integer.valueOf(userId)).equals("监测人员")) {
//
//        }
//
//    }


}
