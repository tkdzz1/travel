<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
	rel="stylesheet">
<title>Insert title here</title>
</head>
<style>
/* 슬라이드 관련 스타일 유지 */
.slide-container {
	position: relative;
	display: flex;
	width: 300vw;
	transition: all 1s;
	transform: translateX(0);
}

.slide-box {
	width: 100vw;
	float: left;
}

.slide-box img {
	width: 100%;
}

.slide-button {
	position: absolute;
	top: 30%;
	transform: translateY(-20%);
	background: rgba(0, 0, 0, 0.5); /* 배경색 추가 */
	border: 1px solid #fff; /* 테두리 스타일 및 색상 설정 */
	font-size: 40px;
	cursor: pointer;
	color: black;
	height: 30px;
	cursor: pointer;
	color: white;
	height: 40px; /* 높이 조정 */
	width: 40px; /* 너비 조정 */
	text-align: center; /* 텍스트 가운데 정렬 */
	line-height: 40px; /* 텍스트 수직 가운데 정렬 */
	border-radius: 10%; /* 원 모양의 모서리로 변경 */
}

.slide2-button {
	position: absolute;
	transform: translateY(100%);
	background: none;
	border: none;
	font-size: 70px;
	cursor: pointer;
	color: black;
}

.slide-button.left {
	left: 10%;
}

.slide-button.right {
	right: 10%;
}

.tex {
	display: flex;
	justify-content: center;
}

.img1text {
	display: flex;
	justify-content: center;
	font-weight: bold;
	font-size: 20px;
}

.img1 {
	width: 825px;
	height: 420px;
	margin-right: 50px;
	border-radius: 10px;
}

.img2 {
	width: 420px;
	height: 420px;
	border-radius: 10px;
}

.img21 {
	width: 420px;
	height: 420px;
	display: none;
}

.img31 {
	width: 420px;
	height: 420px;
	display: none;
}

.img21.active {
	display: block;
}

.img 31.active {
	display: block;
}

.img3 {
	width: 260px;
	height: 140px;
	position: relative;
	top: 0;
	border-radius: 10px;
}

.test {
	display: flex;
	margin-left: 15.7%;
}

.img4 {
	width: 260px;
	height: 140px;
	position: relative;
	border-radius: 10px;
}

.img5 {
	width: 260px;
	height: 140px;
	position: relative;
	border-radius: 10px;
}

.card {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-right: 1.02%;
	border: 1px solid black;
	border-radius: 10px;
	width: 267px;
	height: 270px;
}

@font-face {
	font-family: 'GongGothicMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.card-text {
	/*
	card의 사진 아래의 text
	*/
	font-family: 'GongGothicMedium';
	text-align: center;
	flex-grow: 1; /* 내용에 따라 높이가 자동으로 조절 */
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 10px;
	padding: 3px;
}

.undermini {
	margin-left: 65%;
}

@font-face {
	font-family: 'HakgyoansimWoojuR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/HakgyoansimWoojuR.woff2')
		format('woff2');
	font-weight: normal;
	font-style: normal;
}

.undermini a {
	font-family: 'HakgyoansimWoojuR';
}

.minibox {
	/*
	버튼 클릭시 넘어가는 사진 아래에 있는 문구
	*/
	border: 1px solid black;
	border-radius: 10px;
	display: inline-block;
	position: relative;
	bottom: 250px;
}

.minibox3 {
	border: 1px solid black;
	border-radius: 10px;
	display: inline-block;
	position: relative;
	bottom: 220px;
	margin-right: 30px;
}

.bigboard {
	width: 1290px;
	height: 400px;
	margin: 0 auto;
	padding: 40px 0;
	border: 1px solid black;
	border-radius: 10px;
	background-color: #E0F2F7;
}

.dtimg {
	/*
	첫번째,세번째 dt 말풍선 모양 이미지 ( 작은 삼각형)
	*/
	position: relative;
	left: 625px;
	bottom: 170px;
}

.dtimg2 {
	/*
	두번째,네번째 dt 말풍선 모양 이미지 ( 작은 삼각형)
	*/
	position: relative;
	bottom: 160px;
	left: 1153px;
}

