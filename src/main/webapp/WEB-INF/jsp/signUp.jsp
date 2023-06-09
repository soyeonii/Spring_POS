<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>회원가입</title>
<style>
@media ( min-width : 400px) {
	.container {
		width: 400px;
	}
}
</style>
<script type="text/javascript">
function passwordCheck() {
	var id = document.getElementById('id').value;
	var name = document.getElementById('name').value;
	var password = document.getElementById('password').value;
	var passwordCheck = document.getElementById('passwordCheck').value;
	
	if (id != '' && name != '' && password != '' && passwordCheck != '') {
		if (password == passwordCheck) {
			document.signUp.submit();
		} else {
			alert('비밀번호를 확인해주세요');
		}
	} else
		alert('모두 입력해주세요');
}
</script>
</head>
<body>
	<div class="text-center">
		<div class="container">
			<div class="jumbotron" style="padding-top: 50px;">
			<form action="/processSignUp" style="margin-top: 10%" id="signUp" name="signUp">
					<img class="mb-5" src="../image/pos.png" alt=""
						height="57">
					<h1 class="h3 mb-5 fw-normal">회원가입</h1>
					<div class="form-floating mb-4">
						<input type="id" class="form-control" id="id" name="id"
							placeholder="아이디"> <label for="floatingInput">아이디</label>
					</div>
					<div class="form-floating mb-4">
						<input type="name" class="form-control" id="name" name="name"
							placeholder="이름"> <label for="floatingInput">이름</label>
					</div>
					<div class="form-floating mb-4">
						<input type="email" class="form-control" id="email" name="email"
							placeholder="이메일"> <label for="floatingInput">이메일</label>
					</div>
					<div class="form-floating mb-4">
						<input type="password" class="form-control" id="password" name="password"
							placeholder="비밀번호"> <label for="floatingPassword">비밀번호</label>
					</div>
					<div class="form-floating mb-4">
						<input type="password" class="form-control" id="passwordCheck" name="passwordCheck"
							placeholder="비밀번호 확인"> <label for="floatingPassword">비밀번호
							확인</label>
					</div>
					<input type="button" onclick="window.passwordCheck()" class="w-100 btn btn-lg btn-danger mb-3" value="회원가입">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>