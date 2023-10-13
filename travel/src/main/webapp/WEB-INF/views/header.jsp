<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/member.css" />
<link rel="stylesheet" href="/resources/css/header.css" />
<meta charset="UTF-8">
<title>test</title>
</head>
<body class="main">
	<div class="accessibility">
	    <a href="#main_visual">본문 바로가기</a>
	    <a href="#lnbNav">주메뉴 바로가기</a>
	</div>
	<header class="header" style="border-bottom: 1px solid #f0f0f0;">
    <div class="lnb">
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-93774907-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'UA-93774907-1');
	gtag('config', 'G-SPCBB9EPJR');

</script>
    
    <div class="nav_bg"></div>
    <div class="wrap">
        <h1 class="logo"><a href="/" class="logo_link">제주투어</a></h1>
        <nav id="lnbNav" class="lnb_nav_wrap">
            <h2 class="blind">주메뉴</h2>
            <ul class="lnb_nav">
                <li class="lnb_nav_item n1">
                    <a href="/travel_list" class="lnb_nav_link"><span>여행지</span></a>
                    <ul class="depth2">
                        <li><a href="/travel_list"><span>관광지</span></a></li>
                        <li><a href="/food_store"><span>음식</span></a></li>
                        <li><a href="/stay"><span>숙박</span></a></li>
                        <li><a href="/shopping"><span>쇼핑</span></a></li>
                    </ul>
                </li>
                <li class="lnb_nav_item n2">
                    <a href="#" class="lnb_nav_link"><span>지역별여행</span></a>
                    <ul class="depth2">
                        <li><a href="#"><span>곶자왈</span></a></li>
                        <li><a href="#"><span>오름</span></a></li>
                        <li><a href="#"><span>올레길</span></a></li>
                        <li><a href="#"><span>한라산</span></a></li>
                        <li><a href="#"><span>유네스코</span></a></li>
                        <li><a href="#"><span>우도</span></a></li>
                    </ul>
                </li>
                <li class="lnb_nav_item n3">
                    <a href="#" class="lnb_nav_link"><span>여행준비</span></a>
                    <ul class="depth2">
                        <li><a href="/my_jeju_travel"><span>나만의 제주 여행</span></a></li>
                        <li><a href="https://www.kctg.or.kr/tour/touristSiteList.do" target="_blank"><span>문화관광해설사</span></a></li>
                        <li><a href="https://jejutour.or.kr/"  target="_blank"><span>제주투어</span></a></li>
                    </ul>
                </li>
                <li class="lnb_nav_item n4">
                    <a href="/mypage" class="lnb_nav_link"><span>나의여행</span></a>
                    <ul class="depth2">
                        <li><a href="/mybbs"><span>나의 질문</span></a></li>
                        <li><a href="/myreview"><span>나의 리뷰</span></a></li>
                        <li><a href="/mylike"><span>찜한 여행지</span></a></li>
                        <li><a href="#"><span>제주 방문지</span></a></li>
                        <li><a href="#"><span>정보 수정</span></a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div class="signup">
	        <div class="gnb_site">
	            <button type="button" class="btn">여행자</button>
	            <ul class="list">
	            	<c:if test="${empty id}">
	            		<li><a href="/login"><span>로그인</span></a></li>
	            	</c:if>
	            	<c:if test="${!empty id}">
	            		<li><a href="/logout"><span>로그아웃</span></a></li>
	            	</c:if>
	            </ul>
	        </div>
	    </div>
        </div>
        </div>

        </header>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/resources/js/header.js"></script>
</html>