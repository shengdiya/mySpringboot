package com.myapp.demo.Dao;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.BorrowBookOrder;
@Repository("borrowBookOrderDao")
@Mapper
public interface BorrowBookOrderDao {
	public List<Book> selectAllBooksAllowed();
	public BorrowBookOrder selectOrderByOrderId(Integer BorrowId);
	public Integer insertOneBorrowOrder(BorrowBookOrder borrowBookOrder);
	public BorrowBookOrder isBorrowByYourself(Integer userId, Integer bookId, String status);
	public Integer statusChange(BorrowBookOrder borrowBookOrder);
	public List<BorrowBookOrder> selectOrderByStatus(String status);
	public List<BorrowBookOrder> selectOrderByUserId(Integer userId);
	public List<BorrowBookOrder> selectOrderByUserIdAndStatus(Integer userId, String status);
	public List<BorrowBookOrder> selectOrderByUnitAndStatus(String nowWhere,String status);
}
