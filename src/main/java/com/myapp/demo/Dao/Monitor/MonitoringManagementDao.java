package com.myapp.demo.Dao.Monitor;
import java.util.List;

import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.Monitor.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository("MonitoringManagementDao")
@Mapper
public interface MonitoringManagementDao {
    public List<MonitoringManagement> selectAllMonitoringManagement();
    //查找所有监测管理记录

    public MonitoringManagement selectMonitoringManagementById(Integer monitoringManagementId);
    //根据id查找监测管理记录

    public Integer insertOneMonitoringManagement(MonitoringManagement monitoringmanagement);
    //增加一条监测管理记录

    public Integer deleteMonitoringManagement(Integer monitoringManagementId);
    //删除一条监测管理记录

    public Integer updateMonitoringManagement(MonitoringManagement monitoringmanagement);
    //更新一条监测管理记录

    public String selectStatusByPlanId(Integer monitoringObject);

    //以下为4个模糊匹配
    public List<MonitoringManagement> LikeSelectMonitorTaskByRealName(String searchContent);
    List<MonitoringManagement> LikeSelectMonitorTaskByPlantName(String searchContent);
    List<MonitoringManagement> LikeSelectMonitorTaskByDeviceName(String searchContent);
    List<MonitoringManagement> LikeSelectMonitorTaskByPlace(String searchContent);
}
