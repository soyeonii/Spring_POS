<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>로그인</title>
<style>
@media ( min-width : 400px) {
	.container {
		width: 400px;
	}
}
</style>
</head>
<body>
	<div class="text-center">
		<div class="container">
			<div class="jumbotron" style="padding-top: 50px;">
				<form action="/processSignIn" style="margin-top: 20%">
					<img class="mb-5" src="../image/pos.png" alt="" height="57">
					<h1 class="h3 mb-5 fw-normal">로그인</h1>
					<%
					String error = request.getParameter("error");
					if (error != null) {
						out.println("<div class='alert alert-danger'>");
						out.println("아이디와 비밀번호를 확인해주세요");
						out.println("</div>");
					}
					%>
					<div class="form-floating mb-5">
						<input type="text" class="form-control" id="id" name="id"
							placeholder="아이디"> <label for="floatingInput">아이디</label>
					</div>
					<div class="form-floating mb-5">
						<input type="password" class="form-control" id="password" name="password"
							placeholder="비밀번호"> <label for="floatingPassword">비밀번호</label>
					</div>
					<input type="submit" class="w-100 btn btn-lg btn-danger mb-3"
						value="로그인"> <input type="button" class="btn btn-link"
						onclick="location.href='signUp'" value="회원가입">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page='footer.jsp' />
</body>
</html>