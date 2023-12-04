<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User admin = (User) request.getSession().getAttribute("admin");
 %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆借阅系统 - 管理员界面</title>
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

</head>
<body>
 <input name="safe" type="hidden" value="<%= admin.getUserName() %>">
	<script>
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("addStaff") != null) { %>
	                alert("${addStaff}");
	            <% } else if(request.getAttribute("deleteUser") != null) { %>
	                alert("${deleteUser}");
	            <% } else if(request.getAttribute("modifyUser") != null) { %>
	                alert("${modifyUser}");
	            <% } else if(request.getAttribute("deleteBook") != null) { %>
	            	alert("${deleteBook}");
	            <% } else if(request.getAttribute("modifyBook") != null) { %>
	            	alert("${modifyBook}");
	            <% } else if(request.getAttribute("addUnit") != null) { %>
	            	alert("${addUnit}");
	            <% } else if(request.getAttribute("deleteUnit") != null) { %>
	            	alert("${deleteUnit}");
	            <% } else if(request.getAttribute("modifyUnit") != null) { %>
	            	alert("${modifyUnit}");
	            <% } else if(request.getAttribute("NotFound") != null) { %>
	            	alert("${NotFound}");
	           	<% } else if(request.getAttribute("alreadyLogin") != null) { %>
	            	alert("${alreadyLogin}");
	            <% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
	</script>
	
<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">图书馆借阅系统</span>
            <a href="/user/adminDetails" class="user-info">欢迎你，管理员（admin）</a>
        </el-header>

        <el-container>
            <el-aside width="200px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                    <el-submenu index="1">
                        <template slot="title"><i class="el-icon-menu"></i> 用户管理</template>
                        <el-menu-item index="user-add">用户添加</el-menu-item>
                        <el-menu-item index="user-list">用户列表</el-menu-item>
                    </el-submenu>
                    <el-menu-item index="book-manage"><i class="el-icon-document"></i> 图书管理</el-menu-item>
                    <el-submenu index="2">
                    	<template slot="title"><i class="el-icon-setting"></i> 单位管理</template>
                    	<el-menu-item index="unit-add">单位添加</el-menu-item>
                        <el-menu-item index="unit-list">单位列表</el-menu-item>
					</el-submenu>
                </el-menu>
                
                <!-- 底部按钮 -->
            	<form class="aside-form" action="/user?method=LogOut" method="post">
            		<input type="hidden" name="userIdOnlineing" value="<%= admin.getUserId() %>">
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
                activeIndex: 'user-add', // 默认显示用户添加界面
                mainContent: '' // 用来存储加载的JSP内容
            };
        },
        methods: {
            handleSelect(index) {
                this.activeIndex = index;
                switch (index) {
                    case 'user-add':
                        this.loadPageContent('user/adminAddStaff');
                        break;
                    case 'user-list':
                        this.loadPageContent('user/adminUserList');
                        break;
                    case 'book-manage':
                    	this.loadPageContent('book/adminSeeBooks');
                        break;
                    case 'unit-add':
                    	this.loadPageContent('unit/adminAddUnit');
                        break;
                    case 'unit-list':
                    	this.loadPageContent("unit/adminSeeUnits")
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
        	this.loadPageContent('${start}');// 页面加载时默认加载后端传来的界面	
        }
    });
</script>

</body>
</html>
