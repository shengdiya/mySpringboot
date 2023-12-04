package com.myapp.demo.Service;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.myapp.demo.Dao.BookDao;
import com.myapp.demo.Entiy.Book;

@Service("bookService")
public class BookService {
	@Resource(name="bookDao")
	
	private BookDao bookdao;
	//查找所有图书
	public List<Book> selectAllBooks(){
		return bookdao.selectAllBooks();
	}
	//通过Id查找图书
	public Book selectBookById(Integer bookId) {
		return bookdao.selectBookById(bookId);
	}
	//查找书现在在哪
	public List<Book> selectBookByNowWhere(String nowWhere){
		return bookdao.selectBookByNowWhere(nowWhere);
	}
	//通过所属单位查找书
	public List<Book> selectBookByWhichUnit(String whichUnit){
		return bookdao.selectBookByWhichUnit(whichUnit);
	}
	//更新图书信息
	public Integer adminModifyBookDetailsById(Book book) {
		return bookdao.adminModifyBookDetailsById(book);		
	}
	//删除图书
	public Integer deleteBook(Integer bookId) {
		return bookdao.deleteBook(bookId);
	}
	//单纯更新书的剩余数量（归还或借出）
	public Integer leftChange(Book book) {
		return bookdao.leftChange(book);
	}
	//插入一本书
	public Integer insertOneBook(Book book) {
		return bookdao.insertOneBook(book);
	}
	//更新书是否可借
	public Integer updateIsAllowed(Book book) {
		return bookdao.updateIsAllowed(book);
	}
	//更新是否流出
	public Integer updateIsflowed(Book book) {
		return bookdao.updateIsflowed(book);
	}
	
	//4个模糊匹配
	public List<Book> LikeSelectBookById(String searchQuery){
		return bookdao.LikeSelectBookById(searchQuery);
	}
	public List<Book> LikeSelectBookByBookName(String searchQuery){
		return bookdao.LikeSelectBookByBookName(searchQuery);
	}
	public List<Book> LikeSelectBookByauthorName(String searchQuery){
		return bookdao.LikeSelectBookByauthorName(searchQuery);
	}
	public List<Book> LikeSelectBookByPress(String searchQuery){
		return bookdao.LikeSelectBookByPress(searchQuery);
	}
	
	//两条统计信息:本单位总图书数；当前在库总图书数；
	public Integer countAllbooksInOwnUnit(String whichUnit) {
		return bookdao.countAllbooksInOwnUnit(whichUnit);
	}
	public Integer countAllbooksInNow(String whichUnit) {
		return bookdao.countAllbooksInNow(whichUnit);
	}
}
