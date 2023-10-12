<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/home.css" />
<link rel="stylesheet" href="/resources/css/main.css" />
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
									<img class="img-modal"
										src="https://img.hankyung.com/photo/202307/AKR20230724060800056_04_i_P4.jpg">
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

			<!-- db에서 출력 -->
			<ul>
				<c:forEach items="${board}" var="question" varStatus="loop">
					<li><a href="/view?seqno=${question.seqno}"
						${question.seqno}" class="break-word">질문${loop.index + 1}:
							${question.title}</a></li>
				</c:forEach>
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
				<a href="/travel_list" class="plus-button">+</a>


				<!-- db에서 출력 테스트 -->
				<div class="dtCard" data-ta-name="${location[0].ta_name}">
					<a href="travel_Detail?ta_name=${location[0].ta_name}"><img
						src="${location[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${location[0].ta_name}" class="carda">
						${location[0].ta_name} </a>
				</div>

				<!-- db에서 출력 테스트 -->
				<div class="dttcard" data-ta-name="${location[1].ta_name}">
					<a href="travel_Detail?ta_name=${location[1].ta_name }"><img
						src="${location[1].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${location[1].ta_name }" class="carda">
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
				<div class="dtCard2" data-ta-name="${food[0].ta_name}">
					<a href="travel_Detail?ta_name=${food[0].ta_name}"><img
						src="img/${food[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${food[0].ta_name}" class="carda">
						${food[0].ta_name} </a>
				</div>


				<div class="dttcard2" data-ta-name="${food[1].ta_name}">
					<a href="travel_Detail?ta_name=${food[1].ta_name}"><img
						src="img/${food[1].ta_img}" class="testimg1"></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${food[1].ta_name}" class="carda">
						${food[1].ta_name} </a>
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
				<p class="dtKeyword">쇼핑</p>

				<div class="dtCard3" data-ta-name="${shopping[0].ta_name}">
					<a href="travel_Detail?ta_name=${shopping[0].ta_name}"><img
						src="img/${shopping[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${shopping[0].ta_name}" class="carda">
						${shopping[0].ta_name} </a>
				</div>
				<div class="dttcard3" data-ta-name="${shopping[1].ta_name}">
					<a href="travel_Detail?ta_name=${shopping[1].ta_name}"><img
						src="img/${shopping[1].ta_img}" class="testimg1"></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${shopping[1].ta_name }" class="carda">
						${shopping[1].ta_name }</a>
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
				<p class="dtKeyword">숙박</p>

				<div class="dtCard4" data-ta-name="${hotel[0].ta_name}">
					<a href="travel_Detail?ta_name=${hotel[0].ta_name}"><img
						src="img/${hotel[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${hotel[0].ta_name }" class="carda">
						${hotel[0].ta_name }</a>
				</div>
				<div class="dttcard4" data-ta-name="${hotel[1].ta_name}">
					<a href="travel_Detail?ta_name=${hotel[1].ta_name}"><img
						src="img/${hotel[1].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;"
						href="travel_Detail?ta_name=${hotel[1].ta_name}" class="carda">
						${hotel[1].ta_name}</a>
				</div>
			</dt>

			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_coral.png"
					class=dtimg2>
			</dd>


		</dl>
	</div>


	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

<div data-helper-component-key="core-system-row" __directive_pos="0.2" class="_grid-system-row_"><div data-helper-component-key="core-system-column" __directive_pos="0.2.0" class="_grid-system-column_ xs-12 sm-12 md-12 lg-12"><section __directive_pos="0.2.0.0" class="knowledge" data-v-7c539ecc=""><div class="wrapper" data-v-7c539ecc=""><div class="logotype" data-v-7c539ecc=""><img src="/image/knowledge/logotype2.png" alt="제주관광 지식iN" data-v-7c539ecc=""></div><div class="stitle1" data-v-7c539ecc="">제주 여행에 관해서라면 어떤 것이라도 물어 보세요! <br data-v-7c539ecc="">비짓제주 상주 전문가를 비롯해 제주를 잘 아는 사람이라면 누구에게라도 답변 받을 수 있습니다</div><div class="view" data-v-7c539ecc=""><a href="/kr/knowledge/list?menuId=DOM_200000000011003" data-v-7c539ecc="">제주관광 지식iN 바로가기 </a><a href="#" style="background:#e55283;margin-left:20px" data-v-7c539ecc="">질문하기</a></div><div class="new_qna" data-v-7c539ecc=""><h4 data-v-7c539ecc="">신규 질문</h4><div class="best-data" data-v-7c539ecc=""><ul class="list" data-v-7c539ecc=""><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=906#"><strong data-v-7c539ecc="">사라오름에 물이 있을까요?</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 27</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=905#"><strong data-v-7c539ecc="">제주공항에 외국인을 위한 세금 환급 카운터가 있나요?</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 26</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=904#"><strong data-v-7c539ecc="">저지마을 레스토랑 예약은 어떻게하나요?</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 177</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=903#"><strong data-v-7c539ecc="">추울때 가기좋은곳 있을까요?</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 126</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=901#"><strong data-v-7c539ecc="">추석연휴 식당 추천 부탁해요</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 142</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=900#"><strong data-v-7c539ecc=""> 비가 오는 날에 가볼만한 관광명소를 추천해주세요</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 161</li><li data-v-7c539ecc="">답변 : 2</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=899#"><strong data-v-7c539ecc="">박물관은 살아있다 애견동반</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 164</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li><li data-v-7c539ecc=""><a data-v-7c539ecc="" href="/kr/knowledge/view?menuId=DOM_200000000011003&amp;knwld_seq=888#"><strong data-v-7c539ecc="">금오름 분화구에 현재 물 고여있나요?</strong><ul data-v-7c539ecc=""><li data-v-7c539ecc="">조회 : 1581</li><li data-v-7c539ecc="">답변 : 1</li></ul></a></li></ul></div></div></div></section><!----></div><!----></div>


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

<script>
	$(document)
			.ready(
					function() {
						var classNames = [ 'dtCard', 'dtCard2', 'dtCard3',
								'dtCard4', 'dttcard', 'dttcard2', 'dttcard3',
								'dttcard4' ];

						classNames
								.forEach(function(className) {
									$('.' + className)
											.on(
													'click',
													function() {
														var taName = $(this)
																.data('ta-name');
														if (taName) {
															window.location.href = 'travel_Detail?ta_name='
																	+ taName;
														}
													});
								});
					});
</script>

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
