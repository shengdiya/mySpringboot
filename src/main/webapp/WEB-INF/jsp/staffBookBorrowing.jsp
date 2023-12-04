<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
 %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆借阅系统 - 借阅管理</title>
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
	<style>
        .aside-form {
            position: absolute;
            bottom: 0;
        }
        .submitbuttom{
        	background-color: #5cb85c;
		    color: white;
		    padding: 10px 20px;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		    margin: 5px; 
        }
    </style>
</head>
<body>

 <input name="safe" type="hidden" value="<%= staff.getUserName() %>">
	<script>
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("borrowing") != null) { %>
	                alert("${borrowing}");
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
	            <% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
	</script>

<div id="app">	
    <el-container style="height: 100vh;">
        <el-aside width="150px" class="el-menu-vertical-demo">
            <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                <el-menu-item index="pending"><i class="el-icon-time"></i> 待审核</el-menu-item>
                <el-menu-item index="reviewed"><i class="el-icon-check"></i> 已借出</el-menu-item>
                <el-menu-item index="finished"><i class="el-icon-circle-check"></i> 已结束</el-menu-item>
            </el-menu>
            
            <!-- 底部按钮 -->
            <form class="aside-form" action="/book?method=goBackToStaffIndex" method="post" >
                <input type="submit" value="返回" class="submitbuttom">
            </form>
        </el-aside>

        <el-main>
            <div v-html="mainContent" class="content-wrapper"></div>
        </el-main>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
            return {
                activeIndex: 'pending', // 默认显示待审核界面
                mainContent: '' // 用来存储加载的JSP内容
            };
        },
        methods: {
            handleSelect(index) {
                this.activeIndex = index;
                switch (index) {
                    case 'pending':
                        this.loadPageContent('/book/staffBookBorrowingWating');
                        break;
                    case 'reviewed':
                        this.loadPageContent('/book/staffBookBorrowingReviewed');
                        break;
                    case 'finished':
                        this.loadPageContent('/book/staffBookBorrowingFinished');
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
        	// 页面加载时默认加载“待审核”界面
        	this.loadPageContent('/book/staffBookBorrowingWating');
        }
    });
</script>

</body>
</html>
