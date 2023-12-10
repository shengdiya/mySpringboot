package com.myapp.demo.Service.Monitor;
import java.util.List;
import javax.annotation.Resource;

import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Entiy.Book;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.Monitor.*;
import com.myapp.demo.Entiy.Monitor.*;

@Service("MonitoringIndicatorService")
public class MonitoringIndicatorService {

    @Resource(name="MonitoringIndicatorDao")
    private MonitoringIndicatorDao monitoringindicatordao;

    public List<MonitoringIndicator> selectAllMonitoringIndicator(){
        return monitoringindicatordao.selectAllMonitoringIndicator();
    }
    //查找所有监测指标记录

    public MonitoringIndicator selectMonitoringIndicatorById(Integer monitoringIndicatorId){
        return monitoringindicatordao.selectMonitoringIndicatorById(monitoringIndicatorId);
    }

    //根据id查找设备记录
    public Integer insertOneMonitoringIndicator(MonitoringIndicator monitoringindicator) {
        return monitoringindicatordao.insertOneMonitoringIndicator(monitoringindicator);
    }
    //增加一条监测指标记录

    public Integer deleteMonitoringIndicator(Integer monitoringIndicatorId) {
        return monitoringindicatordao.deleteMonitoringIndicator(monitoringIndicatorId);
    }
    //删除一条监测指标记录

    public Integer updateMonitoringIndicator(MonitoringIndicator monitoringindicator){
        return monitoringindicatordao.updateMonitoringIndicator(monitoringindicator);
    }
    //更新一条监测指标记录
}
