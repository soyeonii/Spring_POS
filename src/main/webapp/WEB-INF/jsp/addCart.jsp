<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.example.demo.Product"%>
<%
String code = request.getParameter("code");
if (code == null || code.trim().equals("")) {
	response.sendRedirect("sale.jsp");
	return;
}

Product goods = (Product) request.getAttribute("product");

ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
if (list == null) {
	list = new ArrayList<Product>();
	session.setAttribute("cartlist", list);
}

int cnt = 0;
Product goodsQnt = new Product();
for (int i = 0; i < list.size(); i++) {
	goodsQnt = list.get(i);
	if (goodsQnt.getCode().equals(code)) {
		cnt++;
		int orderQuantity = goodsQnt.getQuantity() + 1;
		goodsQnt.setQuantity(orderQuantity);
		break;
	}
}

if (cnt == 0) {
	goods.setQuantity(1);
	list.add(goods);
}

response.sendRedirect("sale");
%>