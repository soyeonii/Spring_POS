<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="com.example.demo.Product"%>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>판매 정보</title>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="container col-8 alert alert-info" style="margin-top: 3%">
		<div class="text-center">
			<br>
			<h1>
				<b>영수증</b>
			</h1>
			<br> <br>
		</div>
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">상품</th>
					<th class="text-center">#</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				<%
				int sum = 0;
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if (cartList == null)
					cartList = new ArrayList<Product>();
				for (int i = 0; i < cartList.size(); i++) {
					Product product = cartList.get(i);
					int total = product.getPrice() * product.getQuantity();
					sum = sum + total;
				%>
				<tr>
					<td class="text-center"><em><%=product.getName()%></em></td>
					<td class="text-center"><%=product.getQuantity()%></td>
					<td class="text-center"><%=product.getPrice()%>원</td>
					<td class="text-center"><%=total%>원</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-right"><strong>총액: </strong></td>
					<td class="text-center text-danger"><strong><%=sum%>원</strong></td>
				</tr>
			</table>
			<%
			session.removeAttribute("cartlist");
			%>
			<a href="/sale" class="btn btn-secondary" role="button">이전</a>
		</div>
	</div>
</body>
</html>