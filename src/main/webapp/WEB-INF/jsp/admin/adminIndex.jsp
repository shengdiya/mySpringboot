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

    User user1 = (User) request.getSession().getAttribute("user");Integer roleId= (Integer) request.getSession().getAttribute("roleId");

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="JavaScript/doCom.js"></script>
</head>
<body>
<input name="safe" type="hidden" value="<%=user1.getUserName() %>">
<script>
    function addInput() {
        var inputContainer = document.getElementById("inputContainer");
        var newInput = document.createElement("input");
        newInput.type = "text";
        newInput.name = "inputField[]";
        newInput.required = true;
        inputContainer.appendChild(newInput);
    }
    function filterOptions() {
        console.log("******");
        var inputValue = document.getElementById("inputText").value.trim();
        console.log(inputValue);
        var selectOptions = document.getElementById("monitoringDeviceId").options;
        console.log(selectOptions);
        var isMatching = false;
        for (var i = 0; i < selectOptions.length; i++) {
            var optionValue = selectOptions[i].text.trim();
            console.log(optionValue);
            if (optionValue.indexOf(inputValue) !== -1) {
                console.log("匹配上");
                selectOptions[i].style.display = "";
                isMatching = true;
            } else {
                console.log("没匹配上");
                selectOptions[i].style.display = "none";
            }
        }
        if (isMatching) {
            document.getElementById("monitoringDeviceId").selectedIndex = -1;
        }
        console.log("******");
    }
    function updateInputText(selectElement) {
        var selectedValue = selectElement.value;
        document.getElementById("inputText").value = selectedValue;
    }
    function generateInputFields() {
        var inputNumber = parseInt(document.getElementById("inputNumber").value);
        var inputContainer = document.getElementById("inputContainer");

        // 清空容器
        inputContainer.innerHTML = "";

        // 生成输入框并添加到容器
        for (var i = 1; i <= inputNumber; i++) {
            var inputField = document.createElement("input");
            inputField.type = "text";
            inputField.name = "inputField" + i;
            inputContainer.appendChild(inputField);
            inputContainer.appendChild(document.createElement("br"));
        }
    }
    document.addEventListener("DOMContentLoaded", function() {
        setTimeout(function() {
            <% if(request.getAttribute("effectRow") != null) { %>
                <% if((Integer) request.getAttribute("effectRow") == 1) { %>
                    alert("修改成功");
                <% } else { %>
                    alert("修改失败");
                <% } %>
            <% } %>
            <% if(request.getAttribute("effectRow_plant_disease") != null) { %>
                <% if((Integer) request.getAttribute("effectRow_plant_disease") == 1) { %>
                    alert("修改成功");
                <% } else { %>
                    alert("修改失败");
                <% } %>
            <% } %>

            <% if(request.getAttribute("addPlant") != null) { %>
                alert("${addPlant}");
            <% } else if(request.getAttribute("LikeSearchPlantByName") != null) { %>
                alert("${LikeSearchPlantByName}");
            <% } else if(request.getAttribute("addStaff") != null) { %>
                alert("${addStaff}");
            <% } else if(request.getAttribute("deleteUser") != null) { %>
                alert("${deleteUser}");
            <% } else if(request.getAttribute("SQLMessage") != null) { %>
                alert("${SQLMessage}");
            <% } else if(request.getAttribute("deleteMonitoringManagerment") != null) { %>
                alert("${deleteMonitoringManagerment}");
            <% } else if(request.getAttribute("addMore") != null) { %>
                alert("${addMore}");
            <% } else if(request.getAttribute("ModifyMonitoringManagerment") != null) { %>
                alert("${ModifyMonitoringManagerment}");
            <% } else if(request.getAttribute("modifyMonitor") != null) { %>
                alert("${modifyMonitor}");
            <% } else if(request.getAttribute("modifyDevice") != null) { %>
                alert("${modifyDevice}");
            <% } %>
        }, 0); // 设置延时时间为0，将代码推入事件循环的末尾
    });
</script>

