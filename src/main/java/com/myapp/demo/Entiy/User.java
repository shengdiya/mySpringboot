package com.myapp.demo.Entiy;

import java.sql.Timestamp;

import com.myapp.demo.Dao.UserDao;

public class User {
    private Integer userId; //用户ID
    private String userName; //用户名
    private String password; //密码
    private String realName; //真实姓名
    private String telephone; //联系方式
    private String email; //邮箱
    private String address; //住址
    private String Number; //工作编号
    private boolean isRegister; //是否注册
    private Timestamp createTime; //创建时间
    private String sexy; //性别
    private String picturePath; //头像路径
    private String status; //账号状态
    private Timestamp lastTimeLogin; //上次登录时间
    private String whichUnit; //所属单位

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNumber() {
        return Number;
    }

    public void setNumber(String number) {
        Number = number;
    }

    public boolean isRegister() {
        return isRegister;
    }

    public void setRegister(boolean register) {
        isRegister = register;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getSexy() {
        return sexy;
    }

    public void setSexy(String sexy) {
        this.sexy = sexy;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(String picturePath) {
        this.picturePath = picturePath;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getLastTimeLogin() {
        return lastTimeLogin;
    }

    public void setLastTimeLogin(Timestamp lastTimeLogin) {
        this.lastTimeLogin = lastTimeLogin;
    }

	public String getWhichUnit() {
		return whichUnit;
	}

	public void setWhichUnit(String whichUnit) {
		this.whichUnit = whichUnit;
	}
	
}
