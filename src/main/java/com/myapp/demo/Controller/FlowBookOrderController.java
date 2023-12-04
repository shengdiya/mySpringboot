package com.myapp.demo.Controller;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myapp.demo.Entiy.Book;
import com.myapp.demo.Entiy.FlowBookOrder;
import com.myapp.demo.Entiy.User;
import com.myapp.demo.Service.BookService;
import com.myapp.demo.Service.BorrowBookOrderService;
import com.myapp.demo.Service.FlowBookOrderService;
import com.myapp.demo.Service.UserService;

@Controller
@RequestMapping("/book")
public class FlowBookOrderController {
	@Resource(name="borrowBookOrderService")	
	private BorrowBookOrderService borrowBookOrderService;
	@Resource(name="bookService")
	private BookService bookservice;
	@Resource(name="userService")
	private UserService userservice;
	@Resource(name="flowBookOrderService")
	private FlowBookOrderService flowBookOrderService;
	
	//工作人员查看别的单位图书列表界面
	@RequestMapping("/staffSeeBooksInOtherUnits")
	public String staffSeeBooksInOtherUnits(HttpServletRequest request){
		User staff = (User) request.getSession().getAttribute("staff");
		List<Book> booksAllowed = borrowBookOrderService.selectAllBooksAllowed();
		List<Book> booksToKeep = new ArrayList<>(); //临时列表，用来存储应该留下的图书
		for (Book book : booksAllowed) {
		    if (!book.getWhichUnit().equals(staff.getWhichUnit())) {
		        booksToKeep.add(book);
		    }
		}
		booksAllowed = booksToKeep; // 重新赋值给原列表
		request.setAttribute("booksAllowed", booksAllowed);
		return "staffSeeBooksInOtherUnits";
	}
	
