package com.myapp.demo.Controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
@RequestMapping("/user")
public class UserController {
	@Resource(name="userService")
	private UserService userservice;
	
	@Resource(name="unitService")
	private UnitService unitservice;
	
	@Resource(name="borrowBookOrderService")	
	private BorrowBookOrderService borrowBookOrderService;
	
	//登陆界面
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	//登录处理
	@RequestMapping(params = "method=Getlogin")
    public ModelAndView Getlogin(@RequestParam("role") String role, User user, ModelAndView mav,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
		Integer roleId = userservice.getUserRoleId(user);//根据user的角色id，决定他们进入不同的界面
		user = userservice.selectUserByuserName(user.getUserName());  //把其他信息补全
		//管理员
		if("admin".equals(role) && roleId==1) {
			user.setStatus("online"); //设为在线
			//更新登录时间
			Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
			user.setCreateTime(sqlDate);
			userservice.modifyloginTimeAndStatus(user); //更新登陆状态和登陆时间
			
			request.getSession().setAttribute("admin", user);
			mav.setViewName("adminIndex");
			mav.addObject("start","user/adminAddStaff");//登陆后默认加载"adminAddStaff"界面
		}
		//工作人员
		else if("staff".equals(role) && roleId==2) {
			user.setStatus("online"); //设为在线
			//更新登录时间
			Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
			user.setCreateTime(sqlDate);
			userservice.modifyloginTimeAndStatus(user); //更新登陆状态和登陆时间
			request.getSession().setAttribute("staff", user);
			mav.setViewName("staffIndex");
			mav.addObject("staffStart","book/staffBookCirculation");//登陆后默认加载"staffBookCirculation"界面
		}
		//普通用户
		else if("user".equals(role) && roleId==3) { 
			user.setStatus("online"); //设为在线
			//更新登录时间
			Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
			user.setCreateTime(sqlDate);
			userservice.modifyloginTimeAndStatus(user); //更新登陆状态和登陆时间
			request.getSession().setAttribute("reader", user); //把登陆的读者传过去（存到Session里）
			mav.setViewName("readerIndex");
			mav.addObject("readerStart","book/readerBorrowBooks");//登陆后默认加载"readerBorrowBooks"界面	
		}
		//用户不存在
		else {
			mav.setViewName("login");
			mav.addObject("noSuchUser","密码错误或用户不存在，请重新输入");
		}
		return mav;
    }

	//退出登录
	@RequestMapping(params = "method=LogOut")
	public ModelAndView LogOut(ModelAndView mav,HttpServletRequest request) {
		String userId = request.getParameter("userIdOnlineing");
		User user = userservice.selectUserById(Integer.valueOf(userId));
		
		//退出后把他们的Session删掉，这样退出后除非在登陆，否则干不了任何事，甚至可能进不去
		String role = userservice.getUserRole(Integer.valueOf(userId));
		System.out.println("role: " + role);
		if(role.equals("admin")) {
			request.getSession().removeAttribute("admin");
		}else if(role.equals("staff")) {
			request.getSession().removeAttribute("staff");
		}else {
			request.getSession().removeAttribute("reader");
		}
		
		user.setStatus("offline");
		userservice.modifyStatus(user);
		mav.setViewName("login");
		return mav;
	}
	