.firstdt {
	/*
	첫번째 dt 
	*/
	background: #385693;
	width: 300px;
	height: 300px;
	border-radius: 30px;
	margin-left: 365px;
}

/*
	세번째 dt 
	*/
.second-instance {
	background-color: #8b9c1c;
}

.seconddt {
	/*
	두번째 dt 
	*/
	background: #59a193;
	width: 300px;
	height: 300px;
	border-radius: 30px;
	margin-left: auto; /* 화면 오른쪽에 배치 */
	margin-right: 380px;
}

.fourth-instance {
	background-color: #ef6d00;
}

.board {
	margin-left: 50px;
	margin-right: 10px;
	margin-top: 50px;
	margin-bottom: 80px;
	background-color: white;
	border-radius: 20px;
	height: 300px;
	width: 1200px;
	text-align: center;
}

.board li {
	margin-left: 5%;
	list-style: circle;
	margin-bottom: 5%;
}

@font-face {
	font-family: 'S-CoreDream-3Light';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.board a {
	color: black;
	text-decoration: none;
	font-family: 'S-CoreDream-3Light';
	font-weight: 300;
}

.board a:hover {
	text-decoration: underline;
}

@font-face {
	font-family: 'GmarketSansMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.newq {
	/*
	new question 
	*/
	font-size: 25px;
	text-decoration: none !important;
	font-weight: bold !important;
	font-family: 'GmarketSansMedium' !important;
}

.newq2 {
	/*
	show all question 
	*/
	font-weight: bold !important;
	font-family: 'GmarketSansMedium' !important;
	font-size: 15px;
	text-align: right;
	cursor: pointer;
	border: 1px solid black;
	background-color: white;
}

.newq1 {
	font-weight: bold !important;
	font-family: 'GmarketSansMedium' !important;
	font-size: 15px;
	text-align: left;
	cursor: pointer;
	border: 1px solid black;
	background-color: white;
}

.newq2:hover {
	background-color: #D8D8D8;
}

.newq1:hover {
	background-color: #D8D8D8;
}

.fornewq2 {
	text-align: right;
	margin-right: 10%;
}

.dtTitle {
	font-size: 26px;
	line-height: 28px;
	margin: 5px 0 30px;
}

.dtKeyword {
	font-weight: 700;
	font-size: 42px;
	line-height: 46px;
	margin: 10px 0 0;
}

.dth2 {
	font-size: 14px;
	line-height: 50px;
	margin: 30px 0 5px;
}

.dta {
	display: block;
	position: absolute;
	top: 0;
	left: 50%;
	width: 25px;
	height: 25px;
	background: url(https://www.visitjeju.net/image/main/btn_plus.png)
		no-repeat;
	margin-left: -12px;
	text-indent: -9999px;
}

.plus-button {
	display: inline-block;
	width: 40px;
	height: 40px;
	text-align: center;
	line-height: 35px;
	border: 2px solid grey; /* 테두리 스타일 및 색상 설정 */
	text-decoration: none; /* 밑줄 제거 */
	color: #000; /* 플러스 모양 색상 설정 */
	font-size: 50px; /* 플러스 모양의 글꼴 크기 설정 */
	margin-top: 50px;
}

.plus-button:hover {
	background-color: #000; /* 마우스 호버 시 배경색 변경 */
	color: #fff; /* 플러스 모양 색상 변경 */
}

@font-face {
	font-family: 'SUITE-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2')
		format('woff2');
	font-weight: 400;
	font-style: normal;
}

.beforedt {
	font-family: 'SUITE-Regular';
	font-size: 20px;
}

.mainh2 {
	font-family: 'SUITE-Regular';
	font-size: 40px;
}

.dtCard {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	left: 140%;
	bottom: 282px;
	text-align: center
}

.dttcard {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	left: 280%;
	bottom: 584px;
	text-align: center
}

.dttcard3 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	left: 280%;
	bottom: 489px;
	text-align: center;
	color: black;
	font-family: 'LINESeedKR-Bd';
}

.dttcard3 a {
	color: black;
}

