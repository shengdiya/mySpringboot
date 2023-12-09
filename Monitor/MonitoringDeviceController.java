package com.myapp.demo.Controller.Monitor;

import com.myapp.demo.Entiy.Monitor.MonitoringDevice;
import com.myapp.demo.Entiy.Monitor.MonitoringManagement;
import com.myapp.demo.Entiy.Unit;
import com.myapp.demo.Service.Monitor.MonitoringDeviceService;
import com.myapp.demo.Service.Monitor.MonitoringManagementService;
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
        request.setAttribute("monitoringdevices", monitoringdevices);
        return "Monitor/MonitoringDeviceShow";
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
                mav.addObject("modifyMonitorDevice","增加单位信息成功"); //传给前端需要弹窗的内容
            }else { //工作中不能删
                mav.addObject("modifyMonitorDevice","该设备重名，增加失败"); //传给前端需要弹窗的内容
            }

            mav.setViewName("adminIndex");

        }catch(Exception e) {
            mav.setViewName("adminIndex");
            mav.addObject("modifyMonitoringDevice","增加设备信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");
        return mav;
    }


    //删除设备记录
    @RequestMapping(params = "method=deleteMonitoringDevice")
    public ModelAndView deletedeleteMonitoringDevice(ModelAndView mav, HttpServletRequest request) throws IOException {
        try {
            String monitoringmanagerId = request.getParameter("id"); //接收要删除用户的Id
            MonitoringDevice monitoringDevice = monitoringdeviceservice.selectMonitoringDeviceById(Integer.valueOf(monitoringmanagerId));
            if(monitoringDevice.getMonitoringDeviceStatus().equals("空闲中")) { //没被在监测中
                monitoringdeviceservice.deleteMonitoringDevice(Integer.valueOf(monitoringmanagerId)); //删除monitoring_device表里的
                mav.addObject("deleteMonitoringDevice","删除成功"); //传给前端需要弹窗的内容
            }else { //工作中不能删
                mav.addObject("deleteMonitorDevice","该设备尚在监测，删除失败"); //传给前端需要弹窗的内容
            }
            mav.setViewName("adminIndex");
        }catch(Exception e) {
            mav.setViewName("adminIndex");
            mav.addObject("deleteMonitoringDevice","删除失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");//删完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminSeeMonitoringManagerments.jsp，让删完之后还留在图书列表的界面
        return mav;
    }

    //修改监测设备
    @RequestMapping(params = "method=modifyMonitorDevice")
    public String MonitoringDeviceModify( HttpServletRequest request) {
        String monitoringdeviceId = request.getParameter("id"); //接收要删除用户的Id
        MonitoringDevice monitoringDevice = monitoringdeviceservice.selectMonitoringDeviceById(Integer.valueOf(monitoringdeviceId));
        request.setAttribute("monitoringDevicemodify", monitoringDevice);

        return "MonitorDevice/MonitoringDeviceModify";
    }

    //修改监测设备,并返回adminIndex.jsp
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

                mav.addObject("modifyMonitoringDevice","修改单位信息成功"); //传给前端需要弹窗的内容
            }else { //工作中不能删
                mav.addObject("modifyMonitoringDevice","该设备重名，修改失败"); //传给前端需要弹窗的内容
            }

            mav.setViewName("adminIndex");

        }catch(Exception e) {
            mav.setViewName("adminIndex");
            mav.addObject("modifyMonitoringDevice","修改设备信息失败"); //传给前端需要弹窗的内容
        }
        mav.addObject("start","MonitorDevice/MonitorDeviceShow");
        return mav;
    }

}