	//注册界面
	@RequestMapping("/register")
    public String register() {
    	return "register";
    }
	//处理注册
	@RequestMapping(params = "method=Getregister")
	public ModelAndView Getregister(HttpServletRequest request, User user, ModelAndView mav) {
		user.setRegister(true);//设置是否进行注册(肯定是)
		user.setStatus("offline");//设置登陆状态（刚注册肯定离线）
		user.setPicturePath("/imgs/reader.jpg");//设置头像
		//设置创建时间
		Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
		user.setCreateTime(sqlDate);
		//开始插入进数据库
		if(userservice.isReadNameSame(user)!=0) { //如果不重名（没返回0说明没重名）
			String subject = "用户注册"; //标题
		    String code = generateRandomCode();  //生成一个验证码
		    String emailBody = "您的验证码是: " + code; //邮件正文
		    try { 
				EmailSender.sendEmail(user.getEmail(), subject, emailBody); //发送
				request.getSession().setAttribute("code", code); // 将验证码保存到session以便后续验证
				request.getSession().setAttribute("userRegistering",user); //把这个user传给下一个界面
				mav.setViewName("register_email");//进入输入验证码的界面
			} catch (MessagingException e) { //没发送成功跳回，并用弹窗提示
				 mav.setViewName("register"); 
			     mav.addObject("RegisterEmailError","发送邮箱验证码失败，请重试");
			     e.printStackTrace();
			}						
		}else { //返回0说明重名了
			mav.setViewName("register");
			mav.addObject("registerStatus","已有这个用户名，换个名字吧");
		}
		return mav;
	}
	//验证注册验证码
	@RequestMapping(params = "method=GetRegisterEmail")
	public ModelAndView GetRegisterEmail(HttpServletRequest request, String code, ModelAndView mav) {
		String codeInEmail = (String) request.getSession().getAttribute("code");
		User user = (User) request.getSession().getAttribute("userRegistering");
		if(code.equals(codeInEmail)) { //验证码没错
			userservice.insertRaeder(user);//可以插入了
			userservice.insertReaderRole(user.getUserId(),3); 
			mav.setViewName("login");
			mav.addObject("registerSuccess","注册成功，现在可以登陆啦！");
		}else { //验证码错了，跳回register_email，并给出提示
			mav.setViewName("register_email"); 
			mav.addObject("RegisterCodeError","验证码错误");
		}
		return mav;
	}
	
	//忘记密码第一个界面
	@RequestMapping("/forgetPassword1")
	public String forgetPassword1() {
	    return "forgetPassword1";
	}
	//验证用户名和邮箱是否匹配，并发送验证码
	@RequestMapping(params = "method=GetforgetPassword1")
	public ModelAndView GetforgetPassword1(HttpServletRequest request, String userName, String email, ModelAndView mav) {
		User user = userservice.selectUserByuserName(userName);
		if(user!=null) { //用户存在
			if(email.equals(user.getEmail())) { //用户名和邮箱匹配
				String subject = "重置密码"; //标题
			    String code = generateRandomCode();  //生成一个验证码
			    String emailBody = "您的验证码是: " + code; //邮件正文
			    try { 
					EmailSender.sendEmail(user.getEmail(), subject, emailBody); //发送
					request.getSession().setAttribute("code", code); // 将验证码保存到session以便后续验证
					request.getSession().setAttribute("user", user); // 把用户也保存到 session，让系统知道这是哪个用户在改密码
					mav.setViewName("forgetPassword2"); //发送成功后跳转到forgetPassword2界面输入验证码
				} catch (MessagingException e) { //没发送成功跳回forgetPassword1，并用弹窗提示
					 mav.setViewName("forgetPassword1"); 
				     mav.addObject("emailError","发送邮箱验证码失败，请重试");
				     e.printStackTrace();
				}		
			}else { //用户名和邮箱不匹配
				mav.setViewName("forgetPassword1");
				mav.addObject("userNotEmail","用户名和邮箱不匹配");
			}	
		}else{ //用户不存在
			mav.setViewName("forgetPassword1");
			mav.addObject("noSuchUser","用户不存在");
		}
	    return mav;
	}
	//生成一个6位数字验证码
	private String generateRandomCode() {
		Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
	}
	//邮箱验证码界面，验证输入的验证码和系统发送的是否一致
	@RequestMapping(params = "method=GetforgetPassword2")
	public ModelAndView GetforgetPassword2(HttpServletRequest request, String code, ModelAndView mav) {
		String codeInEmail = (String) request.getSession().getAttribute("code");
		if(code.equals(codeInEmail)) { //验证码没错，进入下一个界面修改密码
			mav.setViewName("forgetPassword3");
		}else { //验证码错了，跳回forgetPassword2，并给出提示
			mav.setViewName("forgetPassword2"); 
			mav.addObject("codeError","验证码错误");
		}
		return mav;
	}
	//忘记密码修改密码界面
	@RequestMapping(params = "method=GetforgetPassword3")
	public ModelAndView GetforgetPassword3(HttpServletRequest request, String password, ModelAndView mav) {
		User user = (User) request.getSession().getAttribute("user");
		user.setPassword(password);
		//System.out.println("password: " + user.getPassword());
		userservice.modifyPassword(user); //修改密码
		mav.setViewName("login");
		mav.addObject("modifyPasswordSeccuss", "重置密码成功，可以登录");
		return mav;
	}
	//管理员详细信息
	@RequestMapping("/adminDetails")
	public String adminDetails(HttpServletRequest request, HttpServletResponse response) {
		User user = userservice.selectUserById(1);
		request.setAttribute("user", user);
	    return "adminDetails";
	}
		
