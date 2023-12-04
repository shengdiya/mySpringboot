package com.myapp.demo.Dao;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.myapp.demo.Entiy.Book;
@Repository("bookDao")
@Mapper
public interface BookDao {
	public List<Book> selectAllBooks();
	public Book selectBookById(Integer bookId);
	public Integer adminModifyBookDetailsById(Book book);
	public Integer deleteBook(Integer bookId);
	public Integer leftChange(Book book);
	public List<Book> selectBookByNowWhere(String nowWhere);
	public Integer insertOneBook(Book book);
	public List<Book> selectBookByWhichUnit(String whichUnit);
	public Integer updateIsAllowed(Book book);
	public Integer updateIsflowed(Book book);
	public List<Book> LikeSelectBookByBookName(String searchQuery);
	public List<Book> LikeSelectBookByauthorName(String searchQuery);
	public List<Book> LikeSelectBookByPress(String searchQuery);
	public List<Book> LikeSelectBookById(String searchQuery);
	public Integer countAllbooksInOwnUnit(String whichUnit);
	public Integer countAllbooksInNow(String whichUnit);
}
