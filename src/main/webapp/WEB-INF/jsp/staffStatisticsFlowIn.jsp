<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.myapp.demo.Entiy.*" %>
<%@ page import="com.myapp.demo.Service.*" %>
<%@ page import="com.myapp.demo.Controller.*" %>

<%
	User staff = (User) request.getSession().getAttribute("staff");
 %>
<html>
<head>
    <title>书籍流入统计</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/statistics.css">
    <link rel="stylesheet" type="text/css" href="/css/seeDetails.css"> <!-- 为了返回按钮 -->
</head>
<body>
<input name="safe" type="hidden" value="<%= staff.getUserName() %>">
	<div class="chart-title">
        <h2>本单位总图书数 : ${booksInOwnUnit}</h2>
        <h2>当前在库总图书数 : ${booksInNow}</h2>
    </div>

    <div class="chart-container">
        <div class="canvas-wrapper">
            <canvas id="barChart"></canvas>
        </div>
        <div class="canvas-wrapper">
            <canvas id="lineChart"></canvas>
        </div>
    </div>

	<form action="/book?method=staffReturnStatistics" method="post">  
		<input type="submit" value="返回">
	</form>
	
    <script>
        var barChartData = JSON.parse('${barData}');
        var lineChartData = JSON.parse('${lineData}');

        var barConfig = {
            type: 'bar',
            data: {
                labels: ['2021年', '2022年', '2023年'],
                datasets: [{
                    label: '按年统计的流出信息柱状图',
                    data: barChartData,
                    backgroundColor: [
                        'rgba(255,99,132,0.2)',
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        };

        var lineConfig = {
            type: 'line',
            data: {
                labels: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                datasets: [{
                    label: '2023年度统计',
                    data: lineChartData,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        };

        new Chart(document.getElementById('barChart'), barConfig);
        new Chart(document.getElementById('lineChart'), lineConfig);
    </script>
</body>
</html>
