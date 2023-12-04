package com.myapp.demo.Dao;
import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.myapp.demo.Entiy.Unit;
import com.myapp.demo.Entiy.User;

@Repository("unitDao")
@Mapper
public interface UnitDao {
	public List<Unit> selectAllUnits();
	public Unit selectUnitById(Integer unitId);
	public Integer adminInsertUnit(Unit unit);
	public Integer adminModifyUnitDetailsById(Unit unit);
	public Integer deleteUnit(Integer unitId);
	public List<Unit> searchUnit(String unitName);
	public Unit selectUnitByUnitName(String whichUnit);
}
