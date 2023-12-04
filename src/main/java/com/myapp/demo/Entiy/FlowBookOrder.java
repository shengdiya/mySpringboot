package com.myapp.demo.Entiy;

import java.sql.Date;

public class FlowBookOrder {
	private Integer flowId; //订单Id
	private Integer bookId; //图书Id
	private Integer userId; //用户Id
	private String whichUnit; //借书人属于哪个单位
	private Date outTime; //借出时间
	private Date returnTime; //归还时间
	private String reason; //借书原因
	private String realName; //申请人姓名
	private String telephone; //联系方式
	private String detail; //备注
	private String status; //订单状态（待审核、已审核、已修改）
	public Integer getFlowId() {
		return flowId;
	}
	public void setFlowId(Integer flowId) {
		this.flowId = flowId;
	}
	public Integer getBookId() {
		return bookId;
	}
	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}
	public String getWhichUnit() {
		return whichUnit;
	}
	public void setWhichUnit(String whichUnit) {
		this.whichUnit = whichUnit;
	}
	public Date getOutTime() {
		return outTime;
	}
	public void setOutTime(Date outTime) {
		this.outTime = outTime;
	}
	public Date getReturnTime() {
		return returnTime;
	}
	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	
}
