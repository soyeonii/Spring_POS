<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>재고</title>
<style>
.text-center {
	margin: 20;
	margin-left: 400;
	margin-right: 400;
}

.tb_group {
	margin-top: 30;
	width: 750px;
	height: 450px;
	overflow: auto;
}

th, td {
	padding: 10px;
}

.grid {
	margin-top: 30;
	margin-bottom: 30;
	display: grid;
	gap: 39px;
	grid-template-columns: repeat(5, 1fr);
	grid-template-rows: 100px 100px;
	height: 500px;
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
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<div align="right">
			<form>
				<div>
					<span>제품 코드 <input type="text" name="p_code" size="10"></span>
					<span>제품명 <input type="text" name="p_name" size="10"></span>
					<span>제품 가격<input type="text" name="p_price" size="10"></span>
					<span>수량 <input type="text" name="p_unitsInStock" size="10"></span>
					<span>회사명 <input type="text" name="p_manufacturer" size="10"></span>
				</div>
				<button type="submit" formaction="/addProduct" formmethod="get"
					style="height: 50px; width: 126px; font-size: 15;">재고 입고</button>
				<button type="button"  onclick="location.href='receivedHistory'"
					style="height: 50px; width: 126px; font-size: 15;">입고 내역</button>
				<button type="submit" formaction="/updatePrice" formmethod="get"
					style="height: 50px; width: 126px; font-size: 15;">가격 변경</button>
				<button type="submit" formaction="/deleteProduct" formmethod="get"
					style="height: 50px; width: 126px; font-size: 15;">제품 삭제</button>
				<button type="submit" formaction="/searchProduct" formmethod="get"
					style="height: 50px; width: 126px; font-size: 15;">제품 검색</button>
			</form>
		</div>
		<div class="row justify-content-center">
			<div align="center">
				<div class="tb_group">
					<table border="1">
						<tr>
							<th width="20%">제품 코드</th>
							<th width="20%">제품명</th>
							<th width="20%">제품 가격</th>
							<th width="10%">수량</th>
							<th width="10%">제조사</th>
						</tr>
						<c:forEach var="product" items="${products}">
							<tr>
								<td>${product.code}</td>
								<td>${product.name}</td>
								<td>${product.price}</td>
								<td>${product.unitsInStock}</td>
								<td>${product.manufacturer}</td>
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