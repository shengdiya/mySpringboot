package com.myapp.demo.Dao.Monitor;
import java.util.List;

import com.myapp.demo.Entiy.Monitor.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("MonitoringDeviceDao")
@Mapper
public interface MonitoringDeviceDao {
    public List<MonitoringDevice> selectAllMonitoringDevice();
    //查找所有设备管理记录

    public MonitoringDevice selectMonitoringDeviceById(Integer monitoringDeviceId);
    //根据id查找设备记录

    public MonitoringDevice selectMonitoringDeviceByName(String monitoringDeviceName);
    //根据设备名查找设备记录

    public Integer insertOneMonitoringDevice(MonitoringDevice monitoringdevice);
    //增加一条设备管理记录

    public Integer deleteMonitoringDevice(Integer monitoringDeviceId);
    //删除一条设备管理记录

    public Integer updateMonitoringDevice(MonitoringDevice monitoringdevice);
    //更新一条设备管理记录
}