	//工作人员查看其他单位图书详细信息
	@RequestMapping("/staffSeeBookInOtherUnitsDetails")
	public String staffSeeBookInOtherUnitsDetails(HttpServletRequest request, @RequestParam("bookId") int bookId) {
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);	
		return "staffSeeBookInOtherUnitsDetails";
	}
	//工作人员发起请求界面
	@RequestMapping("/staffRequestNext")
	public String staffRequestNext(HttpServletRequest request, @RequestParam("bookId") int bookId) {
		Book book = bookservice.selectBookById(bookId);
		request.setAttribute("book", book);	
		return "staffRequestNext";
	}
	
	//处理工作人员的请求流入
	@RequestMapping(params = "method=StaffRequestBook")
	public ModelAndView refuseBorrowing(FlowBookOrder flowBookOrder,HttpServletRequest request,ModelAndView mav) {
		Integer bookId = flowBookOrder.getBookId();
		String whichUnit = flowBookOrder.getWhichUnit();
		Book book = bookservice.selectBookById(bookId);
		if(!flowBookOrderService.isRequested(whichUnit,bookId,"待审核") && !flowBookOrderService.isRequested(whichUnit,bookId,"已流出")) { //判断该单位是否已经请求过流通这本书
			if(!book.isIsflowed()) { //还没流出，则可以申请
				flowBookOrder.setStatus("待审核");
				//备注和原因没填就设成“无”
				if(flowBookOrder.getDetail()==null || flowBookOrder.getDetail().equals("")) {
					flowBookOrder.setDetail("无");
				}
				if(flowBookOrder.getReason()==null || flowBookOrder.getReason().equals("")) {
					flowBookOrder.setReason("无");
				}
				flowBookOrderService.insertOneRequestOrder(flowBookOrder); //就添加则条借阅订单
				//book.setIsflowed(true);
				//bookservice.updateIsflowed(book);
				mav.addObject("RequestStatus","请求成功，请等待对方审核");
			}else { //被别的单位流走了
				mav.addObject("RequestStatus","该书籍已被其他单位请求成功");
			}
		}else { //之前请求过，而且没还或者在审核中
			mav.addObject("RequestStatus","您的单位已请求过此书");
		}
		
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffBookCirculation");
		return mav;
	}
	
	//返回其他单位图书列表
	@RequestMapping(params = "method=staffReturnBookInOtherUnitList")
	public String staffReturnBookInOtherUnitList(HttpServletRequest request) {
		return staffSeeBooksInOtherUnits(request);
	}
	
	//工作人员查看自己单位的订单界面
	@RequestMapping("/staffSeeOwnflowOrder")
	public String staffSeeOwnflowOrder(){	
		return "staffSeeOwnflowOrder";
	}
	
	//工作人员查看自己单位“审核中”订单
	@RequestMapping("/staffSeeOwnflowOrderWating")
	public String staffSeeOwnflowOrderWating(HttpServletRequest request){	
		request.setAttribute("flowBookOrderService", flowBookOrderService); 
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOwnflowOrderWating";
	}
	
	//工作人员查看自己单位“已审核”订单
	@RequestMapping("/staffSeeOwnflowOrderReviewed")
	public String staffSeeOwnflowOrderReviewed(HttpServletRequest request){	
		request.setAttribute("flowBookOrderService", flowBookOrderService); 
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOwnflowOrderReviewed";
	}
	//工作人员还书
	@RequestMapping(params = "method=GetStaffReturnBook")
	public ModelAndView GetReturnBooks(HttpServletRequest request,ModelAndView mav) {
		String bookId = request.getParameter("bookId");
		String flowId = request.getParameter("flowId");
		Book book = bookservice.selectBookById(Integer.valueOf(bookId));
		FlowBookOrder flowBookOrder = flowBookOrderService.selectOrderByflowId(Integer.valueOf(flowId));
		
		book.setIsflowed(false); //还完了把是否流出设为false
		book.setNowWhere(book.getWhichUnit()); //还了之后把所在地还原
		bookservice.updateIsflowed(book); //数据库同步更新
		flowBookOrder.setStatus("已结束"); //还完了就结束
		flowBookOrderService.flowStatusChange(flowBookOrder); //数据库同步更新
		
		mav.setViewName("staffSeeOwnflowOrder");
		mav.addObject("flowReturnBook","图书已归还");		
		return mav;
	}
	
	//工作人员查看自己单位“已结束”订单
	@RequestMapping("/staffSeeOwnflowOrderFinished")
	public String staffSeeOwnflowOrderFinished(HttpServletRequest request){	
		request.setAttribute("flowBookOrderService", flowBookOrderService); 
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOwnflowOrderFinished";
	}
	
	//工作人员看其他单位发起的订单界面
	@RequestMapping("/staffSeeOtherUnitflowOrder")
	public String staffSeeOtherUnitflowOrder(HttpServletRequest request){	
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOtherUnitflowOrder";
	}
	
	//工作人员查看其他单位发起的“审核中”订单
	@RequestMapping("/staffSeeOtherUnitflowOrderWating")
	public String staffSeeOtherUnitflowOrderWating(HttpServletRequest request){	
		User staff = (User) request.getSession().getAttribute("staff");
		List<FlowBookOrder> ordersFromOtherUnits = flowBookOrderService.selectOrdersFromOtherUnits(staff.getWhichUnit(),"待审核");
		request.setAttribute("ordersFromOtherUnitsWating", ordersFromOtherUnits);
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOtherUnitflowOrderWating";
	}
	
	//同意流出
	@RequestMapping(params = "method=agreeRequest")
	public ModelAndView agreeBorrowing(HttpServletRequest request,ModelAndView mav) {
		String flowId = request.getParameter("flowId");
		FlowBookOrder order = flowBookOrderService.selectOrderByflowId(Integer.valueOf(flowId));
		Book book = bookservice.selectBookById(order.getBookId()); //知道是哪本书了
		if(!book.isIsflowed()) {
			book.setIsflowed(true); //把这本书设置为已流出
			book.setNowWhere(order.getWhichUnit()); //现存地更新为流往的单位
			bookservice.updateIsflowed(book); //数据库同步更新
			
			order.setStatus("已流出"); //把订单状态设为已借出
			flowBookOrderService.flowStatusChange(order); //数据库同步更新
			mav.addObject("flowing","已同意流出");
		}else {
			mav.addObject("flowing","此图书已流出，不能同意");
		}

		mav.setViewName("staffSeeOtherUnitflowOrder");
		return mav;
	}
	
	//工作人员在借阅待审核界面点击“拒绝”
	@RequestMapping(params = "method=refuseRequest")
	public ModelAndView refuseBorrowing(HttpServletRequest request,ModelAndView mav) {
		String flowId = request.getParameter("flowId");
		FlowBookOrder order = flowBookOrderService.selectOrderByflowId(Integer.valueOf(flowId));
		
		order.setStatus("已拒绝"); //把订单状态设为已拒绝
		flowBookOrderService.flowStatusChange(order); //数据库同步更新
		
		mav.addObject("flowing","已拒绝借出");
		mav.setViewName("staffSeeOtherUnitflowOrder");
		return mav;
	}
	
	//工作人员查看其他单位发起的“已流出”订单
	@RequestMapping("/staffSeeOtherUnitflowOrderReviewed")
	public String staffSeeOtherUnitflowOrderReviewed(HttpServletRequest request){	
		User staff = (User) request.getSession().getAttribute("staff");
		List<FlowBookOrder> ordersFromOtherUnits = flowBookOrderService.selectOrdersFromOtherUnits(staff.getWhichUnit(),"已流出");
		request.setAttribute("ordersFromOtherUnitsReviewed", ordersFromOtherUnits);
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOtherUnitflowOrderReviewed";
	}
	//工作人员查看其他单位发起的“已结束”订单
	@RequestMapping("/staffSeeOtherUnitflowOrderFinished")
	public String staffSeeOtherUnitflowOrderFinished(HttpServletRequest request){	
		User staff = (User) request.getSession().getAttribute("staff");
		List<FlowBookOrder> ordersFromOtherUnits1 = flowBookOrderService.selectOrdersFromOtherUnits(staff.getWhichUnit(),"已结束");
		List<FlowBookOrder> ordersFromOtherUnits2 = flowBookOrderService.selectOrdersFromOtherUnits(staff.getWhichUnit(),"已拒绝");
		List<FlowBookOrder> ordersFromOtherUnits = new ArrayList<>(ordersFromOtherUnits1);
		ordersFromOtherUnits.addAll(ordersFromOtherUnits2);
		request.setAttribute("ordersFromOtherUnitsFinished", ordersFromOtherUnits);
		request.setAttribute("bookservice", bookservice);
		return "staffSeeOtherUnitflowOrderFinished";
	}
	
	//统计导航界面
	@RequestMapping("/staffStatistics")
	public String staffStatistics() {
		return "staffStatistics";
	}
	
	//工作人员查看统计流出的图书
	@RequestMapping("/staffStatisticsFlowOut")
	public ModelAndView staffStatisticsFlowOut(HttpServletRequest request,ModelAndView mav) {        
		 User staff = (User) request.getSession().getAttribute("staff");
		 String whichUnit = staff.getWhichUnit();

		 //获得本单位总图书数和当前在库总图书数
		 Integer booksInOwnUnit = bookservice.countAllbooksInOwnUnit(whichUnit);
		 Integer booksInNow = bookservice.countAllbooksInNow(whichUnit);
	     //获得其他统计信息 使用JSON格式传给前端
		 //三个年度
		 String Outdata2023 = String.valueOf(flowBookOrderService.countOutBooksByYears(whichUnit,2023));
		 String Outdata2022 = String.valueOf(flowBookOrderService.countOutBooksByYears(whichUnit,2022));
		 String Outdata2021 = String.valueOf(flowBookOrderService.countOutBooksByYears(whichUnit,2021));
		 String barData = "[" + Outdata2021 + "," + Outdata2022 + "," +  Outdata2023 + "]";
		 //2023年月份
		 List<Map<String, Object>> counts = flowBookOrderService.countOutBooksByMonths(whichUnit, 2023);
		 StringBuilder jsonResult = new StringBuilder("[");
		 int[] monthlyCounts = new int[12]; //存储12个月分别有几个订单的数组
         for (Map<String, Object> count : counts) {
             // 由于月份是从1开始的，所以减1得到正确的索引
             int monthIndex = (Integer) count.get("month") - 1;
             monthlyCounts[monthIndex] = ((Long) count.get("count")).intValue();
         }

         // 将整数数组转换为JSON格式的字符串
         for (int i = 0; i < monthlyCounts.length; i++) {
             jsonResult.append(monthlyCounts[i]);
             if (i < monthlyCounts.length - 1) {
                 jsonResult.append(",");
             }
         }
         jsonResult.append("]");

         String lineData = jsonResult.toString();//转换成字符串

	     mav.setViewName("staffStatisticsFlowOut");	
	     mav.addObject("booksInOwnUnit", booksInOwnUnit);
	     mav.addObject("booksInNow", booksInNow);
	     mav.addObject("barData", barData);
	     mav.addObject("lineData", lineData);

	     return mav;
    }
	
	@RequestMapping("/staffStatisticsFlowIn")
	public ModelAndView staffStatisticsFlowIn(HttpServletRequest request,ModelAndView mav) {        
		 User staff = (User) request.getSession().getAttribute("staff");
		 String whichUnit = staff.getWhichUnit();
		 //获得本单位总图书数和当前在库总图书数
		 Integer booksInOwnUnit = bookservice.countAllbooksInOwnUnit(whichUnit);
		 Integer booksInNow = bookservice.countAllbooksInNow(whichUnit);
	     //获得其他统计信息 使用JSON格式传给前端
		 //三个年度
		 String Indata2023 = String.valueOf(flowBookOrderService.countInBooksByYears(whichUnit,2023));
		 System.out.println("num: " + Indata2023);
		 String Indata2022 = String.valueOf(flowBookOrderService.countInBooksByYears(whichUnit,2022));
		 String Indata2021 = String.valueOf(flowBookOrderService.countInBooksByYears(whichUnit,2021));
		 String barData = "[" + Indata2021 + "," + Indata2022 + "," +  Indata2023 + "]";
		 //2023年月份
		 List<Map<String, Object>> counts = flowBookOrderService.countInBooksByMonths(whichUnit, 2023);
		 StringBuilder jsonResult = new StringBuilder("[");
		 int[] monthlyCounts = new int[12]; //存储12个月分别有几个订单的数组
         for (Map<String, Object> count : counts) {
            // 由于月份是从1开始的，所以减1得到正确的索引
            int monthIndex = (Integer) count.get("month") - 1;
            monthlyCounts[monthIndex] = ((Long) count.get("count")).intValue();
         }

         // 将整数数组转换为JSON格式的字符串
         for (int i = 0; i < monthlyCounts.length; i++) {
             jsonResult.append(monthlyCounts[i]);
             if (i < monthlyCounts.length - 1) {
                 jsonResult.append(",");
             }
         }
         jsonResult.append("]");

	     String lineData = jsonResult.toString();//转换成字符串

	     mav.setViewName("staffStatisticsFlowIn");	
	     mav.addObject("booksInOwnUnit", booksInOwnUnit);
	     mav.addObject("booksInNow", booksInNow);
	     mav.addObject("barData", barData);
	     mav.addObject("lineData", lineData);

	     return mav;
   }
	
	//回到初始界面（点击统计界面中的"返回"）
	@RequestMapping(params = "method=staffReturnStatistics")
	public ModelAndView staffReturnStatistics(ModelAndView mav) {
		mav.setViewName("staffIndex");
		mav.addObject("staffStart","/book/staffStatistics");
		return mav;
	}
}
