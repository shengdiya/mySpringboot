package com.myapp.demo.Controller;
import java.io.IOException;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myapp.demo.Service.*;
import com.myapp.demo.Entiy.*;

@Controller
@RequestMapping("/unit")
public class UnitController {
	@Resource(name="unitService")
	private UnitService unitservice;
	
	@Resource(name="bookService")
	private BookService bookservice;
	
	//管理员看图书列表界面
	@RequestMapping("/adminSeeUnits")
	public String adminSeeUnits(HttpServletRequest request, HttpServletResponse response) {
		List<Unit> units = unitservice.selectAllUnits();
		request.setAttribute("units", units);
		return "adminSeeUnits";
	}
	//管理员查看单位详细信息界面
	@RequestMapping("/adminSeeUnitDetails")
	public String adminSeeUnitDetails(@RequestParam("unitId") int unitId, HttpServletRequest request) {
		Unit unit = unitservice.selectUnitById(unitId);
		request.setAttribute("unit", unit);
		return "adminSeeUnitDetails";
	}
	//回到adminSeeUnits界面（点击"返回"）
	@RequestMapping(params = "method=returnUnitList")
	public ModelAndView returnUnitList(ModelAndView mav) {
		mav.setViewName("adminIndex");
		mav.addObject("start","unit/adminSeeUnits");
		return mav;
	}
	//管理员修改单位信息
	@RequestMapping("/adminModifyUnitDetails")
	public String adminModifyUnitDetails(@RequestParam("unitId") int unitId, HttpServletRequest request) {
		Unit unit = unitservice.selectUnitById(unitId);
		request.setAttribute("unit", unit);
		return "adminModifyUnitDetails";
	}
	//管理员修改单位信息,并返回adminIndex.jsp
	@RequestMapping(params = "method=ModifyunitDetails")
	public ModelAndView ModifyunitDetails(@ModelAttribute("unit") Unit unit, ModelAndView mav) {
		try {
			System.out.println("ModifyBookDetails:bookId: " + unit.getUnitId());
			unitservice.adminModifyUnitDetailsById(unit);
			mav.setViewName("adminIndex");
			mav.addObject("modifyUnit","修改单位信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("modifyUnit","修改单位信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start","unit/adminSeeUnits");
		return mav;
	}
	//管理员删除单位（还没实现“检查图书的借阅状态，尚未归还的图书需归还后才能删除”）
	@RequestMapping(params = "method=deleteUnit")
	public ModelAndView deleteUnit(ModelAndView mav, HttpServletRequest request) throws IOException {	
		try {
			String unitId = request.getParameter("unitId"); //接收要删单位的Id
			String unitName = unitservice.selectUnitById(Integer.valueOf(unitId)).getUnitName();
			List<Book> books = bookservice.selectBookByNowWhere(unitName); //查找现在单位里有哪些书
			boolean flag = true;
			for(Book book : books) { //查找要删除的单位里还有没有别的单位的书
				if(!book.getNowWhere().equals(book.getWhichUnit())) { //现在在的单位和所属单位不一致，说明是从别的地方借来的，还没还，还不能删
					flag = false;
					break;
				}
			}
			if(flag) {
				unitservice.deleteUnit(Integer.valueOf(unitId)); //删除unit表里的
				mav.addObject("deleteUnit","删除单位成功"); //传给前端需要弹窗的内容
			}else {
				mav.addObject("deleteUnit","该单位还有未结束的图书流通，暂不能删除"); //传给前端需要弹窗的内容
			}
			mav.setViewName("adminIndex");
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("deleteUnit","删除单位失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start","unit/adminSeeUnits");//删完一个用户要再跳转到adminIndex.jsp
		return mav;
	}
	
	//管理员添加单位界面
	@RequestMapping("/adminAddUnit")
	public String adminAddUnit() {
	    return "adminAddPlant";
	}
	//管理员添加一个单位
	@RequestMapping(params = "method=GetadminAddUnit") 
	public ModelAndView GetadminAddUnit(Unit unit,ModelAndView mav) throws IOException {
		//开始添加
		if(unitservice.adminInsertUnit(unit)!=0) {
			mav.addObject("addUnit","单位添加成功"); //传给前端需要弹窗的内容
		}else {
			mav.addObject("addUnit","已有此单位，添加失败"); //传给前端需要弹窗的内容
		}
		mav.setViewName("adminIndex");
		mav.addObject("start","unit/adminAddUnit");
		return mav;
	}
	
	//管理员查询单位
	@RequestMapping("/adminSearchUnitResult")
	public String adminSearchUnitResult() {
		return "adminSearchUnitResult";
	}
	//管理员查询单位
	@RequestMapping(params = "method=searchUnit")
	public ModelAndView searchUnit(String unitName, ModelAndView mav,HttpServletRequest request) {
		List<Unit> units = unitservice.searchUnit(unitName);
		if(units.isEmpty()) {
			mav.addObject("NotFound","无结果");
		}
		request.getSession().setAttribute("unitsSearched", units);	//更新要展示的列表
		mav.setViewName("adminIndex");
		mav.addObject("start","/unit/adminSearchUnitResult"); //显示查询结果界面
		
		return mav;
	}
}
