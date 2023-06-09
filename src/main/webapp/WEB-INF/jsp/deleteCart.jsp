<%@ page contentType="text/html; charset=utf-8"%>
<%
session.removeAttribute("cartlist");
response.sendRedirect("sale");
%>