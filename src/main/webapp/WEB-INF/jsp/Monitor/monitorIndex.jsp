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
    User monitor = (User) request.getSession().getAttribute("monitor");
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
<input name="safe" type="hidden" value="<%= monitor.getUserName() %>">
<script>
    document.addEventListener("DOMContentLoaded", function() {
        setTimeout(function() {
            <% if(request.getAttribute("addPlant") != null) { %>
                alert("${addPlant}");
            <% } else if(request.getAttribute("NotFound") != null) { %>
                alert("${NotFound}");
            <% } %>
        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
    });
</script>

<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">植物信息管理系统</span>
            <form class="logout" action="/user?method=LogOut" method="post">
                <input type="hidden" name="userIdOnlineing" value="<%= monitor.getUserId() %>">
                <input type="submit" value="退出登录" class="submitbuttom">
            </form>
            <span class="user-info">欢迎你，监测人员</span>
        </el-header>

        <el-container>
            <el-aside width="200px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">
                    <el-submenu index="1">
                        <template slot="title"><i class="el-icon-setting"></i> 植物检测记录管理</template>
                        <el-menu-item index="monitormanagement-add">监测记录添加</el-menu-item>
                        <el-menu-item index="monitormanagement-list">监测记录查看</el-menu-item>
                        <el-menu-item index="monitordevice-add">监测设备添加</el-menu-item>
                        <el-menu-item index="monitordevice-list">监测设备查看</el-menu-item>
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
                    case 'monitordevice-add':
                        this.loadPageContent("MonitorDevice/MonitorDeviceAdd");
                        break;
                    case 'monitordevice-list':
                        this.loadPageContent("MonitorDevice/MonitorDeviceShow");
                        break;
                    case 'monitormanagement-add':
                        this.loadPageContent("MonitorManagement/MonitoringDeviceAdd");
                        break;
                    case 'monitormanagement-list':
                        this.loadPageContent("MonitorManagement/MonitorManagementShow");
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

