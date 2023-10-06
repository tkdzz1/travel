<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/home.css" />
<meta charset="UTF-8">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css"
	rel="stylesheet">
<title>TRAVEL JEJU</title>
</head>
<%@ include file="header.jsp"%>

<body class="main">
	<script type="text/javascript">
		var tagListJson = [ "제주투어", " 제주힐링여행", " 가을여행", " 사진찍기좋은", " 힐링하기좋은",
				" 캠핑하기좋은", " 데이트명소", " 자연관광지", " 걷기좋은길", " 트레킹", " 유네스코",
				" 바다", " 섬\r\n\t" ];
	</script>

	<main id="mainContent" class="main-container">
		<section id="main_visual" class="main_visual">
			<h2 class="blind">메인 비주얼</h2>

			<div class="list">

				<div class="item">
					<a href="#" class="link"
						style="background-image: url(https://api.cdn.visitjeju.net/imageResource/file/202309/04/1dff359d-ec60-4dfd-923f-b11a301ed4eb.jpg)">
						<span class="blind">카름스테이</span> <span class="text">마음을 채우는
							제주 마을여행</span>

					</a>
				</div>

				<div class="item">
					<a href="#" class="link"
						style="background-image: url(https://api.cdn.visitjeju.net/imageResource/file/202308/28/2ecd4065-8db2-4c93-a703-c9bd431318e6.jpg)">
						<span class="blind">제주도</span> <span class="text">제주, 가을에
							취하다</span>

					</a>
				</div>

				<div class="item">
					<a href="#" class="link"
						style="background-image: url(https://www.visitjeju.net/image/main/theme/theme01_0911.jpg)">
						<span class="blind">노포 이미지</span> <span class="text">세월을 품은
							제주 노포투어</span>

					</a>
				</div>

				<div class="item">
					<a href="#" class="link"
						style="background-image: url(https://gi.esmplus.com/contworld/Korea/Jeju/private/1-3%EC%86%A1%EC%95%85%EC%82%B0.jpg)">
						<span class="blind"> 이미지</span> <span class="text">나도 여행작가!
							계절따라 올레</span>

					</a>
				</div>

			</div>
			<div class="play_buttons">
				<button type="button" class="btn play" tabindex="-1">
					<span class="blind">재생</span>
				</button>
				<button type="button" class="btn pause active">
					<span class="blind">정지</span>
				</button>
			</div>
		</section>

		<form id="frmSearch" name="frmSearch" method="post" action="">
			<div style="display: none;">
				<input type="text" class="text">
			</div>
			<section class="search_form wrap" id="searchContent">
				<h2 class="blind">통합검색</h2>
				<fieldset>
					<legend>통합검색</legend>
					<div class="search_wrap">
						<label for="total_search" class="blind">검색어 입력</label> <input
							type="search" name="ipt_intgrfind_kword" id="total_search"
							class="text" placeholder="검색어를 입력해 주세요."> <input
							type="button" id="btn_total_search" name="ipt_intgrfind_kword"
							value="검색" class="search_submit">
					</div>
				</fieldset>
			</section>
		</form>
		<!-- 날씨 -->
	</main>
	<div class="wrap">
		<section class="popular_tour">
			<h2 class="section_title">
				<span>요즘인기!</span> <strong>제주투어</strong>
			</h2>
			<ul class="list">

				<li class="item">
					<div class="photo">
						<img
							src="https://img.hankyung.com/photo/202307/AKR20230724060800056_04_i_P4.jpg"
							alt="트리플스트리트 이미지">
					</div>
					<div class="content">
						<div class="subject">
							<div class="buttons">
								<a href="javascript:void(0);" id="one" class="button">낭만이
									넘실대는 제주도 여행</a>
							</div>
						</div>
					</div>
					<div id="Mymodal">
						<div id="modal-container">
							<div class="modal-background">
								<div class="modal">
									<h2>당장 올레로 안 올레?</h2>
									<img class="img-modal" src="/resources/img/1694999996855.png">
								</div>
							</div>
						</div>
					</div>
					<div class="tag">#제주여행&nbsp; #제주도&nbsp; #제주가볼만한곳&nbsp;
						#제주도여행&nbsp; #혼저옵서예&nbsp; #제주도&nbsp;</div>
				</li>

				<li class="item">
					<div class="photo">
						<img
							src="https://api.cdn.visitjeju.net/photomng/imgpath/202110/27/b812c376-e5e8-449a-b80b-db5c425ea590.jpg"
							alt="제주도동문시장이미지">
					</div>
					<div class="content">
						<div class="subject">
							<div class="buttons">
								<a href="javascript:void(0);" id="two" class="button">제주동문시장
									먹거리 뽀개기</a>
							</div>
						</div>
					</div>
					<div id="Mymodal">
						<div id="modal-container">
							<div class="modal-background">
								<div class="modal">
									<h2>놀러오세요, 제주전통시장</h2>
									<img class="img-modal" src="/resources/img/1694999996855.png">
								</div>
							</div>
						</div>
					</div>
					<div class="tag">#제주시장.전통시장여행&nbsp; #맛집탐방&nbsp; #제주맛집&nbsp;
						#시장맛집&nbsp; #제주동문시장&nbsp; #감귤디저트 &nbsp; #우도땅콩 &nbsp;</div>
				</li>

				<li class="item">
					<div class="photo">
						<img
							src="https://api.cdn.visitjeju.net/photomng/imgpath/201811/02/906536a1-b214-4797-9879-231f4a62f20c.jpg"
							alt="캠핑장이미지">
					</div>
					<div class="content">
						<div class="subject">
							<div class="buttons">
								<a href="javascript:void(0);" id="three" class="button">제주의
									캠핑 핫플</a>
							</div>
						</div>
					</div>
					<div id="Mymodal">
						<div id="modal-container">
							<div class="modal-background">
								<div class="modal">
									<h2>낭만의 캠프를 즐기러 제주도로</h2>
									<img class="img-modal" src="/resources/img/1694999996855.png">
								</div>
							</div>
						</div>
					</div>
					<div class="tag">#캠핑,캠핑여행&nbsp; #제주캠핑명소&nbsp; #어라운드_폴리&nbsp;
						#서귀포자연휴양림캠핑장&nbsp; #김녕성세기해변캠핑장&nbsp;</div>
				</li>


				<li class="item">
					<div class="photo">
						<img
							src="https://media.bunjang.co.kr/product/177600551_1_1643548856_w320.jpg"
							alt="jokebear">
					</div>
					<div class="content">
						<div class="subject">
							<div class="buttons">
								<a href="javascript:void(0);" id="four" class="button">속보,
									농담곰 증명사진</a>
							</div>
						</div>
					</div>
					<div id="Mymodal">
						<div id="modal-container">
							<div class="modal-background">
								<div class="modal">
									<h2>농담곰 좋아해?</h2>
									<img class="img-modal"
										src="https://blog.kakaocdn.net/dn/dXXwDW/btqF7tvF59G/fiZ7XKp3JpiQcnBn5J3VE1/img.gif">
								</div>
							</div>
						</div>
					</div>
					<div class="tag">#농담곰&nbsp; #뭔가멍청해보임&nbsp; #담며들다&nbsp;
						#SNS인기담곰&nbsp; #jokebear&nbsp; #담곰귀여움 &nbsp;</div>
				</li>

			</ul>
		</section>

	</div>

	<div class="bigboard">
		<div class="board">
			&nbsp;&nbsp;<strong><a class="newq">New Question</a></strong> <br>
			<div class="fornewq2">
				<a href="/write" class="newq1">Ask Question</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/q&a" class="newq2">Show All Question</a>
			</div>
			<br> <br>
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

		</dl>
	</div>


	<div class="side_banner">
		<div class="item qna">
			<button type="button" class="btn_chat">
				<img
					src="https://i1.daumcdn.net/thumb/C230x300/?fname=https://blog.kakaocdn.net/dn/croWTw/btrVzKu6YpE/LZshVNGiAaUUckt5Pyfby0/img.gif"
					alt="1330 여행상담">
			</button>
		</div>
		<button type="button" class="close">사이드베너 닫기</button>
	</div>
	<div class="chat">
		<div class="title">농담곰</div>
		<div class="text">모두 물떡이 되어보세요</div>
		<div class="group n1">
			<a href="javascript:;" onclick="openTtalk2();" class="link"
				title="새창열림" tabindex="-1">바로 채팅장 열기 <br> <span
				class="gray">(자체 채팅 앱)</span></a>
		</div>
		<div class="group n2">
			<a href="https://twitter.com/ngntrtr" onclick="href.location='#'"
				class="link" title="농담곰" tabindex="-1">농담곰이 되어보기<span
				class="gray">(나가노 작가 블로그)</span></a>
		</div>
		<button type="button" class="close" tabindex="-1">실시간 문자채팅 닫기</button>
	</div>
	 
	<script>
		    function openTtalk2() {
			window
					.open(
							'https://1330chat.visitkorea.or.kr:3000/#/ttalk_main/CHAT1330_160635739001093018/_0300_0100_PAGENAME',
							"ttalkFrame",
							"width=500, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes, fullscreen=yes ");
		}
    
	</script>

	<script>
		    (function() {
			function ttalk_load() {
				var s = document.createElement("script");
				s.type = "text/javascript";
				s.async = true;
				s.src = "https://1330chat.visitkorea.or.kr/ttalk/js/ttalkDev.js";
				s.charset = "UTF-8";
				var x = document.getElementsByTagName("script")[0];
				x.parentNode.insertBefore(s, x);
			}
			if (document.readyState === "complete") {
				ttalk_load();
			} else if (window.attachEvent) {
				window.attachEvent("onload", ttalk_load);
			} else {
				window.addEventListener("DOMContentLoaded", ttalk_load, false);
			}
		})();
		var ttalk_option = {
			"uuid" : "CHAT1330_160635739001093018",
			"button" : "ttalk_quick",
			"extra" : "_0400_0100_PAGENAME"
		};
	</script>


	<%@include file="footer.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/resources/js/home.js"></script>
