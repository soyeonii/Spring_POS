<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
Date date = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd(E) a hh:mm:ss");
%>
<nav class="navbar navbar-light bg-light">
	<div align="left">POS 프로그램</div>
	<div align="right">
		영업 일자 :
		<%=formatter.format(date)%>
	</div>
</nav>