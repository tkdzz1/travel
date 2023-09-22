<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/login.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<div id=loginDIV>
		<h1>이메일 로그인</h1>
		<input type=text name=email> <input type=button value="확인" id="emailCheck">
		<div class="social-login" style="display:none;">
			<hr>SNS 로그인<br><br>
			<img src="img/kakaologin.png">
		</div>
	</div>
	<div id="emailCode" style="display:none;">
		<h1>인증번호 입력</h1>
			<input type=text name=code><input type=button value="확인" id="codeCheck">
	</div>
	<div id="password" style="display:none;">
		<h1>비밀번호 입력</h1>
		<input type=password name=password><input type=button value="가입" id=signUp>
	</div>
	<div id="signUpSuccess" style="display:none;">
		<h1 id=mail></h1>
		<h1>회원가입이 완료되었습니다 ! </h1>
		<a href="/"><button>홈으로 이동</button></a>
	</div>
	<div id="loginPassword" style="display:none">
		<h1>비밀번호 입력</h1>
		<input type=password name=loginPassword><input type=button value="로그인" id=login>
	</div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/login.js"></script>
</html>