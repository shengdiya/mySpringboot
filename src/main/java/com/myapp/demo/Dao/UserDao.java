package com.myapp.demo.Dao;

import java.util.List;



import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.myapp.demo.Entiy.User;

@Repository("userDao")
@Mapper
public interface UserDao {
	public Integer selectUserId(@Param("userName")String userName,@Param("password")String password);
	public User selectUserById(Integer userId);
	public User selectUserByuserName(String userName);
	public Integer selectRoleByuserId(Integer userId);
	public Integer adminInsertStaff(User user);
	public Integer insertStaffRole(Integer userId,Integer roleId);
	public List<User> selectAllUsers();
	public String selectRoleById(Integer roleId);
	public Integer deleteUser(Integer userId);
	public Integer deleteUserRole(Integer userId);
	public Integer adminModifyDetailsById(User user);
	public Integer modifyPassword(User user);
	public Integer insertRaeder(User user);
	public Integer insertReaderRole(Integer userId,Integer roleId);
	public List<User> selectAllusersInOneRole(Integer roleId);
	public Integer modifyloginTimeAndStatus(User user);
	public Integer modifyStatus(User user);
}
