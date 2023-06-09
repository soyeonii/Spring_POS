<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.example.demo.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<%
String cartId = session.getId();
%>
<title>판매</title>
<style>
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

.tt_group {
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
</style>
<script type="text/javascript">
	function cardPayment() {
		if (confirm("카드 결제를 하시겠습니까?"))
			location.href='/orderConfirmation';
	}
	
	function cashPayment() {
		if (confirm("현금 결제를 하시겠습니까?"))
			location.href='/orderConfirmation';
	}
</script>
</head>
<body>
	<%
	if (session.getAttribute("id") == null)
		response.sendRedirect("logout");
	
	response.setIntHeader("Refresh", 3);
	Product product;
	%>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<div class="row justify-content-between">
			<div align="left">
				<div class="tb_group">
					<table border="1">
						<tr>
							<th width="30%">상품명</th>
							<th width="10%">수량</th>
							<th width="20%">가격</th>
							<th width="10%">비고</th>
						</tr>
						<%
						int sum = 0;
						ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
						if (cartList == null)
							cartList = new ArrayList<Product>();
						for (int i = 0; i < cartList.size(); i++) {
							product = cartList.get(i);
							int total = product.getPrice() * product.getQuantity();
							sum += total;
						%>
						<tr>
							<td><%=product.getName()%></td>
							<td><%=product.getQuantity()%></td>
							<td><%=product.getPrice()%></td>
							<td></td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
				<div class="row" style="margin-top: 45px;">
					<div class="tt_group">
						<div class="row justify-content-between">
							<div class="col" align="left">총 금 액</div>
							<div class="col" align="right"><%=sum%>
							</div>
						</div>
						<hr style="margin-bottom: 31;">
						<div class="row justify-content-between">
							<div class="col" align="left">받은금액</div>
							<div class="col" align="right">0</div>
						</div>
						<hr style="margin-bottom: 31;">
						<div class="row justify-content-between">
							<div class="col" align="left">거스름돈</div>
							<div class="col" align="right">0</div>
						</div>
						<hr>
					</div>
					<div>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20;">1</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20;">2</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20;">3</button>
						<br>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">4</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">5</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">6</button>
						<br>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">7</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">8</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">9</button>
						<br>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">0</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">00</button>
						<button type="button" onclick="#"
							style="height: 40px; width: 50px; font-size: 20; margin-left: 20; margin-top: 15">CE</button>
					</div>
				</div>
			</div>
			<div align="right">
				<div class="grid">
					<c:forEach var="product" items="${products}">
						<button type="button"
						onclick="location.href='./addCart?code=${product.code}'"
						style="height: 70px; width: 100px; font-size: 20;">${product.name}</button>
					</c:forEach>
					<%
					for (int i = (int) request.getAttribute("count"); i < 16; i++) {
					%>
					<button type="button" onclick="#"
					style="height: 70px; width: 100px; font-size: 20;" disabled></button>
					<%
					}
					%>
				</div>
				<div>
					<button type="button"
						onclick="location.href='./deleteCart?cartId=<%=cartId%>'"
						style="height: 70px; width: 126px; font-size: 20;">전체 취소</button>
					<button type="button" onclick="location.href='/salesHistory'"
						style="height: 70px; width: 126px; font-size: 20;">판매 내역</button>
					<button type="button" onclick="cardPayment()"
						style="height: 70px; width: 126px; font-size: 20;">카드 결제</button>
					<button type="button" onclick="cashPayment()"
						style="height: 70px; width: 126px; font-size: 20;">현금 결제</button>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>