.dttcard2 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	text-align: center;
	bottom: 486px;
	right: 280.5%;
	color: black;
	font-family: 'LINESeedKR-Bd';
}

.dttcard2 a {
	color: black;
}

.dttcard4 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	text-align: center;
	bottom: 489px;
	right: 280.5%;
	color: black;
	font-family: 'LINESeedKR-Bd';
}

.dtCard2 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	right: 139.5%;
	bottom: 184px;
	text-align: center
}

.dtCard3 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	left: 140%;
	bottom: 187px;
	text-align: center
}

.dtCard4 {
	position: relative;
	width: 300px;
	height: 300px;
	border: 1px solid grey;
	border-radius: 20px;
	right: 140%;
	bottom: 187px;
	text-align: center
}

.dtCard4 a {
	color: black;
	margin-top: 20px;
}

.dttcard4 a {
	color: black;
}

@font-face {
	font-family: 'LINESeedKR-Bd';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
}

.dtCard a {
	font-family: 'LINESeedKR-Bd';
	color: black;
}

.dttcard a {
	font-family: 'LINESeedKR-Bd';
	color: black;
}

.dtCard2 a {
	font-family: 'LINESeedKR-Bd';
	color: black;
}

.dtCard3 a {
	font-family: 'LINESeedKR-Bd';
	color: black;
}

.dtCard4 a {
	font-family: 'LINESeedKR-Bd';
	color: black;
}

.testimg1 {
	width: 298px;
	height: 190px;
	border-radius: 20px;
}

.texbtn {
	text-align: right;
	margin-right: 26%;
}

#showprev {
	position: absolute;
	right: 35%; /* 조절 가능한 왼쪽 위치 조정 */
	transform: translateY(-600%);
	background: rgba(0, 0, 0, 0.5); /* 배경색 추가 */
	border: 2px solid #fff; /* 테두리 스타일 및 색상 설정 */
	font-size: 40px;
	cursor: pointer;
	color: white;
	height: 40px; /* 높이 조정 */
	width: 40px; /* 너비 조정 */
	text-align: center; /* 텍스트 가운데 정렬 */
	line-height: 40px; /* 텍스트 수직 가운데 정렬 */
	border-radius: 50%; /* 원 모양의 모서리로 변경 */
	z-index: 2;
}

#shownext {
	position: absolute;
	right: 16.7%; /* 조절 가능한 왼쪽 위치 조정 */
	transform: translateY(-600%);
	background: rgba(0, 0, 0, 0.5); /* 배경색 추가 */
	border: 2px solid #fff; /* 테두리 스타일 및 색상 설정 */
	font-size: 44px;
	cursor: pointer;
	color: white;
	height: 40px; /* 높이 조정 */
	width: 40px; /* 너비 조정 */
	text-align: center; /* 텍스트 가운데 정렬 */
	line-height: 40px; /* 텍스트 수직 가운데 정렬 */
	border-radius: 50%; /* 원 모양의 모서리로 변경 */
	z-index: 2;
}

.carda {
	font-size: 20px;
	position:relative;
	top:10%;
}

.carda:hover {
	color: #F7BE81;
}

.testimg1:hover .carda {
	color: #F5D0A9;
}

.reviewContents {
	background-color: #282828;
	border: 1px solid black;
	padding: 50px 0 70px;
	text-align: center;
	overflow: hidden;
}

.mainContents {
	width: 1290px;
	margin: 0 auto;
	min-height: 100px;
}

.rvh2 {
	color: white;
	font-size: 35px;
}

.rvh3 {
	margin-top: 20px;
	font-size: 20px;
	color: #8a8b8b;
	line-height: 1;
}

.reviewimg {
	height: 161px;
	width: 161px;
	border: 2px solid transparent; /* 기본적으로 투명 테두리 설정 */
}

.reviewimg:hover {
	border: 2px solid #5858FA; /* 원하는 테두리 스타일 및 두께 설정 */
}

.imgsdiv {
	height: 497px;
	width: 322px;
	background-color: #3c3c3c;
	float: left;
	margin-left: 3px;
	cursor: pointer;
	border: 2px solid transparent;
}

