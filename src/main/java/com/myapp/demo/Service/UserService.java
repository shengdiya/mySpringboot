package com.myapp.demo.Service;

import java.util.List;



import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.myapp.demo.Dao.UserDao;
import com.myapp.demo.Entiy.User;

@Service("userService")
public class UserService {
	@Resource(name="userDao")
	
	private UserDao userdao;
	
	public UserService() {}
	
	//用于通过用户的用户名和密码找出用户Id，进而判断用户的身份，返回roleId
	public Integer getUserRoleId(User user) {
		Integer userId = userdao.selectUserId(user.getUserName(), user.getPassword());
		//没找到这个用户id，就返回一个不存在的角色id->"0"
		if(userId==null){ return 0; }
		Integer userRoleId = userdao.selectRoleByuserId(userId);
		return userRoleId;
	}
	//通过roleId查找角色名
	public String getUserRole(Integer userId) {
		Integer roleId = userdao.selectRoleByuserId(userId);
		String roleEng =  userdao.selectRoleById(roleId);
		String roleChinese = null;
        switch (roleEng) {
            case "conserver":
                roleChinese = "养护人员";
                break;
            case "monitor":
                roleChinese = "监测人员";
                break;
            case "boss":
                roleChinese = "上级主管人员";
                break;
			case "admin":
				roleChinese = "管理员";
				break;
        }
		return roleChinese;
	}
	
	//通过用户名userName查找用户
	public User selectUserByuserName(String userName) {
		return userdao.selectUserByuserName(userName);
	}
		
	//通过Id查找用户
	public User selectUserById(Integer userId) {
		System.out.println("userIdInService: " + userId);
		return userdao.selectUserById(userId);
	}
	
	//管理员添加一个工作人员
	public Integer adminInsertStaff(User user) {
		List<User> users = userdao.selectAllUsers();
		for(User u : users) {
			if(u.getUserName().equals(user.getUserName())) {  //重名了
				return 0; //重名就返回0
			}
		}
		return userdao.adminInsertStaff(user);//没有重名就插入并返回（肯定不是0）
	}
	//添加工作人员的同时，在user_role表中也添加相应的映射
	public Integer insertStaffRole(Integer userId,Integer roleId) {
		return userdao.insertStaffRole(userId,roleId);
	}
	
	//判断是否重名
	public Integer isReadNameSame(User user) {
		List<User> users = userdao.selectAllusersInOneRole(3);
		for(User u : users) {
			if(u.getUserName().equals(user.getUserName())) {  //重名了
				return 0; //重名就返回0
			}
		}
		return 1; //没重名返回1
	}
	//一个用户注册
	public Integer insertRaeder(User user) {
		return userdao.insertRaeder(user);
	}
	//raeder注册后同时更新user_role表
	public Integer insertReaderRole(Integer userId,Integer roleId) {
		return userdao.insertReaderRole(userId,roleId);
	}
	
	//查找所有的用户信息（不显示管理员）
	public List<User> selectAllUsers(){
		List<User> users = userdao.selectAllUsers();
		users.remove(0);//管理员admin在表里永远是No.1，并且不会被删除，所以把第一个索引删掉就不显示管理员了
		return users;
	}
	//查找一种身份的所有用户
	public List<User> selectAllusersInOneRole(Integer roleId){
		return userdao.selectAllusersInOneRole(roleId);
	}
	
	//删除一个用户(user表)
	public Integer deleteUser(Integer userId) {
		return userdao.deleteUser(userId);
	}
	//删除用户的同时，在user_role表中也删除相应的映射
	public Integer deleteUserRole(Integer userId) {
		return userdao.deleteUserRole(userId);
	}
	
	//管理员修改用户详细信息
	public Integer adminModifyDetailsById(User user) {
		return userdao.adminModifyDetailsById(user);
	}
	//改密码
	public Integer modifyPassword(User user) {
		return userdao.modifyPassword(user);
	}
	
	//更改上次登陆时间和登录状态（上线的时候使用
	public Integer modifyloginTimeAndStatus(User user) {
		return userdao.modifyloginTimeAndStatus(user);
	}
	//单独更改登陆状态（下线的时候用，改成offline）
	public Integer modifyStatus(User user) {
		return userdao.modifyStatus(user);
	}
}
