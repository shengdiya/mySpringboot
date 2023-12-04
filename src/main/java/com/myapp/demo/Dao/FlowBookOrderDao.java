package com.myapp.demo.Dao;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.BorrowBookOrder;
import com.myapp.demo.Entiy.FlowBookOrder;

@Repository("flowBookOrderDao")
@Mapper
public interface FlowBookOrderDao {
	public FlowBookOrder isRequested(String whichUnit, Integer bookId, String status);
	public Integer insertOneRequestOrder(FlowBookOrder flowBookOrder);
	public List<FlowBookOrder> selectOrderByWhichUnit(String whichUnit);
	public List<FlowBookOrder> selectOrderByWhichUnitAndStatus(String whichUnit, String status);
	public FlowBookOrder selectOrderByflowId(Integer flowId);
	public Integer flowStatusChange(FlowBookOrder flowBookOrder);
	public List<FlowBookOrder> selectOrdersFromOtherUnits(String whichUnit, String status);
	public Integer countOutBooksByYears(String whichUnit,int year);
	public List<Map<String, Object>> countOutBooksByMonths(String whichUnit,int year);
	public Integer countInBooksByYears(String whichUnit,int year);
	public List<Map<String, Object>> countInBooksByMonths(String whichUnit,int year);
}
