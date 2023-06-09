<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>입고 내역</title>
<style>
.text-center {
	margin: 20;
	margin-left: 400;
	margin-right: 400;
}

table {
	width: 700px;
}

.tb_group {
	margin-top: 30;
	width: 750px;
	height: 600px;
	overflow: auto;
}

th, td {
	padding: 10px;
}


.input {
	margin-top: 30;
}

span {
	padding: 10;
}

input {
	margin-top: 30;
	margin-bottom: 30;
	margin-left: 10;
}

.bill {
	padding-bottom: 30;
	font-size: 25px;
	font-weight: 500;
}
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<div class="row justify-content-center">
			<div align="center">
				<div class="tb_group">
					<div class="bill">전체 입고 내역</div>
					<table style="border-collapse:collapse; border:1px #333 solid;">
						<tr>
							<th width="35%">제품 코드</th>
							<th width="35%">수량</th>
							<th width="30%">입고 날짜</th>
						</tr>
						<c:forEach var="receive" items="${receives}">
							<tr>
								<td>${receive.code}</td>
								<td>${receive.count}</td>
								<td>${receive.regDate}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>