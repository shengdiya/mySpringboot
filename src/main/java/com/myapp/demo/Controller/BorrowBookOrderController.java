package com.myapp.demo.Controller;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.myapp.demo.Service.*;
import com.myapp.demo.Tool.EmailSender;
import com.myapp.demo.Entiy.*;

@Controller
@RequestMapping("/book")
public class BorrowBookOrderController {
	@Resource(name="borrowBookOrderService")	
	private BorrowBookOrderService borrowBookOrderService;
	
	@Resource(name="bookService")
	private BookService bookservice;
	
	@Resource(name="userService")
	private UserService userservice;
	
	
	//读者查看图书列表（借阅）界面
	@RequestMapping("/readerBorrowBooks")
	public String readerBorrowBooks(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		List<Book> booksAllowed = borrowBookOrderService.selectAllBooksAllowed();
		request.setAttribute("booksAllowed", booksAllowed);
		return "readerBorrowBooks";
	}
	//读者查看图书详细信息界面
	@RequestMapping("/readerSeeBookDetails")
	public String readerSeeBookDetails(@RequestParam("bookId") int bookId, HttpServletRequest request) {
		Book book = bookservice.selectBookById(bookId); //获得是要看哪本书
		request.setAttribute("book", book);
		return "readerSeeBookDetails";
	}
	//读者借阅NEXT界面
	@RequestMapping("/readerBorrowNext")
	public String readerBorrowNext(@RequestParam("bookId") int bookId,HttpServletRequest request){
		Book book = bookservice.selectBookById(bookId); //获得是要借哪本书
		request.setAttribute("book", book);
		return "readerBorrowNext";
	}
	//处理读者借阅请求
	@RequestMapping(params = "method=GetBorrowBooks")
	public ModelAndView GetBorrowBooks(BorrowBookOrder borrowBookOrder, ModelAndView mav, HttpServletRequest request) {
		Integer bookId = borrowBookOrder.getBookId();
		Integer userId = borrowBookOrder.getUserId();
		Book book = bookservice.selectBookById(bookId);
		if(!borrowBookOrderService.isBorrowByYourself(userId,bookId,"待审核") && !borrowBookOrderService.isBorrowByYourself(userId,bookId,"已借出")) { //说明之前没借过这本书
			if(book.getLeft() > 0) { //书籍还有剩余
				borrowBookOrder.setStatus("待审核"); //设置为状态为审核中
				//备注和原因没填就设成“无”
				if(borrowBookOrder.getDetail()==null || borrowBookOrder.getDetail().equals("")) {
					borrowBookOrder.setDetail("无");
				}
				if(borrowBookOrder.getReason()==null || borrowBookOrder.getReason().equals("")) {
					borrowBookOrder.setReason("无");
				}
				borrowBookOrderService.insertOneBorrowOrder(borrowBookOrder); //就添加则条借阅订单
				//次数是提交到工作人员审核，因此还不能将left设为0
				//borrowBookOrder.setReturned(false);//刚借肯定设置没还
				mav.addObject("borrowStatus","借阅成功，请等待工作人员审核");
			}else{ //没剩了，被别人借走了
				mav.addObject("borrowStatus","该书籍已被他人借用");
			}
		}else { //这本书之间就是你借的
			mav.addObject("borrowStatus","该书已被您所借");
		}
		mav.setViewName("readerIndex");
		mav.addObject("readerStart","book/readerBorrowBooks");
		
		return mav;
	}
	
	//读者回到借阅界面（点击"返回"）
	@RequestMapping(params = "method=raederReturnBookList")
	public ModelAndView raederReturnBookList(ModelAndView mav) {
		mav.setViewName("readerIndex");
		mav.addObject("readerStart","book/readerBorrowBooks");
		return mav;
	}
	
	//读者还书界面（readerReturnBooks.jsp）
	@RequestMapping("/readerReturnBooks")
	public String readerReturnBooks(HttpServletRequest request) {
		//把服务者传到前端，在前端找出来列表
		request.setAttribute("borrowBookOrderService", borrowBookOrderService); 
		request.setAttribute("bookservice", bookservice); 
		return "readerReturnBooks";
	}
	//读者还书
	@RequestMapping(params = "method=GetReturnBooks")
	public ModelAndView GetReturnBooks(HttpServletRequest request,ModelAndView mav) {
		String bookId = request.getParameter("bookId");
		String BorrowId = request.getParameter("BorrowId");
		Book book = bookservice.selectBookById(Integer.valueOf(bookId));
		BorrowBookOrder borrowBookOrder = borrowBookOrderService.selectOrderByOrderId(Integer.valueOf(BorrowId));
		
		book.setLeft(1); //还完了把数量加回来
		bookservice.leftChange(book); //数据库同步更新
		borrowBookOrder.setStatus("已结束"); //还完了就结束
		borrowBookOrderService.statusChange(borrowBookOrder); //数据库同步更新
		
		mav.setViewName("readerIndex");
		mav.addObject("returnBook","图书已归还");
		mav.addObject("readerStart","/book/readerReturnBooks");
		
		return mav;
	}
	//读者查看自己的订单
	@RequestMapping("/readerSeeOrders")
	public String readerSeeOrders(HttpServletRequest request){	
		//把服务者传到前端，在前端找出来列表
		request.setAttribute("borrowBookOrderService", borrowBookOrderService); 
		request.setAttribute("bookservice", bookservice); 
		return "readerSeeOrders";
	}
	
	
	