	//管理员添加工作人员
	@RequestMapping("/adminAddStaff")
	public String addUser(HttpServletRequest request) {
		List<Unit> units = unitservice.selectAllUnits();
		request.setAttribute("units", units);
	    return "adminAddStaff";
	}
	//管理员添加一个工作人员
	@RequestMapping(params = "method=adminAddStaff")
	public ModelAndView adminAddStaff(User user,ModelAndView mav) throws IOException {
		//用户名、性别、真实姓名、联系电话、邮箱、住址、所属单位为管理员输入
		//用户Id自动生成，其余的工号（与用户名一致）、创建时间、是否注册（肯定是注册了的）、密码（用户名后四位）需要在此处手动set。
		//还要在user_role表里添加新的工作人员映射
		if(unitservice.selectUnitByUnitName(user.getWhichUnit())==null) { //发现填的单位还没有入库
			mav.addObject("addStaff","改单位尚未入库，请先添加单位"); //传给前端需要弹窗的内容
		}else {
			String userName = user.getUserName();
			String password = userName.substring(userName.length() - 4); // 用户名后4位为密码
			user.setPicturePath("/imgs/staff.jpg");
			user.setPassword(password);//设置密码
			user.setNumber(userName);//设置工号
			user.setRegister(true);//设置是否进行注册
			user.setStatus("offline");//设置登陆状态
			//设置创建时间
			Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
			user.setCreateTime(sqlDate);
			//开始添加
			if(userservice.adminInsertStaff(user)!=0) {
				//添加工作人员的user_role表映射
				Integer userId = user.getUserId();//获取自增生成的userId
				userservice.insertStaffRole(userId, 2);		
				mav.addObject("addStaff","用户添加成功"); //传给前端需要弹窗的内容
			}else {
				mav.addObject("addStaff","已有此工号，添加失败"); //传给前端需要弹窗的内容
			}
		}
		mav.setViewName("adminIndex");
		mav.addObject("start","user/adminAddStaff");//添加完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminAddStaff.jsp，让加完之后还留在添加用户的界面
		return mav;
	}
	
	//管理员查看所有的用户
	@RequestMapping("/adminUserList")
	public String userList(HttpServletRequest request, HttpServletResponse response) {
		List<User> users = userservice.selectAllUsers();
		request.setAttribute("users", users);
		request.setAttribute("userservice", userservice);//把userservice也传过去，在adminUserList.jsp中要用
	    return "adminUserList";
	}
	//点击查看用户的详细信息
	@RequestMapping("/adminSeeDetails")
	public String adminSeeDetails(@RequestParam("userId") int userId, HttpServletRequest request) {
		//@RequestParam注解用于获取名为 userId 的请求参数。这个参数对应于超链接中传递的用户ID(adminUserList.jsp传过来的)。
		//根据Id得到User对象后，用request的setAttribute方法传给前端adminSeeDetails.jsp
		//adminSeeDetails.jsp再用request的getAttribute方法得到这个User对象
		User user = userservice.selectUserById(userId);
		request.setAttribute("user", user);
		request.setAttribute("userservice", userservice);
		return "adminSeeDetails";
	}
	//回到UserList界面（点击adminSeeDetails.jsp中的"返回"）
	@RequestMapping(params = "method=returnUserList") 
	public ModelAndView returnUserList(ModelAndView mav) {
		mav.setViewName("adminIndex");
		mav.addObject("start","user/adminUserList");
		return mav;
	}
	
