<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>판매 내역</title>
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
					<div class="bill">전체 판매 내역</div>
					<table style="border-collapse:collapse; border:1px #333 solid;">
						<tr>
							<th width="20%">NO</th>
							<th width="40%">총액</th>
							<th width="40%">판매 날짜</th>
						</tr>
						<c:forEach var="history" items="${historys}">
							<tr>
								<td>${history.number}</td>
								<td>${history.price}</td>
								<td>${history.saleDate}</td>
								<td><a href="/deleteSale?number=${history.number}" class="badge badge-danger">취소</a></td>
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