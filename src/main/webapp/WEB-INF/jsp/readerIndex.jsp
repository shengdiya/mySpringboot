<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User reader = (User) request.getSession().getAttribute("reader");
 %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书馆借阅系统 - 读者界面</title>
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
		    top: 6%; /* 顶部距离设置为父容器高度的10% */
		    right: 25px; /* 右侧外边距设置为35像素 */
		    transform: translateY(-50%); /* 垂直居中调整 */
		    border-radius: 50%; /* 圆形图片 */
		    width: 40px; /* 设置图片宽度 */
		    height: 40px; /* 设置图片高度 */
		    object-fit: cover; /* 覆盖模式，保持图片比例 */
		}
    </style>
</head>
<body>
 <input name="safe" type="hidden" value="<%= reader.getUserName() %>">
	<script>
	    document.addEventListener("DOMContentLoaded", function() {
	        setTimeout(function() {
	            <% if(request.getAttribute("borrowStatus") != null) { %>
	                alert("${borrowStatus}");
	            <% } else if(request.getAttribute("returnBook") != null) { %>
	                alert("${returnBook}");
	            <% } %>
	        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
	    });
	</script>
<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">图书馆借阅系统</span>
            <a href="user/readerDetails" class="user-info">欢迎你，<%= reader.getUserName() %></a>
            <img src="<%= reader.getPicturePath() %>" alt="User Avatar" class="user-avatar" />
        </el-header>

        <el-container>
            <el-aside width="200px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                    <el-menu-item index="borrow-book"><i class="el-icon-document"></i> 借阅图书</el-menu-item>
                    <el-menu-item index="return-book"><i class="el-icon-upload2"></i> 归还图书</el-menu-item>
                    <el-menu-item index="order-list"><i class="el-icon-menu"></i> 订单列表  </el-menu-item>
                </el-menu>
                
                <!-- 底部按钮 -->
            	<form class="aside-form" action="/user?method=LogOut" method="post">
            		<input type="hidden" name="userIdOnlineing" value="<%= reader.getUserId() %>">
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
                activeIndex: 'borrow-book', // 默认显示借阅图书界面
                mainContent: '' // 用来存储加载的JSP内容
            };
        },
        methods: {
            handleSelect(index) {
                this.activeIndex = index;
                switch (index) {
                    case 'borrow-book':
                        this.loadPageContent('book/readerBorrowBooks');
                        break;
                    case 'return-book':
                        this.loadPageContent('book/readerReturnBooks');
                        break;
                    case 'order-list':
                    	this.loadPageContent('book/readerSeeOrders');
                        break;
                }
            },
            loadPageContent(pageUrl) {
                const vm = this;
                axios.defaults.withCredentials = true;
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
        	// 页面加载时默认加载后端传来的界面
        	this.loadPageContent('${readerStart}');
        }
    });
</script>

</body>
</html>