.imgsdiv2 {
	float: left;
	margin-left: 3px;
}

.reviewimg2 {
	height: 332px;
	width: 322px;
	border: 2px solid transparent;
}

.reviewimg2:hover {
	border: 2px solid #5858FA;
}

@font-face {
	font-family: 'S-CoreDream-3Light';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.imgsdiv a {
	position: absolute;
	left: 35%;
	margin-top: 2%;
	color: white;
	font-family: 'S-CoreDream-3Light';
}

.rvimg {
	float: left;
	margin: 0;
	padding: 0;
}

.imgsdiv:hover {
	border: 2px solid #5858FA;
}

.lastimg {
	margin-right: 8%;
}

.lastcomment {
	display: inline-block;
	border: 1px solid grey;
	margin-top:5%;
}

.lastcomment:hover {
	background-color: #A4A4A4;
	cursor:pointer;
}

.card:hover {
	border:1px solid green;
}




</style>
<body>
<%-- 	<%@include file="header.jsp"%> --%>

	<div style="overflow: hidden">
		<div class="slide-container">
			<div class="slide-box">
				<img src="img/캐러셀 실험1.jpg" />
			</div>
			<div class="slide-box">
				<img src="img/캐러셀 실험2.jpg" />
			</div>
			<div class="slide-box">
				<img src="img/캐러셀 실험3.jpg" />
			</div>
		</div>
	</div>

	<div class="forcarbtn">
		<button class="slide-button left">&lt;</button>
	</div>
	<div>
		<button class="slide-button right">&gt;</button>
	</div>

	<br>

	<div class="img1text">
		<a>About JeJu Island Content</a>
	</div>
	<br>



	<div class="tex">
		<a href="#"> <img src="img/테스트1.jpg" class="img1">
		</a> <img src="img/테스트2.jpg" class="img2"></a> <img src="img/테스트2-2.jpg"
			class="img21"> </a> <img src="img/테스트2-3.jpg" class="img31">
		</a>
	</div>

	<div class="texbtn">
		<input type="button" id="showprev" value="<"> <input
			type="button" id="shownext" value=">">
	</div>




	<br>




	<div class="test">
	
		<div class="card" id="card1">
			<a href="#"><img src="img/테스트3.jpg" class="img3"></a>
			<div class="card-text">
				<a>테스트3 사진에 관한 설명 테스트 테스트 테스트 테스트 테스트 테스트</a>
			</div>
		</div>
		
		
		<div class="card" id="card1">
			<a href="#"><img src="img/테스트4.jpg" class="img4"> </a>
			<div class="card-text">
				<a>테스트4 사진에 관한 설명 추가</a>
			</div>
		</div>
		
		
		<div class="card" id="card1">
			<a href="#"><img src="img/테스트5.jpg" class="img5"> </a>
			<div class="card-text">
				<a>테스트5 사진에 관한 설명 추가</a>
			</div>
		</div>
		
	</div>



	<div class="undermini">
		<div class="minibox" style="margin-right: 50px;">
			<a>mini img에 관한 설명</a>
		</div>
		<div class="minibox">
			<a>mini img에 관한 부가 설명</a>
		</div>
		<br>
		<div class="minibox3">
			<a>mini img에 관한 부가 설명2</a>
		</div>
		<div class="minibox3">
			<a>mini img에 관한 부가 설명3</a>
		</div>
	</div>

	<!-- .undermini 에서, margin-left css로 부가 설명들의 위치 조정 가능 -->

	<br>
	<br>




	<div class="bigboard">
		<div class="board">
			&nbsp;&nbsp;<strong><a class="newq">New Question</a></strong> <br>
			<div class="fornewq2">
				<a href="#" class="newq1">Ask Question</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/q&a" class="newq2">Show All Question</a>
			</div>
			<br>
			<br>
			<ul style="display: flex;">
				<li><a href="#">질문1: 제주도가는방법</a>
				<li><a href="#">질문2: 제주도맛집</a>
				<li><a href="#">질문3: 제주도 해수욕장</a>
				<li><a href="#">질문4: 제주도 날씨</a>
				<li><a href="#">질문5: 제주도 핫플</a>
			</ul>
			<ul style="display: flex">
				<li><a href="#">질문6:페이지 이벤트</a>
				<li><a href="#">질문6:페이지 이벤트</a>
				<li><a href="#">질문6:페이지 이벤트</a>
				<li><a href="#">질문6:페이지 이벤트</a>
			</ul>
		</div>
	</div>

	<br>
	<br>
	<br>

	<hr />
	<br>
	<h2 align=center class="mainh2">개인별 맞춤 여행</h2>
	<p align=center class="beforedt">개개인에 맞춰진 여행 코스 추천</p>
	<br>
	<br>
	<br>



	<div class="bigboard2">
		<dl>

			<dt align="center" style="color: white" class="firstdt">
				<h2 class="dth2">For Tour Contents</h2>
				<p class="dtTitle">Recommend JeJu Island LandMark</p>
				<p class="dtKeyword">여행지</p>
				<a href="#" class="plus-button">+</a>


				<!-- db에서 출력 테스트 -->
				<div class="dtCard">
					<a href="#"><img src="${location[0].ta_img}" class="testimg1" /></a>
					<a style="text-decoration: none;" href="#" class="carda">
						${location[0].ta_name} </a>
				</div>

				<!-- db에서 출력 테스트 -->
				<div class="dttcard">
					<a href="#"><img src="${location[1].ta_img}" class="testimg1" /></a>
					<a style="text-decoration: none;" href="#" class="carda">
						${location[1].ta_name} </a>
				</div>


				

			</dt>

			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_blue.png"
					class="dtimg">


			</dd>
			<br>






			<dt align=center style="color: white" class="seconddt">
				<h2 class="dth2">For Tour Contents</h2>
				<p class="dtTitle">Recommend JeJu Island Restaurant</p>
				<p class="dtKeyword">맛집추천</p>


				<!-- db에서 출력 테스트 -->
				<div class="dtCard2">
					<a href="#"><img src="img/${restaurant[0].fs_img}"
						class="testimg1" /></a> <a style="text-decoration: none;" href="#"
						class="carda"> ${restaurant[0].fs_name} </a>
				</div>


				<div class="dttcard2">
					<a href="#"><img src="img/${restaurant[1].fs_img}"
						class="testimg1"></a> <a style="text-decoration: none;" href="#"
						class="carda"> ${restaurant[1].fs_name} </a>
				</div>


			</dt>
			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_emer.png"
					class=dtimg2>
			</dd>

			<br>

			<dt align="center" style="color: white"
				class="firstdt second-instance">
				<h2 class="dth2">For Tour Contents</h2>
				<p class="dtTitle">Recommend JeJu Island beach</p>
				<p class="dtKeyword">해수욕장</p>

				<div class="dtCard3">
					<a href="#"><img src="img/이미지테스트.jpg" class="testimg1" /></a> <a
						style="text-decoration: none;" href="#" class="carda">Traditional
						Market</a>
				</div>

				<div class="dttcard3">
					<a href="#"><img src="img/이미지테스트.jpg" class="testimg1"></a> <a
						style="text-decoration: none;" href="#" class="carda">Other
						Traditional Market</a>
				</div>

			</dt>

			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_green.png"
					class="dtimg">

			</dd>

			<br>


			<dt align=center style="color: white"
				class="seconddt fourth-instance">
				<h2 class="dth2">For Tour Contents</h2>
				<p class="dtTitle">Recommend JeJu Island Restaurant</p>
				<p class="dtKeyword">맛집추천</p>

				<div class="dtCard4">
					<a href="#"><img src="img/이미지테스트.jpg" class="testimg1" /></a> <a
						style="text-decoration: none;" href="#" class="carda">Special
						Product</a>
				</div>
				<div class="dttcard4">
					<a href="#"><img src="img/이미지테스트.jpg" class="testimg1" /></a> <a
						style="text-decoration: none;" href="#" class="carda">Other
						Special Product</a>
				</div>
			</dt>

			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_coral.png"
					class=dtimg2>
			</dd>

			<br>
			<br>
			<br>



			<div class="reviewContents">
				<!-- 추가로 만들예정 -->

				<div class="mainContents">

					<h2 class="rvh2">공유된 사진들 모음</h2>
					<h3 class="rvh3">실제 방문자들의 후기</h3>
					<br>
					<br>
					<br>
					<div class="rvimg">
						<a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202309/03/140c121c-1ca2-4e54-ba54-35ea00c3581f.jpg"
							class="reviewimg"></a> 
							
							<a href="#">
							<img src="img/테스트1.jpg"
							class="reviewimg"></a> 
							
							<br> 
							
							<a href="#"><img
							src="img/테스트2.jpg" class="reviewimg"></a> 
							<a href="#"><img
							src="img/테스트4.jpg" class="reviewimg"></a> 
							
							<br>
							<a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202203/31/455419bb-d548-48fe-85f3-5aa73058af11.jpg"
							class="reviewimg"></a>
							
							<a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202203/31/455419bb-d548-48fe-85f3-5aa73058af11.jpg"
							class="reviewimg"></a>
							
					</div>


					<div class="imgsdiv">
						<a>이미지 설명</a> 
						
						<br><br><br> 
						
						<a>#키워드</a>
						 
					<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> 
						<a style="text-decoration: none;">바로가기</a>
					</div>









					<div class="imgsdiv2">
						<a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202204/22/873066d6-38de-49a3-b884-1388d8ec12d3.jpg"
							class="reviewimg2" style="width: 343px;"></a>

					</div>

					<div class="rvimg" style="margin-left: 0.2%;">
						<a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202203/31/455419bb-d548-48fe-85f3-5aa73058af11.jpg"
							class="reviewimg"></a>

					</div>

					<div class="rvimg">
						<a href="#"><img src="img/테스트2.jpg" class="reviewimg"
							style="margin-left: 4px; margin-right: 5px;"></a> <a href="#"><img
							src="https://api.cdn.visitjeju.net/photomng/thumbnailpath/202203/31/455419bb-d548-48fe-85f3-5aa73058af11.jpg"
							class="reviewimg" style="margin-right: 8px;"></a>
					</div>

					<div class="rvimg">
						<a href="#"><img src="img/테스트3.jpg" class="reviewimg"></a>
					</div>

					<div class="lastimg">
						<a href="#"><img src="img/테스트4.jpg" class="reviewimg"></a>
					</div>



					<div class="lastcomment">	
							<h2 style="color: white; text-decoration: underline;  font-family: 'S-CoreDream-3Light'; text-underline-position : under;">
							더 많은 공유 보러가기</h2>					
					</div>


				</div>


			</div>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<%-- 			<%@include file="footer.jsp"%> --%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
	
	
	
	$('.imgsdiv').click(function(){
		window.location.href="#";
	})
	
	
	
	
	
	
	
	
	
	
	
	
    var currentIndex = 0;

    // 이미지 슬라이드 관련 코드
    $('.slide-button.left').on('click', function () {
        currentIndex = (currentIndex + 2) % 3;
        var translateX = -currentIndex * 100;
        $('.slide-container').css('transform', 'translateX(' + translateX + 'vw)');
    });

    $('.slide-button.right').on('click', function () {
        currentIndex = (currentIndex + 1) % 3;
        var translateX = -currentIndex * 100;
        $('.slide-container').css('transform', 'translateX(' + translateX + 'vw)');
    });

    
    
    
    
    var currentIndex = 0;
    var imageSources = [
        'img/테스트2.jpg',
        'img/테스트2-2.jpg',
        'img/테스트2-3.jpg'
    ];

   

    $('#showprev').click(function () {
        currentIndex = (currentIndex - 1 + imageSources.length) % imageSources.length;
        $('.img2').attr('src', imageSources[currentIndex]);
    });

    $('#shownext').click(function () {
        currentIndex = (currentIndex + 1) % imageSources.length;
        $('.img2').attr('src', imageSources[currentIndex]);
    });
    
    
    
    

    
    
    
    
    
    

    
   
   
});
</script>
</html>
