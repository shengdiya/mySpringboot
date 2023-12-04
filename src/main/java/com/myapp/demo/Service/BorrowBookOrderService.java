package com.myapp.demo.Service;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Dao.BorrowBookOrderDao;
import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.BorrowBookOrder;

@Service("borrowBookOrderService")
public class BorrowBookOrderService {
	@Resource(name="borrowBookOrderDao")
	
	private BorrowBookOrderDao borrowBookOrderDao;
	
	//列出所有订单
	public List<Book> selectAllBooksAllowed(){
		return borrowBookOrderDao.selectAllBooksAllowed();
	}
	
	//根据Id查询订单
	public BorrowBookOrder selectOrderByOrderId(Integer BorrowId) {
		return borrowBookOrderDao.selectOrderByOrderId(BorrowId);
	}
	
	//插入一条订单
	public Integer insertOneBorrowOrder(BorrowBookOrder borrowBookOrder) {
		return borrowBookOrderDao.insertOneBorrowOrder(borrowBookOrder);
	}

	//检测是不是自己借过
	public boolean isBorrowByYourself(Integer userId, Integer bookId, String status) {
		if(borrowBookOrderDao.isBorrowByYourself(userId,bookId,status) == null) {
			return false;
		}
		return true;
	}
	
	//单独更新订单状态
	public Integer statusChange(BorrowBookOrder borrowBookOrder) {
		return borrowBookOrderDao.statusChange(borrowBookOrder);
	}
	
	//根据订单状态查找订单
	public List<BorrowBookOrder> selectOrderByStatus(String status) {
		return borrowBookOrderDao.selectOrderByStatus(status);
	}
	
	//根据userId和订单状态查找订单（查指定用户的订单用的）
	public List<BorrowBookOrder> selectOrderByUserIdAndStatus(Integer userId,String status) {	
		return borrowBookOrderDao.selectOrderByUserIdAndStatus(userId,status);
	}
	
	//根据userId查找订单
	public List<BorrowBookOrder> selectOrderByUserId(Integer userId) {
		return borrowBookOrderDao.selectOrderByUserId(userId);
	}
	
	//根据单位和订单状态查找订单（工作人员查看本单位的订单用的)
	public List<BorrowBookOrder> selectOrderByUnitAndStatus(String nowWhere,String status){
		return borrowBookOrderDao.selectOrderByUnitAndStatus(nowWhere, status);
	}
	
	
	
	
	
}