	//管理员修改用户信息界面
	@RequestMapping("/adminModifyDetails")
	public String adminModifyDetails(@RequestParam("userId") int userId, HttpServletRequest request) {
		//@RequestParam注解用于获取名为 userId 的请求参数。这个参数对应于超链接中传递的用户ID。
		//根据Id得到User对象后，用request的setAttribute方法传给前端adminSeeDetails.jsp
		//adminModifyDetails.jsp再用request的getAttribute方法得到这个User对象
		User user = userservice.selectUserById(userId);
		request.setAttribute("user", user);
		request.setAttribute("userservice", userservice);
		return "adminModifyDetails";
	}
	//管理员修改用户信息,并返回adminIndex.jsp 
	@RequestMapping(params = "method=ModifyUserDetails")
	public ModelAndView ModifyUserDetails(@ModelAttribute("user") User user, ModelAndView mav) {
		try {
			System.out.println("ModifyUserDetails:userId: " + user.getUserId());
			userservice.adminModifyDetailsById(user);
			mav.setViewName("adminIndex");
			mav.addObject("modifyUser","修改用户信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("modifyUser","修改用户信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start","user/adminUserList");
		return mav;
	}
	//管理员删除一个用户
	@RequestMapping(params = "method=deleteUser")
	public ModelAndView deleteUser(ModelAndView mav, HttpServletRequest request) throws IOException {
		try {	
			String userId = request.getParameter("userId"); //接收要删用户的Id
			if(borrowBookOrderService.selectOrderByUserIdAndStatus(Integer.valueOf(userId),"待审核").isEmpty() 
					&& borrowBookOrderService.selectOrderByUserIdAndStatus(Integer.valueOf(userId),"已借出").isEmpty()) { //该用户有没有没还的书
				userservice.deleteUser(Integer.valueOf(userId)); //删除user表里的
				userservice.deleteUserRole(Integer.valueOf(userId)); //删除user_role表里的
				mav.addObject("deleteUser","删除成功"); //传给前端需要弹窗的内容
			}else {
				mav.addObject("deleteUser","该用户有尚未完成的借阅订单，删除失败"); //传给前端需要弹窗的内容
			}
			mav.setViewName("adminIndex");
			
		}catch(Exception e) {
			mav.setViewName("adminIndex");
			mav.addObject("deleteUser","删除失败"); //传给前端需要弹窗的内容
		}	
		mav.addObject("start","user/adminUserList");//删完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminUserList.jsp，让删完之后还留在用户列表的界面
		return mav;
	}
	
	//回到adminIndex界面（点击"返回"）
	@RequestMapping(params = "method=returnAdminIndex")
	public ModelAndView returnAdminIndex(ModelAndView mav) {
		mav.setViewName("adminIndex");
		mav.addObject("start","user/adminUserList");
		return mav;
	}
	
	//工作人员详细界面
	@RequestMapping("/staffDetails")
	public String staffDetails() {
	    return "staffDetails";
	}
	//工作人员修改个人信息
	@RequestMapping(params = "method=ModifyStaffOwnDetails")
	public ModelAndView ModifyStaffOwnDetails(@ModelAttribute("user") User user, ModelAndView mav,HttpServletRequest request) {
		try {
			userservice.adminModifyDetailsById(user);
			//改完之后同步更新Session里的staff
			User newUser = userservice.selectUserById(user.getUserId());
			request.getSession().setAttribute("staff", newUser);
			
			mav.setViewName("staffIndex");
			mav.addObject("modifySelf","修改个人信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("staffIndex");
			mav.addObject("modifySelf","修改个人信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("staffStart","/book/staffBookCirculation");
		return mav;
	}
	
	//读者信息详细界面
	@RequestMapping("/readerDetails")
	public String readerDetails() {
	    return "readerDetails";
	}
	//读者修改个人信息
	@RequestMapping(params = "method=ModifyReaderOwnDetails")
	public ModelAndView ModifyReaderOwnDetails(@ModelAttribute("user") User user, ModelAndView mav,HttpServletRequest request) {
		try {
			userservice.adminModifyDetailsById(user);
			//改完之后同步更新Session里的reader
			User newUser = userservice.selectUserById(user.getUserId());
			request.getSession().setAttribute("reader", newUser);

			mav.setViewName("readerIndex");
			mav.addObject("modifySelf","修改个人信息成功"); //传给前端需要弹窗的内容
		}catch(Exception e) {
			mav.setViewName("readerIndex");
			mav.addObject("modifySelf","修改个人信息失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("readerStart","/book/readerBorrowBooks");
		return mav;
	}
	
}

