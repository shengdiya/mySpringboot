package com.myapp.demo.Controller;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.User;
import com.myapp.demo.Service.BookService;

@Controller
@RequestMapping("/book")
public class BookController {
	@Resource(name="bookService")
	
	private BookService bookservice;
	
	//管理员看图书列表界面
	@RequestMapping("/adminSeeBooks")
	public String adminSeeBooks(HttpServletRequest request, HttpServletResponse response) {
		List<Book> books = bookservice.selectAllBooks();
		request.setAttribute("books", books);
		return "adminSeeBooks";
	}
	//管理员查看图书详细信息界面
	@RequestMapping("/adminSeeBookDetails")
	public String adminSeeBookDetails(@RequestParam("bookId") int bookId, HttpServletRequest request) {
		//@RequestParam注解用于获取名为 bookId 的请求参数。这个参数对应于超链接中传递的图书Id（adminSeeBooks.jsp中传来的）。
		//根据Id得到Book对象后，用request的setAttribute方法传给前端adminSeeDetails.jsp
		//adminSeeBookDetails.jsp再用request的getAttribute方法得到这个Book对象
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);		
		return "adminSeeBookDetails";
	}
	//回到adminSeeBooks界面（点击adminSeeBookDetails.jsp中的"返回"）
	@RequestMapping(params = "method=returnBookList")
	public ModelAndView returnBookList(ModelAndView mav) {
		mav.setViewName("adminIndex");
		mav.addObject("start","book/adminSeeBooks");
		return mav;
	}
	
	//修改图书信息界面
	@RequestMapping("/adminModifyBookDetails")
	public String adminModifyBookDetails(@RequestParam("bookId") int bookId, HttpServletRequest request) {
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);
		return "adminModifyBookDetails";
	}
	//修改图书信息,并返回adminIndex.jsp
	@RequestMapping(params = "method=ModifyBookDetails")
	public ModelAndView ModifyBookDetails(@ModelAttribute("book") Book book, MultipartFile bookImage,ModelAndView mav, HttpServletRequest request) {
		try {
			if (bookImage != null && !bookImage.isEmpty()) {
		        String originalFilename = bookImage.getOriginalFilename();
			    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			    // 对文件名进行唯一化处理，加上时间戳
			    String fileName = System.currentTimeMillis() + extension;
		        String storagePath = request.getSession().getServletContext().getRealPath("/imgs/books");
		        File destinationFile = new File(storagePath, fileName);
		        // 确保目录存在
		        if (!destinationFile.getParentFile().exists()) {
		            destinationFile.getParentFile().mkdirs();
		        }
		        bookImage.transferTo(destinationFile);
			    // 设置图书的图片路径字段
		        book.setPicturePath("/imgs/books/" + fileName);
			}else { //要是没改图片，就根据Id找到这本书原先的信息，把thisBook的PicturePath赋给book，保证PicturePath不变
				Book thisBook = bookservice.selectBookById(book.getBookId());
				book.setPicturePath(thisBook.getPicturePath()); 
			}
			bookservice.adminModifyBookDetailsById(book);
			mav.setViewName("adminIndex");
			mav.addObject("modifyBook","修改图书信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("modifyBook","修改图书信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start","book/adminSeeBooks");
		return mav;
	}
	//管理员删除图书
	@RequestMapping(params = "method=deleteBook")
	public ModelAndView deleteBook(ModelAndView mav, HttpServletRequest request) throws IOException {	
		try {
			String bookId = request.getParameter("bookId"); //接收要删除用户的Id
			Book book = bookservice.selectBookById(Integer.valueOf(bookId));
			if(book.getLeft() > 0) { //没被借出
				bookservice.deleteBook(Integer.valueOf(bookId)); //删除book_info表里的
				mav.addObject("deleteBook","删除成功"); //传给前端需要弹窗的内容
			}else { //借出了不能删
				mav.addObject("deleteBook","该图书尚未归还，删除失败"); //传给前端需要弹窗的内容
			}
			mav.setViewName("adminIndex");
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("deleteBook","删除失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start","book/adminSeeBooks");//删完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminSeeBooks.jsp，让删完之后还留在图书列表的界面
		return mav;
	}
	
	
	//----------------------------以下为staff对图书的操作--------------------------------------------------------------------------------------------------------------------------
	
	//工作人员添加图书界面
	@RequestMapping("/staffAddBook")
	public String staffAddBook() {
		return "staffAddBook";
	}
	//工作人员添加图书
	@RequestMapping(params = "method=StaffAddBook")
	public ModelAndView StaffAddBook(Book book, MultipartFile bookImage,ModelAndView mav, HttpServletRequest request) throws IOException {	
		//书名、出版时间、作者、出版社、图书分类、页数、价格、所属单位、图片 由前端传来
		//bookId自动生成，剩余数量、是否可被借阅、所在位置、是否流出需要手动设置
		book.setLeft(1);//剩1本
		book.setAllowed(true);//默认不隐藏
		book.setNowWhere(book.getWhichUnit());//刚添加属于哪个单位就在哪
		book.setIsflowed(false); //刚添加则还没流出
		//处理图片
		if (bookImage != null && !bookImage.isEmpty()) {
	        String originalFilename = bookImage.getOriginalFilename();
		    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
		    // 对文件名进行唯一化处理，加上时间戳
		    String fileName = System.currentTimeMillis() + extension;
	        String storagePath = request.getSession().getServletContext().getRealPath("/imgs/books");
	        File destinationFile = new File(storagePath, fileName);

	        // 确保目录存在
	        if (!destinationFile.getParentFile().exists()) {
	            destinationFile.getParentFile().mkdirs();
	        }
	        bookImage.transferTo(destinationFile);
		    // 设置图书的图片路径字段
	        book.setPicturePath("/imgs/books/" + fileName);
		}else {  //没上传图片就使用默认图片
			book.setPicturePath("/imgs/books/bookdefault.jpg");
		}
		
		bookservice.insertOneBook(book);
		mav.setViewName("staffIndex");
		mav.addObject("staffStart", "book/staffAddBook");
		mav.addObject("addbook", "添加成功");
		return mav;
	}
	
	//工作人员批量添加图书界面
	@RequestMapping("/staffAddManyBook")
	public String staffAddManyBook() {
		return "staffAddManyBook";
	}
	@RequestMapping(params = "method=StaffAddManyBooks")
	 public ModelAndView StaffAddManyBooks(MultipartFile excelFile, ModelAndView mav, HttpServletRequest request) throws IOException {
        if (excelFile == null || excelFile.isEmpty()) {
            mav.addObject("error", "未选择文件或文件为空");
            mav.setViewName("staffIndex");
            return mav;
        }
        Workbook workbook;
        String filename = excelFile.getOriginalFilename();
        InputStream in = excelFile.getInputStream();
        if (filename.endsWith(".xls")) {
            workbook = new HSSFWorkbook(in);
        } else if (filename.endsWith(".xlsx")) {
            workbook = new XSSFWorkbook(in);
        } else {
            throw new IllegalArgumentException("需要excel文件");
        }
        Sheet sheet = workbook.getSheetAt(0); // 假设只有一个工作表
        Iterator<Row> rows = sheet.iterator();
        List<Book> books = new ArrayList<>();
        
        try {
        	while (rows.hasNext()) {
                Row currentRow = rows.next();
                if (currentRow.getRowNum() == 0) { // 跳过标题行
                    continue;
                }
                Book book = new Book();
                book.setBookName(currentRow.getCell(0).getStringCellValue());
                
                //时间类型矫正
                Cell dateCell = currentRow.getCell(1);
                java.util.Date utilDate = dateCell.getDateCellValue();
                book.setOutTime(new Date(utilDate.getTime())); // 将java.util.Date转换为java.sql.Date
                
                book.setPress(currentRow.getCell(2).getStringCellValue());
                book.setAuthorName(currentRow.getCell(3).getStringCellValue());
                book.setType(currentRow.getCell(4).getStringCellValue());
                book.setPageNumber((int) currentRow.getCell(5).getNumericCellValue());
                book.setPrice((float)currentRow.getCell(6).getNumericCellValue());

                // 默认值设置
                book.setLeft(1);
                book.setAllowed(true);
                User staff = (User) request.getSession().getAttribute("staff");
                //book.setWhichUnit(staff.getWhichUnit());
                //book.setNowWhere(staff.getWhichUnit());
                book.setIsflowed(false);

                // 图片处理，添加默认图片路径
                book.setPicturePath("/imgs/books/bookdefault.jpg");
                books.add(book);
            }
            
            workbook.close();
            in.close();
            
            //批量添加
            for (Book book : books) {
                bookservice.insertOneBook(book);
            }
            mav.addObject("addManyBooks", "批量添加成功");
            mav.addObject("staffStart", "/book/staffAddManyBook");
            mav.setViewName("staffIndex");
        }catch(Exception e){
        	mav.addObject("addManyBooks", "表格中的数据有误，批量添加失败");
        	mav.addObject("staffStart", "/book/staffAddManyBook");
        	mav.setViewName("staffIndex");
        }
   
        return mav;
    }
	
	//工作人员查看图书界面
//	@RequestMapping("/staffSeeBooks")
//	public String staffSeeBooks(HttpServletRequest request) {
//		User staff = (User) request.getSession().getAttribute("staff");
//		List<Book> booksInThisUnit = bookservice.selectBookByWhichUnit(staff.getWhichUnit());
//		request.setAttribute("booksInThisUnit", booksInThisUnit);
//		return "staffSeeBooks";
//	}
	//工作人员查看图书（缩略图版）界面
//	@RequestMapping("/staffSeeBooksByPicture")
//	public String staffSeeBooksByPicture(HttpServletRequest request) {
//		User staff = (User) request.getSession().getAttribute("staff");
//		List<Book> booksInThisUnit = bookservice.selectBookByWhichUnit(staff.getWhichUnit());
//		request.setAttribute("booksInThisUnit", booksInThisUnit);
//		return "staffSeeBooksByPicture";
//	}
	
	//工作人员查看图书详细信息界面
	@RequestMapping("/StaffSeeBookDetails")
	public String StaffSeeBookDetails(@RequestParam("bookId") int bookId, HttpServletRequest request) {		
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);		
		return "StaffSeeBookDetails";
	}
	//回到初始界面（点击"返回"）
	@RequestMapping(params = "method=staffReturnBookList")
	public ModelAndView staffReturnBookList(ModelAndView mav) {
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffSeeBooks");
		return mav;
	}
	//修改图书信息界面
	@RequestMapping("/StaffModifyBookDetails")
	public String StaffModifyBookDetails(@RequestParam("bookId") int bookId, HttpServletRequest request) {
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);
		return "StaffModifyBookDetails";
	}
	//修改图书信息,并返回adminIndex.jsp
	@RequestMapping(params = "method=StaffModifyBookDetails")
	public ModelAndView StaffModifyBookDetails(@ModelAttribute("book") Book book,MultipartFile bookImage, ModelAndView mav,HttpServletRequest request) {
		try {
			if (bookImage != null && !bookImage.isEmpty()) {
		        String originalFilename = bookImage.getOriginalFilename();
			    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
			    // 对文件名进行唯一化处理，加上时间戳
			    String fileName = System.currentTimeMillis() + extension;
		        String storagePath = request.getSession().getServletContext().getRealPath("/imgs/books");
		        File destinationFile = new File(storagePath, fileName);
		        // 确保目录存在
		        if (!destinationFile.getParentFile().exists()) {
		            destinationFile.getParentFile().mkdirs();
		        }
		        bookImage.transferTo(destinationFile);
			    // 设置图书的图片路径字段
		        book.setPicturePath("/imgs/books/" + fileName);
			}else { //要是没改图片，就根据Id找到这本书原先的信息，把thisBook的PicturePath赋给book，保证PicturePath不变
				Book thisBook = bookservice.selectBookById(book.getBookId());
				book.setPicturePath(thisBook.getPicturePath()); 
			}
			bookservice.adminModifyBookDetailsById(book);
			mav.setViewName("staffIndex");
			mav.addObject("modifyBook","修改图书信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("staffIndex");
			mav.addObject("modifyBook","修改图书信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("staffStart","/book/staffSeeBooks");
		return mav;
	}
	//工作人员删除图书
	@RequestMapping(params = "method=staffDeleteBook")
	public ModelAndView staffDeleteBook(ModelAndView mav, HttpServletRequest request) throws IOException {	
		try {
			String bookId = request.getParameter("bookId"); //接收要删除用户的Id
			Book book = bookservice.selectBookById(Integer.valueOf(bookId));
			if(book.getLeft() > 0) { //没被借出
				bookservice.deleteBook(Integer.valueOf(bookId)); //删除book_info表里的
				mav.addObject("deleteBook","删除成功"); //传给前端需要弹窗的内容
			}else { //借出了不能删
				mav.addObject("deleteBook","该图书尚未归还，删除失败"); //传给前端需要弹窗的内容
			}
			mav.setViewName("staffIndex");
		}catch(Exception e) {
			mav.setViewName("staffIndex");
			mav.addObject("deleteBook","删除失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("staffStart","/book/staffSeeBooks");
		return mav;
	}
	
	//工作人员开放图书
	@RequestMapping(params = "method=StaffAllowBook")
	public ModelAndView StaffAllowBook(ModelAndView mav, HttpServletRequest request){	
		String bookId = request.getParameter("bookId"); //接收要开放图书的Id
		Book book = bookservice.selectBookById(Integer.valueOf(bookId));
		if(book.isAllowed()) { //本来就是开放的
			mav.addObject("isAllowed","请勿重复开放");
		}else {
			book.setAllowed(true);
			bookservice.updateIsAllowed(book); //开放
			mav.addObject("isAllowed","开放此图书成功");
		}
		
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffSeeBooks");
		return mav;
	}
	//工作人员开放图书
	@RequestMapping(params = "method=StaffNotAllowBook")
	public ModelAndView StaffNotAllowBook(ModelAndView mav, HttpServletRequest request){	
		String bookId = request.getParameter("bookId"); //接收要开放图书的Id
		Book book = bookservice.selectBookById(Integer.valueOf(bookId));
		if(!book.isAllowed()) { //本来就是隐藏的
			mav.addObject("isAllowed","请勿重复隐藏");
		}else {
			book.setAllowed(false);
			bookservice.updateIsAllowed(book); //隐藏
			mav.addObject("isAllowed","隐藏此图书成功");
		}
		
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffSeeBooks");
		return mav;
	}
	
	//工作人员搜索图书界面
	@RequestMapping("/staffSearchBooksResult")
	public String staffSearchBooksResult(HttpServletRequest request) {
		return "staffSearchBooksResult";
	}
	//处理工作人员搜索图书
	@RequestMapping(params = "method=searchBook")
	public ModelAndView searchBook(ModelAndView mav, HttpServletRequest request){
		String searchType = request.getParameter("searchType");
        String searchQuery = request.getParameter("searchQuery");

        List<Book> books = searchBooks(searchType, searchQuery); //查找结果
		if(books.isEmpty()) {
			mav.addObject("NotFound","无结果");
			request.getSession().setAttribute("bookResult", books);	//更新要展示的列表
		}else {
			User staff = (User) request.getSession().getAttribute("staff");
		    //String unit = staff.getWhichUnit();

		    List<Book> finalBooks = new ArrayList<>(); // 创建新的列表存储符合条件的书籍
		    for(Book book : books) {
//		        if(book.getWhichUnit().equals(unit)) {
//		        	finalBooks.add(book); // 只添加当前单位的书籍
//		        }
		    }
		    request.getSession().setAttribute("bookResult", finalBooks); //更新要展示的列表
		}

		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffSearchBooksResult");
		return mav;
	}
	private List<Book> searchBooks(String searchType, String searchQuery) {
		List<Book> result = new ArrayList<>();

		switch (searchType) {
            case "bookName":
                result = bookservice.LikeSelectBookByBookName(searchQuery);
                break;
            case "bookId": 
            	result = bookservice.LikeSelectBookById(searchQuery);
                break;
            case "author":
                result = bookservice.LikeSelectBookByauthorName(searchQuery);
                break;
            case "press":
                result = bookservice.LikeSelectBookByPress(searchQuery);
                break;
        }
        return result;
    }
	
	
}
