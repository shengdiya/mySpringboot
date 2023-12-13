package com.myapp.demo.Controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myapp.demo.Service.*;
import com.myapp.demo.Tool.EmailSender;
import com.myapp.demo.Entiy.*;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource(name="userService")
	private UserService userservice;
	//登陆界面
	@RequestMapping("/login")
	public String login() {
		return "otherModel/login";
	}
	//登录处理
	@RequestMapping(params = "method=Getlogin")
    public ModelAndView Getlogin(User user, ModelAndView mav,HttpServletRequest request,HttpServletResponse response) throws UnsupportedEncodingException {
		Integer roleId = userservice.getUserRoleId(user);//根据user的角色id，决定他们进入不同的界面
		user = userservice.selectUserByuserName(user.getUserName());  //把其他信息补全
		System.out.println(roleId);

		if(user != null && roleId != 0) {
			request.getSession().setAttribute("user", user);
			//.............
			request.getSession().setAttribute("roleId", roleId);
			//...................
			mav.setViewName("admin/adminIndex");
			mav.addObject("start","plant/adminPlantList");//登陆后默认加载"adminPlantList"界面
		}
		else {
			mav.setViewName("otherModel/login");
			mav.addObject("noSuchUser","密码错误或用户不存在，请重新输入");
		}
		return mav;
    }

	//退出登录
	@RequestMapping(params = "method=LogOut")
	public ModelAndView LogOut(ModelAndView mav,HttpServletRequest request) {
		String userId = request.getParameter("userIdOnlineing");

		//退出后把他们的Session删掉，这样退出后除非在登陆，否则干不了任何事，甚至可能进不去
		String role = userservice.getUserRole(Integer.valueOf(userId));
		System.out.println("role: " + role);
		if(role.equals("管理员")) {
			request.getSession().removeAttribute("admin");
		}else if(role.equals("养护人员")) {
			request.getSession().removeAttribute("conserver");
		}else if(role.equals("监测人员")){
			request.getSession().removeAttribute("monitor");
		}else{
			request.getSession().removeAttribute("boss");
		}
		mav.setViewName("otherModel/login");
		return mav;
	}
	
	//忘记密码第一个界面
	@RequestMapping("/forgetPassword1")
	public String forgetPassword1() {
	    return "otherModel/forgetPassword1";
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
					mav.setViewName("otherModel/forgetPassword2"); //发送成功后跳转到forgetPassword2界面输入验证码
				} catch (MessagingException e) { //没发送成功跳回forgetPassword1，并用弹窗提示
					 mav.setViewName("otherModel/forgetPassword1");
				     mav.addObject("emailError","发送邮箱验证码失败，请重试");
				     e.printStackTrace();
				}		
			}else { //用户名和邮箱不匹配
				mav.setViewName("otherModel/forgetPassword1");
				mav.addObject("userNotEmail","用户名和邮箱不匹配");
			}	
		}else{ //用户不存在
			mav.setViewName("otherModel/forgetPassword1");
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
			mav.setViewName("otherModel/forgetPassword3");
		}else { //验证码错了，跳回forgetPassword2，并给出提示
			mav.setViewName("otherModel/forgetPassword2");
			mav.addObject("codeError","验证码错误");
		}
		return mav;
	}
	//忘记密码修改密码界面
	@RequestMapping(params = "method=GetforgetPassword3")
	public ModelAndView GetforgetPassword3(HttpServletRequest request, String password, ModelAndView mav) {
		User user1= (User) request.getSession().getAttribute("user");
		user1.setPassword(password);
		userservice.modifyPassword(user1); //修改密码
		mav.setViewName("otherModel/login");
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
	@RequestMapping("/adminAddUser")
	public String addUser(HttpServletRequest request) {
	    return "admin/adminAddUser";
	}
	//管理员添加一个工作人员
	@RequestMapping(params = "method=adminAddStaff")
	public ModelAndView adminAddStaff(User user,String identity,ModelAndView mav) throws IOException {
		//用户名、真实姓名、联系电话、邮箱、住址、用户身份为管理员输入
		//还要在user_role表里添加新的工作人员映射
		if(userservice.adminInsertStaff(user) != 0) {
			//添加工作人员的user_role表映射
			Integer userId = user.getUserId();//获取自增生成的userId
			if(identity.equals("conserver")){
				userservice.insertStaffRole(userId, 2);
			} else if (identity.equals("monitor")) {
				userservice.insertStaffRole(userId, 3);
			} else if (identity.equals("boss")) {
				userservice.insertStaffRole(userId, 4);
			}
			mav.addObject("addStaff","用户添加成功"); //传给前端需要弹窗的内容
		}else {
			mav.addObject("addStaff","已有此工号，添加失败"); //传给前端需要弹窗的内容
		}
		mav.setViewName("admin/adminIndex");
		mav.addObject("start","user/adminAddUser");//添加完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminAddStaff.jsp，让加完之后还留在添加用户的界面
		return mav;
	}
	
	//查看所有的养护人员
	@RequestMapping("/adminUserListConserver")
	public String adminUserListConserver(HttpServletRequest request) {
		List<User> allUsers = userservice.selectAllUsers();
		List<User> conservers = new ArrayList<>();
		for(User user : allUsers){
			if(userservice.getUserRole(user.getUserId()).equals("养护人员")){
				conservers.add(user);
			}
		}		request.setAttribute("users", conservers);
		request.setAttribute("userservice", userservice);//把userservice也传过去，在adminUserList.jsp中要用
	    return "admin/adminUserListConserver";
	}
	//查看所有的监测人员
	@RequestMapping("/adminUserListMonitor")
	public String adminUserListMonitor(HttpServletRequest request) {
		List<User> allUsers = userservice.selectAllUsers();
		List<User> monitors = new ArrayList<>();
		for(User user : allUsers){
			if(userservice.getUserRole(user.getUserId()).equals("监测人员")){
				monitors.add(user);
			}
		}
		request.setAttribute("users", monitors);
		request.setAttribute("userservice", userservice);//把userservice也传过去，在adminUserList.jsp中要用
		return "admin/adminUserListMonitor";
	}
	//查看所有主管部门人员
	@RequestMapping("/adminUserListBoss")
	public String adminUserListBoss(HttpServletRequest request) {
		List<User> allUsers = userservice.selectAllUsers();
		List<User> bosses = new ArrayList<>();
		for (User user : allUsers) {
			if (userservice.getUserRole(user.getUserId()).equals("上级主管人员")) {
				bosses.add(user);
			}
		}
		request.setAttribute("users", bosses);
		request.setAttribute("userservice", userservice);//把userservice也传过去，在adminUserList.jsp中要用
		return "admin/adminUserListBoss";
	}

	//管理员删除一个用户
	@RequestMapping(params = "method=deleteUser")
	public ModelAndView deleteUser(ModelAndView mav, HttpServletRequest request) throws IOException {
		String userId = request.getParameter("userId"); //接收要删用户的Id
		String forward = null;
		if(userservice.getUserRole(Integer.valueOf(userId)).equals("养护人员")){
			forward = "user/adminUserListConserver";
		} else if (userservice.getUserRole(Integer.valueOf(userId)).equals("监测人员")) {
			forward = "user/adminUserListMonitor";
		}else{
			forward = "user/adminUserListBoss";
		}
		try {
			userservice.deleteUser(Integer.valueOf(userId)); //删除user表里的
			userservice.deleteUserRole(Integer.valueOf(userId)); //删除user_role表里的
			mav.addObject("deleteUser","删除成功"); //传给前端需要弹窗的内容
			mav.setViewName("admin/adminIndex");
		}catch(Exception e) {
			mav.setViewName("admin/adminIndex");
			mav.addObject("deleteUser","该用户有正在执行的养护或监测任务，删除失败"); //传给前端需要弹窗的内容
		}
		mav.addObject("start",forward);//删完一个用户要再跳转到adminIndex.jsp，加载其中的内容为adminUserList.jsp，让删完之后还留在用户列表的界面
		return mav;
	}
//----------------------------------------------------------------------------------------------------------------

	//主管部门查看所有养护人员
	@RequestMapping("/bossConserverList")
	public String bossConserverList(HttpServletRequest request) {
		List<User> allUsers = userservice.selectAllUsers();
		List<User> conservers = new ArrayList<>();
		for(User user : allUsers){
			if(userservice.getUserRole(user.getUserId()).equals("养护人员")){
				conservers.add(user);
			}
		}
		request.setAttribute("conservers", conservers);
		return "boss/bossConserverList";
	}

	//主管人员查看监测人员
	@RequestMapping("/bossMonitorList")
	public String bossMonitorList(HttpServletRequest request) {
		List<User> allUsers = userservice.selectAllUsers();
		List<User> monitors = new ArrayList<>();
		for(User user : allUsers){
			if(userservice.getUserRole(user.getUserId()).equals("监测人员")){
				monitors.add(user);
			}
		}
		request.setAttribute("monitors", monitors);
		return "boss/bossMonitorList";
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

