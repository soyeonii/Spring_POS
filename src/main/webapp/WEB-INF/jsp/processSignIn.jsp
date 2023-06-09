<%@ page contentType="text/html; charset=utf-8"%>
<%
String id = (String) request.getAttribute("id");
if (id != null) {
	session.setAttribute("id", id);
	response.sendRedirect("sale");
}
else
	response.sendRedirect("signIn?error=1");
%>