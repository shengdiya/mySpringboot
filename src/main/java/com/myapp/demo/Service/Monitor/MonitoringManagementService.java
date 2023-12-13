package com.myapp.demo.Service.Monitor;
import java.util.List;
import javax.annotation.Resource;

import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Entiy.Book;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.Monitor.*;
import com.myapp.demo.Entiy.Monitor.*;

@Service("MonitoringManagementService")
public class MonitoringManagementService {

    @Resource(name="MonitoringManagementDao")
    private MonitoringManagementDao monitoringmanagementdao;

    public List<MonitoringManagement> selectAllMonitoringManagement(){
        return monitoringmanagementdao.selectAllMonitoringManagement();
    }
    //查找所有监测管理记录

    public MonitoringManagement selectMonitoringManagementById(Integer monitoringManagementId){
        return monitoringmanagementdao.selectMonitoringManagementById(monitoringManagementId);
    }
    //根据id查找监测管理记录

    public MonitoringManagement selectMonitoringManagementByIdView(Integer monitoringManagementId){
        return monitoringmanagementdao.selectMonitoringManagementByIdView(monitoringManagementId);
    }
    //根据id查找监测管理记录(视图)

    public Integer insertOneMonitoringManagement(MonitoringManagement monitoringmanagement) {
        return monitoringmanagementdao.insertOneMonitoringManagement(monitoringmanagement);
    }
    //增加一条监测管理记录

    public Integer deleteMonitoringManagement(Integer monitoringManagementId) {
        return monitoringmanagementdao.deleteMonitoringManagement(monitoringManagementId);
    }
    //删除一条监测管理记录

    public Integer updateMonitoringManagement(MonitoringManagement monitoringmanagement){
        return monitoringmanagementdao.updateMonitoringManagement(monitoringmanagement);
    }
    //更新一条监测管理记录

    public String selectStatusByPlanId(Integer monitoringObject){
        if(monitoringmanagementdao.selectStatusByPlanId(monitoringObject)==null){
            return "未分配任务";
        }
        return monitoringmanagementdao.selectStatusByPlanId(monitoringObject);
    }
    //根据植物Id查找监测状态

    public List<MonitoringManagement> LikeSelectMonitorTaskByRealName(String searchContent) {
        return monitoringmanagementdao.LikeSelectMonitorTaskByRealName(searchContent);
    }

    public List<MonitoringManagement> LikeSelectMonitorTaskByPlantName(String searchContent) {
        return monitoringmanagementdao.LikeSelectMonitorTaskByPlantName(searchContent);
    }

    public List<MonitoringManagement> LikeSelectMonitorTaskByDeviceName(String searchContent) {
        return monitoringmanagementdao.LikeSelectMonitorTaskByDeviceName(searchContent);
    }

    public List<MonitoringManagement> LikeSelectMonitorTaskByPlace(String searchContent) {
        return monitoringmanagementdao.LikeSelectMonitorTaskByPlace(searchContent);
    }
}
