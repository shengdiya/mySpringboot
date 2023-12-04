<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书流通管理</title>
    <!-- 引入Element UI图标样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 自定义样式 -->
    <style>
        body {
            font-family: 'Source Sans Pro', sans-serif;
            background-color: #E9EEF3;
            margin: 0;
            padding: 20px;
        }
        
        .circulation-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            justify-content: center;
            align-items: center;
        }

        .circulation-link {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            width: 200px;
            height: 200px;
            background-color: #fff;
            color: #333;
            border-radius: 10px;
            box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .circulation-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .circulation-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .circulation-text {
            font-size: 18px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="circulation-container">
    <a href="/book/staffBookBorrowing" class="circulation-link">
        <i class="el-icon-s-check circulation-icon"></i>
        <div class="circulation-text">图书借阅管理</div>
    </a>
    <a href="/book/staffSeeBooksInOtherUnits" class="circulation-link">
        <i class="el-icon-search circulation-icon"></i>
        <div class="circulation-text">查阅其他单位图书</div>
    </a>
    <a href="/book/staffSeeOwnflowOrder" class="circulation-link">
        <i class="el-icon-top circulation-icon"></i>
        <div class="circulation-text">图书流入</div>
    </a>
    <a href="/book/staffSeeOtherUnitflowOrder" class="circulation-link">
        <i class="el-icon-bottom circulation-icon"></i>
        <div class="circulation-text">图书流出</div>
    </a>
</div>
</body>
</html>
