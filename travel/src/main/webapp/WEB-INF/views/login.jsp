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
<%@ include file="header.jsp" %>
<div class="container">
	<div id=loginDIV>
		<h1>이메일 로그인</h1>
		<input type=text name=email placeholder="이메일 주소" style="height:50px;width:250px;"> <button class="w-btn w-btn-red" id=emailCheck>다음</button>
	</div>
	<div id="emailCode" style="display:none;">
		<h1>인증번호 입력</h1>
			<input type=text name=code><input type=button value="확인" id="codeCheck">
	</div>
	<div id="password" style="display:none;">
		<h1>비밀번호 입력</h1>
		<input type=password name=password><button class="w-btn w-btn-red" id=signUp>가입</button>
	</div>
	<div id="signUpSuccess" style="display:none;">
		<h1 id=mail></h1>
		<h1>회원가입이 완료되었습니다 ! </h1>
		<a href="/"><button class="w-btn w-btn-red">홈으로 이동</button></a>
	</div>
	<div id="loginPassword" style="display:none">
		<h1>비밀번호 입력</h1>
		<input type=password name=loginPassword><button id=login class="w-btn w-btn-red">로그인</button>
	</div>
	<div class="social-login">
		<hr><h1>SNS 로그인</h1>
		<img src="img/kakaologin.png" id="kakaoLogin">
	</div>
</div>
<%@include file="footer.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="js/login.js"></script>
</html>