<div id="app">
    <el-container style="height: 100vh;">
        <el-header>
            <span class="brand">植物信息管理系统</span>
            <form class="logout" action="/user?method=LogOut" method="post">
                <input type="hidden" name="userIdOnlineing" value="<%= user1.getUserId() %>">
                <input type="submit" value="退出登录" class="submitbuttom">
            </form>
            <%if(roleId == 1 ) { %>
            <span class="user-info">欢迎你，管理员</span>
            <%} %>
            <%if(roleId == 2 ) { %>
            <span class="user-info">欢迎你，养护人员</span>
            <%} %>
            <%if(roleId == 3 ) { %>
            <span class="user-info">欢迎你，监测人员</span>
            <%} %>
            <%if(roleId == 4 ) { %>
            <span class="user-info">欢迎你，上级管理人员</span>
            <%} %>
        </el-header>

        <el-container>
            <el-aside width="200px" class="el-menu-vertical-demo">
                <el-menu default-active="1" @select="handleSelect" background-color="#1F2D3D" text-color="#BCC1C7" active-text-color="#409EFF">

                    <el-submenu index="1">
                        <template slot="title"><i class="el-icon-setting"></i>植物基本信息管理</template>
                        <%if(roleId == 1) { %>
                        <el-menu-item index="plantInfo-add">植物添加</el-menu-item>
                        <%} %>
                        <el-menu-item index="plantInfo-list">植物列表</el-menu-item>
                    </el-submenu>
                    <%if(roleId == 1 || roleId == 2 || roleId == 4) { %>
                    <el-submenu index="2">
                        <template slot="title"><i class="el-icon-setting"></i> 植物养护任务管理</template>
                        <el-menu-item index="task-list">查看养护任务</el-menu-item>
                        <el-submenu index="pest-list">
                            <template slot="title">病虫害管理</template>
                            <el-menu-item index="plant-list">植物患病情况</el-menu-item>
                            <el-menu-item index="pest-list">病虫害列表</el-menu-item>
                            <el-menu-item index="plan-list">防治方案列表</el-menu-item>
                        </el-submenu>
                    </el-submenu>
                    <%} %>
                    <%if(roleId == 1 || roleId == 3 || roleId == 4) { %>
                    <el-submenu index="3">
                        <template slot="title"><i class="el-icon-setting"></i> 植物检测记录管理</template>
                        <el-menu-item index="monitormanagement-list">监测记录查看</el-menu-item>
                        <%if(roleId == 1 || roleId == 3) { %>
                        <el-menu-item index="monitordevice-add">监测设备添加</el-menu-item>
                        <%} %>
                        <el-menu-item index="monitordevice-list">监测设备查看</el-menu-item>

                    </el-submenu>
                    <%} %>
                    <el-submenu index="4">
                        <template slot="title"><i class="el-icon-setting"></i> 植物分类分布管理</template>
                        <%if(roleId == 1) { %>
                        <el-menu-item index="species-add">植物种类添加</el-menu-item>
                        <%} %>
                        <el-menu-item index="species-list">植物种类查询</el-menu-item>
                    </el-submenu>
                    <%if(roleId == 1 || roleId == 4) { %>
                    <el-submenu index="5">
                        <template slot="title"> <i class="el-icon-menu"></i> 用户管理 </template>
                        <%if(roleId == 1 ) { %>
                        <el-menu-item index="user-add">用户添加</el-menu-item>
                        <%} %>
                        <el-submenu index="user-list">
                            <template slot="title">用户列表</template>
                            <el-menu-item index="user-conserver">养护人员</el-menu-item>
                            <el-menu-item index="user-monitor">监测人员</el-menu-item>
                            <el-menu-item index="user-boss">上级管理人员</el-menu-item>
                        </el-submenu>
                    </el-submenu>
                    <%} %>
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
                    case 'user-add':
                        this.loadPageContent('user/adminAddUser');
                        break;
                    case 'user-conserver':
                        this.loadPageContent('user/adminUserListConserver');
                        break;
                    case 'user-monitor':
                        this.loadPageContent('user/adminUserListMonitor');
                        break;
                    case 'user-boss':
                        this.loadPageContent('user/adminUserListBoss');
                        break;
                    case 'plantInfo-add':
                        this.loadPageContent('plant/adminAddPlant');
                        break;
                    case 'plantInfo-list':
                        this.loadPageContent('plant/adminPlantList');
                        break;
                    case 'monitordevice-add':
                        this.loadPageContent("MonitorDevice/MonitorDeviceAdd");
                        break;
                    case 'monitordevice-list':
                        this.loadPageContent("MonitorDevice/MonitorDeviceShow");
                        break;
                    case 'monitormanagement-list':
                        this.loadPageContent("MonitorManagement/MonitorManagementShow");
                        break;
                    case 'task-list':
                        this.loadPageContent('conserverController/conserverTaskList');
                        break;
                    case 'task-add':
                        this.loadPageContent('conserverController/conserverAddTask');
                        break;
                    case 'plant-list':
                        this.loadPageContent('conserverController/conserverTODOPlant');
                        break;
                    case 'pest-list':
                        this.loadPageContent('conserverController/conserverShowAndAddPest');
                        break;
                    case'species-add':
                        this.loadPageContent('species/adminAddSpecies');
                        break;
                    case'species-list':
                        this.loadPageContent('species/adminSpeciesList');
                        break;
                    case 'plan-list':
                        this.loadPageContent('conserverController/conserverControlPlan');
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
                        vm.mainContent = '';
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