	//工作人员4个超链接的界面
	@RequestMapping("/staffBookCirculation")
	public String staffBookCirculation(){	
		return "staffBookCirculation";
	}
	
	//工作人员管理借阅界面
	@RequestMapping("/staffBookBorrowing")
	public String staffBookBorrowing(){	
		return "staffBookBorrowing";
	}
	//工作人员从借阅管理回到主界面satffIndex（点击“返回”）
	@RequestMapping(params = "method=goBackToStaffIndex")
	public ModelAndView goBackToStaffIndex(ModelAndView mav) {
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffBookCirculation");
		return mav;
	}
	
//	//工作人员查看审核中的图书界面
//	@RequestMapping("/staffBookBorrowingWating")
//	public String staffBookBorrowingWating(HttpServletRequest request){
//		User staff = (User) request.getSession().getAttribute("staff");
//		List<BorrowBookOrder> borrowBookOrders = borrowBookOrderService.selectOrderByUnitAndStatus(staff.getWhichUnit(), "待审核");
//		request.setAttribute("bookservice", bookservice);
//		request.setAttribute("borrowBookOrdersPending", borrowBookOrders);
//		return "staffBookBorrowingWating";
//	}
	//工作人员在借阅待审核界面点击“同意”
	@RequestMapping(params = "method=agreeBorrowing")
	public ModelAndView agreeBorrowing(HttpServletRequest request,ModelAndView mav) {
		String BorrowId = request.getParameter("BorrowId");
		BorrowBookOrder order = borrowBookOrderService.selectOrderByOrderId(Integer.valueOf(BorrowId));
		Book book = bookservice.selectBookById(order.getBookId()); //知道是哪本书了
		if(book.getLeft() > 0) {
			book.setLeft(0); //把这本书的剩余设为0，因为本来最多就1本
			bookservice.leftChange(book); //数据库同步更新
			
			order.setStatus("已借出"); //把订单状态设为已借出
			borrowBookOrderService.statusChange(order); //数据库同步更新
			mav.addObject("borrowing","已同意借出");
		}else {
			mav.addObject("borrowing","此图书已出借，不能同意");
		}

		mav.setViewName("staffBookBorrowing");
		mav.addObject("staffStart","/book/staffBookBorrowingWating");
		return mav;
	}
	//工作人员在借阅待审核界面点击“拒绝”
	@RequestMapping(params = "method=refuseBorrowing")
	public ModelAndView refuseBorrowing(HttpServletRequest request,ModelAndView mav) {
		String BorrowId = request.getParameter("BorrowId");
		BorrowBookOrder order = borrowBookOrderService.selectOrderByOrderId(Integer.valueOf(BorrowId));
		
		order.setStatus("已拒绝"); //把订单状态设为已拒绝
		borrowBookOrderService.statusChange(order); //数据库同步更新
		
		mav.addObject("borrowing","已拒绝借出");
		mav.setViewName("staffBookBorrowing");
		mav.addObject("staffStart","/book/staffBookBorrowingWating");
		return mav;
	}
	
//	//工作人员查看已借出的图书界面
//	@RequestMapping("/staffBookBorrowingReviewed")
//	public String staffBookBorrowingReviewed(HttpServletRequest request){
//		User staff = (User) request.getSession().getAttribute("staff");
//		List<BorrowBookOrder> borrowBookOrders = borrowBookOrderService.selectOrderByUnitAndStatus(staff.getWhichUnit(), "已借出");
//		request.setAttribute("bookservice", bookservice);
//		request.setAttribute("staffBookBorrowingReviewed", borrowBookOrders);
//		return "staffBookBorrowingReviewed";
//	}
	
	//工作人员查看已结束和已拒绝的图书界面
//	@RequestMapping("/staffBookBorrowingFinished")
//	public String staffBookBorrowingFinished(HttpServletRequest request){
//		//把已结束和已拒绝的都找出来，然后拼在一起
//		User staff = (User) request.getSession().getAttribute("staff");
//		List<BorrowBookOrder> borrowBookOrders1 = borrowBookOrderService.selectOrderByUnitAndStatus(staff.getWhichUnit(),"已结束");
//		List<BorrowBookOrder> borrowBookOrders2 = borrowBookOrderService.selectOrderByUnitAndStatus(staff.getWhichUnit(),"已拒绝");
//		List<BorrowBookOrder> borrowBookOrders = new ArrayList<>(borrowBookOrders1);
//		borrowBookOrders.addAll(borrowBookOrders2);
//		request.setAttribute("bookservice", bookservice);
//		request.setAttribute("staffBookBorrowingFinished", borrowBookOrders);
//		return "staffBookBorrowingFinished";
//	}
}
