package com.myapp.demo.Service;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.UnitDao;
import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.Unit;
import com.myapp.demo.Entiy.User;

@Service("unitService")
public class UnitService {
	@Resource(name="unitDao")
	
	private UnitDao unitdao;
	
	public List<Unit> selectAllUnits(){
		return unitdao.selectAllUnits();
	}
	
	public Unit selectUnitById(Integer unitId) {
		return unitdao.selectUnitById(unitId);
	}

	public Integer adminModifyUnitDetailsById(Unit unit) {	
		return unitdao.adminModifyUnitDetailsById(unit);
	}

	public Integer deleteUnit(Integer unitId) {
		return unitdao.deleteUnit(unitId);
	}
	//添加一个单位
	public Integer adminInsertUnit(Unit unit) {
		List<Unit> units = unitdao.selectAllUnits();
		for(Unit u : units) {
			if(u.getUnitName().equals(unit.getUnitName())) {  //重名了
				return 0; //重名就返回0
			}
		}
		return unitdao.adminInsertUnit(unit);//没有重名就插入并返回（肯定不是0）
	}

	public List<Unit> searchUnit(String unitName) {
		return unitdao.searchUnit(unitName);
	}

	public Unit selectUnitByUnitName(String whichUnit) {
		return unitdao.selectUnitByUnitName(whichUnit);
	}
	
	
	
	
}
