package com.myapp.demo.Service.Monitor;
import java.util.List;
import javax.annotation.Resource;

import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Entiy.Book;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.Monitor.*;
import com.myapp.demo.Entiy.Monitor.*;

@Service("MonitoringDeviceService")
public class MonitoringDeviceService {

    @Resource(name="MonitoringDeviceDao")
    private MonitoringDeviceDao monitoringdevicedao;

    public List<MonitoringDevice> selectAllMonitoringDevice(){
        return monitoringdevicedao.selectAllMonitoringDevice();
    }
    //查找所有监测设备记录

    public MonitoringDevice selectMonitoringDeviceById(Integer monitoringDeviceId){
        return monitoringdevicedao.selectMonitoringDeviceById(monitoringDeviceId);
    }
    //根据id查找设备记录


    public MonitoringDevice selectMonitoringDeviceByName(String monitoringDeviceName){
        return monitoringdevicedao.selectMonitoringDeviceByName(monitoringDeviceName);
    }
    //根据设备名查找设备记录


    public Integer insertOneMonitoringDevice(MonitoringDevice monitoringdevice) {
        return monitoringdevicedao.insertOneMonitoringDevice(monitoringdevice);
    }
    //增加一条监测设备记录

    public Integer deleteMonitoringDevice(Integer monitoringDeviceId) {
        return monitoringdevicedao.deleteMonitoringDevice(monitoringDeviceId);
    }
    //删除一条监测设备记录

    public Integer updateMonitoringDevice(MonitoringDevice monitoringdevice){
        return monitoringdevicedao.updateMonitoringDevice(monitoringdevice);
    }
    //更新一条监测设备记录
}
