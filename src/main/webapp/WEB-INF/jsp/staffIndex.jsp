<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
 %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆借阅系统 - 工作人员界面</title>
    <!-- 引入Element UI样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入Vue -->
    <script src="https://unpkg.com/vue@2.6.14/dist/vue.min.js"></script>
    <!-- 引入Element UI组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!-- 引入Axios -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <!-- 自定义样式 -->
    <link rel="stylesheet" type="text/css" href="/css/rolesIndexs.css">
    <style type="text/css">
    	.user-avatar {
		    position: absolute; /* 使用绝对定位 */
		    top: 8%; /* 顶部距离设置为父容器高度的10% */
		    right: 35px; /* 右侧外边距设置为35像素 */
		    transform: translateY(-50%); /* 垂直居中调整 */
		    border-radius: 50%; /* 圆形图片 */
		    width: 40px; /* 设置图片宽度 */
		    height: 40px; /* 设置图片高度 */
		    object-fit: cover; /* 覆盖模式，保持图片比例 */
		}
    </style>

</head>
<body>
	<script>
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("addbook") != null) { %>
	                alert("${addbook}");
	            <% } else if(request.getAttribute("modifyBook") != null) { %>
	                alert("${modifyBook}");
	            <% } else if(request.getAttribute("deleteBook") != null) { %>
	                alert("${deleteBook}");
	            <% } else if(request.getAttribute("isAllowed") != null) { %>
	                alert("${isAllowed}");
	            <% } else if(request.getAttribute("RequestStatus") != null) { %>
	                alert("${RequestStatus}");
	            <% } else if(request.getAttribute("NotFound") != null) { %>
	                alert("${NotFound}");
	            <% } else if(request.getAttribute("modifySelf") != null) { %>
	                alert("${modifySelf}");
	            <% } else if(request.getAttribute("addManyBooks") != null) { %>
	                alert("${addManyBooks}");
	            <% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
	</script>
<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">图书馆借阅系统    所属单位： <%=staff.getWhichUnit() %></span>
            <a href="user/staffDetails" class="user-info">欢迎你，<%=staff.getUserName() %></a>
			<img src="<%= staff.getPicturePath() %>" alt="User Avatar" class="user-avatar" />
        </el-header>

        <el-container>
            <el-aside width="200px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                    <el-submenu index="1">
                        <template slot="title"><i class="el-icon-document"></i> 图书管理 </template>
                        <el-menu-item index="book-entry">图书入库</el-menu-item>
                        <el-menu-item index="manybook-entry">批量入库</el-menu-item>
                        <el-menu-item index="book-view">本单位图书查看（表格）</el-menu-item>
                        <el-menu-item index="bookPicture-view">本单位图书查看（缩略图）</el-menu-item>
                    </el-submenu>
                    <el-menu-item index="2">
                    	<template slot="title"><i class="el-icon-sell"></i> 图书借阅及流通  </template>
					</el-menu-item>    
                    <el-menu-item index="3">
                    	<template slot="title"><i class="el-icon-data-analysis"></i> 统计分析 </template>
					</el-menu-item>
                </el-menu>
                
                <!-- 底部按钮 -->
            	<form class="aside-form" action="/user?method=LogOut" method="post">
            		<input type="hidden" name="userIdOnlineing" value="<%= staff.getUserId() %>">
                	<input type="submit" value="退出登录" class="submitbuttom">
            	</form>
            	
            </el-aside>

            <el-main>
                <div v-html="mainContent" class="content-wrapper"></div>
            </el-main>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
            return {
                activeIndex: 'book-entry', // 默认显示图书入库界面
                mainContent: '' // 用来存储加载的JSP内容
            };
        },
        methods: {
            handleSelect(index) {
                this.activeIndex = index;
                switch (index) {
                	case 'manybook-entry':
                        this.loadPageContent('book/staffAddManyBook');
                        break;
                    case 'book-entry':
                        this.loadPageContent('book/staffAddBook');
                        break;
                    case 'book-view':
                        this.loadPageContent('book/staffSeeBooks');
                        break;
                    case 'bookPicture-view':
                        this.loadPageContent('book/staffSeeBooksByPicture');
                        break;
                    case '2':
                        this.loadPageContent('book/staffBookCirculation');
                        break;
                    case '3':
                        this.loadPageContent('book/staffStatistics');
                        break;
                }
            },
            loadPageContent(pageUrl) {
                const vm = this;
                axios.get(pageUrl)
                    .then(function (response) {
                        vm.mainContent = response.data;
                    })
                    .catch(function (error) {
                        console.log(error);
                        vm.mainContent = '<p>加载页面失败，请稍后再试。</p>';
                    });
            }
        },
        mounted() {
        	this.loadPageContent('${staffStart}');// 页面加载时默认加载后端传来的界面	
        }
    });
</script>

</body>
</html>
