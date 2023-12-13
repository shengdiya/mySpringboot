package com.myapp.demo.Dao.Monitor;
import java.util.List;

import com.myapp.demo.Entiy.Monitor.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("MonitoringIndicatorDao")
@Mapper
public interface MonitoringIndicatorDao {
    public List<MonitoringIndicator> selectAllMonitoringIndicator();
    //查找所有指标管理记录

    public MonitoringIndicator selectMonitoringIndicatorById(Integer monitoringIndicatorId);
    //根据id查找设备记录
    
    public Integer insertOneMonitoringIndicator(MonitoringIndicator monitoringindicator);
    //增加一条指标管理记录

    public Integer deleteMonitoringIndicator(Integer monitoringIndicatorId);
    //删除一条指标管理记录

    public Integer updateMonitoringIndicator(MonitoringIndicator monitoringindicator);
    //更新一条指标管理记录
}
