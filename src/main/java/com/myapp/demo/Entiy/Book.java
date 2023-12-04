package com.myapp.demo.Entiy;

import java.sql.Date;

public class Book {
    private Integer bookId; //图书ID
    private String bookName; //书名
    private Date outTime;//出版时间
    private String authorName; //作者姓名
    private String press; //出版社
    private Integer pageNumber; //页数
    private float price; //价格
    private String picturePath;//图片路径
    private String type; //图书类别
    private Integer left;//剩余数量
    private String whichUnit;//所属单位
    private boolean isAllowed;//是否可被借阅
    private String nowWhere; //现在在哪个单位
    private boolean isflowed;//是否处于流出状态
    
    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public Date getOutTime() {
        return outTime;
    }

    public void setOutTime(Date outTime) {
        this.outTime = outTime;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(Integer pageNumber) {
        this.pageNumber = pageNumber;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(String picturePath) {
        this.picturePath = picturePath;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getLeft() {
		return left;
	}

	public void setLeft(Integer left) {
		this.left = left;
	}

	public String getWhichUnit() {
		return whichUnit;
	}

	public void setWhichUnit(String whichUnit) {
		this.whichUnit = whichUnit;
	}

	public boolean isAllowed() {
		return isAllowed;
	}

	public void setAllowed(boolean isAllowed) {
		this.isAllowed = isAllowed;
	}

	public String getNowWhere() {
		return nowWhere;
	}

	public void setNowWhere(String nowWhere) {
		this.nowWhere = nowWhere;
	}

	public boolean isIsflowed() {
		return isflowed;
	}

	public void setIsflowed(boolean isflowed) {
		this.isflowed = isflowed;
	}


}
