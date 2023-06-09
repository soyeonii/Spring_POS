<%@ page contentType="text/html; charset=utf-8"%>
<html>
<%
String name = (String) request.getAttribute("name");
String password = (String) request.getAttribute("password");
String email = (String) request.getAttribute("email");
%>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>정보 수정</title>
<style>
.text-center {
	margin: 20;
	margin-left: 400;
	margin-right: 400;
}

.input-box {
	width: auto;
}
.btn-group {
	margin-top: 100px;
}
span {
	display: flex;

	justify-content: center;
	margin: 30px;
}
input {
	margin-left: 15px;
}
.input-box p {
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<form action="/processModify">
			<div style="margin-top: 150" class="input-box">
				<p>회원 정보 수정</p>
				<span>이름 : <input id="name" name="name" type="text" value=<%=name%>></span>
				<span>비밀번호 : <input id="password" name="password" type="password" value=<%=password%>></span>
				<span>이메일 : <input id="email" name="email" type="text" value=<%=email%>></span>
				
			</div>
			<div align="center" class="btn-group">
				<button type="submit" style="height: 70px; width: 160px; font-size: 20;">수정</button>
				<button type="button" onclick="location.href='/myPage'"
					style="height: 70px; width: 160px; font-size: 20; margin-left: 40; margin-right: 40">취소
					</button>
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>