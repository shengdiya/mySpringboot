package com.myapp.demo.Service;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Dao.BorrowBookOrderDao;
import com.myapp.demo.Dao.FlowBookOrderDao;
import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.BorrowBookOrder;
import com.myapp.demo.Entiy.FlowBookOrder;

@Service("flowBookOrderService")
public class FlowBookOrderService {
	@Resource(name="flowBookOrderDao")
	private FlowBookOrderDao flowBookOrderDao;

	//根据bookId和unitName查找一条记录，用于检测之前是否流入这本书 (并且订单状态还要是“待审核”或“已借出”，如果已结束那么代表已经还了或者被拒绝了，可以再借)
	public boolean isRequested(String whichUnit, Integer bookId, String status) {
		 if(flowBookOrderDao.isRequested(whichUnit,bookId,status)==null) {
			 return false;
		 }
		 return true;
	}
	//添加一条记录
	public Integer insertOneRequestOrder(FlowBookOrder flowBookOrder) {
		return flowBookOrderDao.insertOneRequestOrder(flowBookOrder);
	}
	//根据单位名查询订单信息
	public List<FlowBookOrder> selectOrderByWhichUnit(String whichUnit) {
		return flowBookOrderDao.selectOrderByWhichUnit(whichUnit);
	}
	//根据单位名和订单状态查询订单信息
	public List<FlowBookOrder> selectOrderByWhichUnitAndStatus(String whichUnit,String status) {
		return flowBookOrderDao.selectOrderByWhichUnitAndStatus(whichUnit,status);
	}
	//通过flowId查找订单
	public FlowBookOrder selectOrderByflowId(Integer flowId) {
		return flowBookOrderDao.selectOrderByflowId(flowId);
	}
	//单纯更新订单状态
	public Integer flowStatusChange(FlowBookOrder flowBookOrder) {
		return flowBookOrderDao.flowStatusChange(flowBookOrder);
	}
	//选出查询单位不为whichUnit的订单（查看其它单位的请求订单）
	public List<FlowBookOrder> selectOrdersFromOtherUnits(String whichUnit,String status) {
		return flowBookOrderDao.selectOrdersFromOtherUnits(whichUnit,status);
	}
	
	//四个统计
	//按年统计本单位流出图书的数量 
	public Integer countOutBooksByYears(String whichUnit,int year) {
		return flowBookOrderDao.countOutBooksByYears(whichUnit, year);
	}
	//按月统计本单位流出图书的数量 
	public List<Map<String, Object>> countOutBooksByMonths(String whichUnit,int year){
		return flowBookOrderDao.countOutBooksByMonths(whichUnit, year);
	}
	//按年统计本单位流入图书的数量 
	public Integer countInBooksByYears(String whichUnit,int year) {
		return flowBookOrderDao.countInBooksByYears(whichUnit, year);
	}
	//按月统计本单位流入图书的数量 
	public List<Map<String, Object>> countInBooksByMonths(String whichUnit,int year){
		return flowBookOrderDao.countInBooksByMonths(whichUnit, year);
	}
	
}
