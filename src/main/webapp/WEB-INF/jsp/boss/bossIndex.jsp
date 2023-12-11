<%--
  Created by IntelliJ IDEA.
  User: 圣地亚鸽
  Date: 2023/12/5
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
    User boss = (User) request.getSession().getAttribute("boss");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>植物管理系统 - 管理员界面</title>
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
<input name="safe" type="hidden" value="<%= boss.getUserName() %>">
<script>
    document.addEventListener("DOMContentLoaded", function() {
        setTimeout(function() {
            <% if(request.getAttribute("addPlant") != null) { %>
                alert("${addPlant}");
            <% } else if(request.getAttribute("NotFound") != null) { %>
                alert("${NotFound}")
            <% } %>
        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
    });
</script>

<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">植物信息管理系统</span>
            <form class="logout" action="/user?method=LogOut" method="post">
                <input type="hidden" name="userIdOnlineing" value="<%= boss.getUserId() %>">
                <input type="submit" value="退出登录" class="submitbuttom">
            </form>
            <span class="user-info">欢迎你，主管人员</span>
        </el-header>

        <el-container>
            <el-aside width="195px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                    <el-submenu index="1">
                        <template slot="title"><i class="el-icon-setting"></i> 植物养护任务查看</template>
                        <%--                        <el-menu-item index="unit-add">养护任务添加</el-menu-item>--%>
                        <%--                        <el-menu-item index="unit-list">养护任务列表</el-menu-item>--%>
                    </el-submenu>
                    <el-submenu index="2">
                        <template slot="title"><i class="el-icon-setting"></i> 植物检测记录查看</template>
                        <%--                        <el-menu-item index="unit-add">检测记录添加</el-menu-item>--%>
                        <%--                        <el-menu-item index="unit-list">检测记录列表</el-menu-item>--%>
                    </el-submenu>
                    <el-submenu index="3">
                        <template slot="title"><i class="el-icon-setting"></i> 植物分类分布查看</template>
                        <%--                        <el-menu-item index="unit-add">植物分类添加</el-menu-item>--%>
                    </el-submenu>
                    <el-submenu index="4">
                        <template slot="title"><i class="el-icon-menu"></i> 人员查看</template>
                        <el-menu-item index="conserver-list">养护人员</el-menu-item>
                        <el-menu-item index="monitor-list">监测人员</el-menu-item>
                    </el-submenu>
                </el-menu>

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
                    case 'conserver-list':
                        this.loadPageContent('user/bossConserverList');
                        break;
                    case 'monitor-list':
                        this.loadPageContent('user/bossMonitorList');
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