<!-- 
<script>
	$(document)
			.ready(
					function() {

						$('.imgsdiv').click(function() {
							window.location.href = "#";
						})

						var currentIndex = 0;

						// 이미지 슬라이드 관련 코드
						$('.slide-button.left')
								.on(
										'click',
										function() {
											currentIndex = (currentIndex + 2) % 3;
											var translateX = -currentIndex * 100;
											$('.slide-container').css(
													'transform',
													'translateX(' + translateX
															+ 'vw)');
										});

						$('.slide-button.right')
								.on(
										'click',
										function() {
											currentIndex = (currentIndex + 1) % 3;
											var translateX = -currentIndex * 100;
											$('.slide-container').css(
													'transform',
													'translateX(' + translateX
															+ 'vw)');
										});

						var currentIndex = 0;
						var imageSources = [ 'img/테스트2.jpg', 'img/테스트2-2.jpg',
								'img/테스트2-3.jpg' ];

						$('#showprev')
								.click(
										function() {
											currentIndex = (currentIndex - 1 + imageSources.length)
													% imageSources.length;
											$('.img2').attr('src',
													imageSources[currentIndex]);
										});

						$('#shownext').click(
								function() {
									currentIndex = (currentIndex + 1)
											% imageSources.length;
									$('.img2').attr('src',
											imageSources[currentIndex]);
								});

					});
</script> -->
</html>
