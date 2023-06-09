<%@ page contentType="text/html; charset=utf-8"%>
<html>
<%
String name = (String) request.getAttribute("name");
String email = (String) request.getAttribute("email");
%>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>내 정보</title>
<style>
.text-center {
	margin: 20;
	margin-left: 400;
	margin-right: 400;
}
</style>
<script type="text/javascript">
function logout() {
	if (confirm("로그아웃 하시겠습니까?"))
		location.href='/logout';
}

function withdrawal() {
	if (confirm("회원탈퇴를 하시겠습니까?"))
		location.href='/withdrawal';
}
</script>
</head>
<body>
	<jsp:include page="top.jsp" />
	<div class="text-center">
		<jsp:include page="menu.jsp" />
		<div style="margin-top: 200">
			이름 :
			<%=name%>
			<br> <br> 이메일 :
			<%=email%>
		</div>
		<div style="margin-top: 200;">
			<button type="button" onclick="logout()"
				style="height: 70px; width: 160px; font-size: 20;">로그아웃</button>
			<button type="button" onclick="location.href='/modify'"
				style="height: 70px; width: 160px; font-size: 20; margin-left: 40; margin-right: 40">정보 수정</button>
			<button type="button" onclick="withdrawal()"
				style="height: 70px; width: 160px; font-size: 20;">회원탈퇴</button>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>