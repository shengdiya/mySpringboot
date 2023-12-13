package com.myapp.demo.Controller.Monitor;

import com.myapp.demo.Entiy.Monitor.MonitoringDevice;
import com.myapp.demo.Service.Monitor.MonitoringDeviceService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/MonitorDevice")
public class MonitoringDeviceController {
    @Resource(name="MonitoringDeviceService")
    private MonitoringDeviceService monitoringdeviceservice;

    //显示监测设备列表界面
    @RequestMapping("/MonitorDeviceShow")
    public String MonitoringDeviceShow(HttpServletRequest request, HttpServletResponse response) {
        List<MonitoringDevice> monitoringdevices = monitoringdeviceservice.selectAllMonitoringDevice();
        System.out.println(monitoringdevices.size());
        request.setAttribute("monitoringdevices", monitoringdevices);
        System.out.println("sss");
        return "Monitor/MonitoringDeviceShow";
    }

    //返回MonitorDeviceShow.jsp
    @RequestMapping(params = "method=returnMonitoringDeviceShow")
    public String returnMonitoringDeviceShow(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("start","MonitorDevice/MonitorDeviceShow");
        return "admin/adminIndex";
    }

    //管理员添加设备界面
    @RequestMapping("/MonitorDeviceAdd")
    public String adminAddUnit() {
        return "Monitor/MonitoringDeviceAdd";
    }

    //添加一个监测设备记录
    @RequestMapping(params = "method=addMonitorDevice")
    public ModelAndView addmonitoringdeviceDetails( MonitoringDevice monitoringdevice, ModelAndView mav,HttpServletRequest request) {
        try {
            if(monitoringdeviceservice.selectMonitoringDeviceByName(monitoringdevice.getMonitoringDeviceName())==null) { //没被在监测中
                String inputValues = "";
                int n = Integer.parseInt(request.getParameter("inputNumber")); // 获取提交的数字n
                for (int i = 1; i <= n; i++) {
                    String inputValue = request.getParameter("inputField" + i);
                    inputValues += inputValue + ";";
                }
                monitoringdevice.setMonitoringIndicatorCategories(inputValues);
                monitoringdevice.setMonitoringDeviceStatus("空闲中");

                monitoringdeviceservice.insertOneMonitoringDevice(monitoringdevice);
                mav.addObject("modifyMonitor","增加设备信息成功"); //传给前端需要弹窗的内容
            }else { //工作中不能删
                mav.addObject("modifyMonitor","该设备重名，增加失败"); //传给前端需要弹窗的内容
            }

            mav.setViewName("admin/adminIndex");

        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyMonitor","增加设备信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");
        return mav;
    }


    //删除设备记录
    @RequestMapping(params = "method=deleteMonitoringDevice")
    public ModelAndView deletedeleteMonitoringDevice(ModelAndView mav, HttpServletRequest request) throws IOException {
        try {
            System.out.println("");
            String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
            MonitoringDevice monitoringDevice = monitoringdeviceservice.selectMonitoringDeviceById(Integer.valueOf(monitoringmanagerId));
            if(monitoringDevice.getMonitoringDeviceStatus().equals("空闲中")) { //没被在监测中
                monitoringdeviceservice.deleteMonitoringDevice(Integer.valueOf(monitoringmanagerId)); //删除monitoring_device表里的
                mav.addObject("modifyMonitor","删除成功"); //传给前端需要弹窗的内容
            }else { //工作中不能删
                mav.addObject("modifyMonitor","该设备尚在监测，删除失败"); //传给前端需要弹窗的内容
            }
            mav.setViewName("admin/adminIndex");
        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyMonitor","删除失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");//删完一个用户要再跳转到admin/adminIndex.jsp，加载其中的内容为adminSeeMonitoringManagerments.jsp，让删完之后还留在图书列表的界面
        return mav;
    }

    //修改监测设备
    @RequestMapping(params = "method=modifyMonitoringDevice")
    public String MonitoringDeviceModify( HttpServletRequest request) {
        String monitoringdeviceId = request.getParameter("id"); //接收要删除用户的Id

        MonitoringDevice monitoringDevice = monitoringdeviceservice.selectMonitoringDeviceById(Integer.valueOf(monitoringdeviceId));
        if(monitoringDevice.getMonitoringDeviceStatus().equals("工作中"))
        {
            request.setAttribute("modifyDevice","工作中禁止修改");
            request.setAttribute("start","MonitorDevice/MonitorDeviceShow");
            return "admin/adminIndex";
        }
        else
        {
            request.setAttribute("monitoringDevicemodify", monitoringDevice);
            return "Monitor/MonitoringDeviceModify";
        }

    }

    //修改监测设备,并返回admin/adminIndex.jsp
    @RequestMapping(params = "method=modifyMonitorDevices")
    public ModelAndView ModifymonitoringdeviceDetails( MonitoringDevice monitoringdevice, ModelAndView mav, HttpServletRequest request) {
        try {
            if(monitoringdeviceservice.selectMonitoringDeviceByName(monitoringdevice.getMonitoringDeviceName())==null || monitoringdevice.getMonitoringDeviceName().equals(request.getParameter("oldname")))  { //没被在监测中
                String inputValues = "";
                int n = Integer.parseInt(request.getParameter("inputNumber")); // 获取提交的数字n
                for (int i = 1; i <= n; i++) {
                    String inputValue = request.getParameter("inputField" + i);
                    inputValues += inputValue + ";";
                }
                monitoringdevice.setMonitoringIndicatorCategories(inputValues);
                monitoringdeviceservice.updateMonitoringDevice(monitoringdevice);
                mav.addObject("modifyMonitor","修改单位信息成功"); //传给前端需要弹窗的内容
            }else {  //此处可以改成用触发器
                mav.addObject("modifyMonitor","该设备重名，修改失败"); //传给前端需要弹窗的内容
            }

            mav.setViewName("admin/adminIndex");

        }catch(Exception e) {
            mav.setViewName("admin/adminIndex");
            mav.addObject("modifyMonitor","修改设备信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");
        return mav;
    }

    //显示监测设备列表界面
    @RequestMapping("/MonitoringDeviceSearchResult")
    public String MonitoringDeviceSearchResult(HttpServletRequest request, HttpServletResponse response) {
        return "Monitor/MonitoringDeviceSearchResult";
    }

    //搜索监测设备（根据名称）
    @RequestMapping(params = "method=deviceSearch")
    public ModelAndView deviceSearch(HttpServletRequest request,ModelAndView mav) {
        String searchContent = request.getParameter("searchContent");
        List<MonitoringDevice> monitoringdevices = monitoringdeviceservice.LikeSelectDevicesByName(searchContent);
        request.getSession().setAttribute("monitoringdevices", monitoringdevices);
        mav.setViewName("admin/adminIndex");
        mav.addObject("start","MonitorDevice/MonitoringDeviceSearchResult");
        return mav;
    }
}
