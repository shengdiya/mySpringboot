package com.myapp.demo.Service;

import com.myapp.demo.Dao.AreaDao;
import com.myapp.demo.Entiy.Area;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("areaService")
public class AreaService {

    @Resource(name="areaDao")
    private AreaDao areadao;
    //selectAreaByPid获取所有pid为pid的地区
    public List<Area> selectAreaByPid(Integer pid){
        return areadao.selectAreaByPid(pid);
    }

    //获取所有地区
    public List<Area> selectAllArea(){
        return areadao.selectAllArea();
    }

    //根据id获取地区
    public Area selectAreaById(Integer id){
        return areadao.selectAreaById(id);
    }

}
