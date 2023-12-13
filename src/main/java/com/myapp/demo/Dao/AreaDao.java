package com.myapp.demo.Dao;

import com.myapp.demo.Entiy.Area;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("areaDao")
@Mapper
public interface AreaDao {

    //selectAreaByPid获取所有pid为pid的地区
    List<Area> selectAreaByPid(Integer pid);

    //获取所有地区
    List<Area> selectAllArea();

    //根据id获取地区
    Area selectAreaById(Integer id);
}
