<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("utf-8");

Calendar cal = Calendar.getInstance();

// 시스템 오늘날짜
int ty = cal.get(Calendar.YEAR);
int tm = cal.get(Calendar.MONTH) + 1;
int td = cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;

// 파라미터 받기
String sy = request.getParameter("year");
String sm = request.getParameter("month");

if (sy != null) { // 넘어온 파라미터가 있으면
	year = Integer.parseInt(sy);
}
if (sm != null) {
	month = Integer.parseInt(sm);
}

cal.set(year, month - 1, 1);
year = cal.get(Calendar.YEAR);
month = cal.get(Calendar.MONTH) + 1;

int week = cal.get(Calendar.DAY_OF_WEEK); // 1(일)~7(토)
%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>통계</title>
<style>
a {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: #F28011;
}

.calendar {
	width: 700px;
	height: 800px;
	margin: 10px auto;
	float: left;
}

.calendar .title {
	height: 37px;
	line-height: 37px;
	text-align: center;
	font-weight: 600;
}

.calendar .selectField {
	border: 1px solid #999;
	padding: 2px 7px;
	border-radius: 3px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
	float: center;
}

.calendar table {
	width: 100%;
	height: 600px;
	border-collapse: collapse;
	border-spacing: 0;
}

.calendar table thead tr:first-child {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
	background: #f6f6f6;
}

.calendar table td {
	padding: 10px;
	text-align: center;
	font-size: 12px;
	border: 1px solid #ccc;
}

.calendar table td:nth-child(7n+1) {
	color: red;
}

.calendar table td:nth-child(7n) {
	color: blue;
}

.calendar table td.gray {
	color: #ccc;
}

.calendar table td.today {
	font-weight: 700;
	background: #E6FFFF;
}

.calendar .footer {
	height: 25px;
	line-height: 25px;
	text-align: right;
	font-size: 12px;
}

.statistic-box {
	margin-left: 1100px;
}

.statistic-box .graph {
	width: 400px;
}

.statistic-box .statistic {
	padding: 10px;
	margin-left: 50px;
}

.text-center {
	margin: 20;
	margin-left: 400;
	margin-right: 400;
}

.tb_group {
	margin-top: 30;
	width: 550px;
	height: 350px;
	overflow: auto;
}

.result_group {
	width: 300px;
	text-align: left;
	font-size: 20px;
	margin-left: 15;
	margin-right: 30;
}

th, td {
	padding: 10px;
}

.grid {
	margin-top: 30;
	margin-bottom: 30;
	display: grid;
	gap: 39px;
	grid-template-columns: repeat(4, 1fr);
	grid-template-rows: 100px 100px;
	height: 500px;
}

.account {
	margin-top: 30;
}

span {
	padding: 10;
}
span.best {
	display: block;
	margin-left: 20px;
	margin-bottom: 10px;
	font-weight: 500;
}

input {
	margin-top: 30;
	margin-bottom: 30;
	margin-left: 10;
}

p {
	color: black;
}
</style>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	function change() {
		var f = document.frm;
		f.action = "statistic";
		f.submit();
	}

	// 그래프
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});

	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Day');
		data.addColumn('number', 'Sale');
		data.addRows([["2022-05-28", 3700], ["2022-05-29", 12500], ["2022-05-30", 10500], ["2022-05-31", 0], ["2022-06-01", 600],
		              ["2022-06-02", 1800], ["2022-06-03", 1800], ["2022-06-04", 0], ["2022-06-05", 2800], ["2022-06-06", 1800],
		              ["2022-06-07", 13700], ["2022-06-08", 0], ["2022-06-09", 6900]]);
		
		var options = {
			'title' : 'Weekly Graph',
			'width' : 400,
			'height' : 300
		};

		var chart = new google.visualization.ColumnChart(document
				.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<div class="calendar">
			<div class="title">
				<form name="frm" method="get">
					<select name="year" class="selectField" onchange="change()">
						<%
						for (int i = year - 5; i <= year + 5; i++) {
						%>
						<option value="<%=i%>" <%=year == i ? "selected='selected'" : ""%>><%=i%>년
						</option>
						<%
						}
						%>
					</select> <select name="month" class="selectField" onchange="change()">
						<%
						for (int i = 1; i <= 12; i++) {
						%>
						<option value="<%=i%>"
							<%=month == i ? "selected='selected'" : ""%>><%=i%>월
						</option>
						<%
						}
						%>
					</select>
				</form>
			</div>

			<table>
				<thead>
					<tr>
						<td>일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td>토</td>
					</tr>
				</thead>
				<tbody>
					<%
					// 1일 앞 달
					Calendar preCal = (Calendar) cal.clone();
					preCal.add(Calendar.DATE, -(week - 1));
					int preDate = preCal.get(Calendar.DATE);

					out.print("<tr>");
					// 1일 앞 부분
					for (int i = 1; i < week; i++) {
						//out.print("<td>&nbsp;</td>");
						out.print("<td class='gray'>" + (preDate++) + "</td>");
					}

					// 1일부터 말일까지 출력
					int lastDay = cal.getActualMaximum(Calendar.DATE);
					String cls;
					for (int i = 1; i <= lastDay; i++) {
						cls = year == ty && month == tm && i == td ? "today" : "";

						// 매출액 출력 수정해야함
						String total = (String) request.getAttribute(year + "-" + String.format("%02d", month) + "-" + String.format("%02d", i));
						if (total == null)
							total = "0";
						out.print("<td class='" + cls + "'>" + i + "<p><br>오늘의 매출 : " + "<p>" + total + "</td>");
						if (lastDay != i && (++week) % 7 == 1) {
							out.print("</tr><tr>");
						}
					}

					// 마지막 주 마지막 일자 다음 처리
					int n = 1;
					for (int i = (week - 1) % 7; i < 6; i++) {
						// out.print("<td>&nbsp;</td>");
						out.print("<td class='gray'>" + (n++) + "</td>");
					}
					out.print("</tr>");
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="statistic-box">
		<div class="graph">
			<div id="chart_div"></div>
		</div>
		<div class="statistic">
			<form action="/statistic" method="get">
				<label>
					<input type='radio' name="period" value="day">하루
				</label>
				<label>
					<input type='radio' name="period" value="week">일주일
				</label>
				<label>
					<input type='radio' name="period" value="month">한달
				</label>
				<input type='submit' value='매출액 확인'>
			</form>
			<div style="margin-left: 70;">
				<%
				if (request.getAttribute("total") != null)
					out.print("<h5>총 매출액 : " + request.getAttribute("total") + "원</h5>");
				%>
			</div>
			<table style="border-collapse:collapse; border:1px #333 solid;">
				<span class="best">(하루, 일주일, 한달) 최다 판매 제품</span>
				<tr>
					<th width="25%" style="font-weight: 200; font-size: 14px">#</th>
					<th width="30%" style="font-weight: 200; font-size: 14px">제품 코드</th>
					<th width="25%" style="font-weight: 200; font-size: 14px">판매 수량</th>
				</tr>
				<c:forEach var="best" items="${bests}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>${best.code}</td>
						<td>${best.count}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>