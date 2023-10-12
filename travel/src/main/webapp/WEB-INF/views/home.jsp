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
var tagListJson = ["제주투어"," 제주힐링여행"," 가을여행"," 사진찍기좋은"," 힐링하기좋은"," 캠핑하기좋은"," 데이트명소"," 자연관광지"," 걷기좋은길"," 트레킹"," 유네스코"," 바다"," 섬\r\n\t"];
</script>

<main id="mainContent" class="main-container">
    <section id="main_visual" class="main_visual">
        <h2 class="blind">메인 비주얼</h2>
        
        <div class="list">
        	
            <div class="item">
            	<a href="#"  class="link" style="background-image: url(https://api.cdn.visitjeju.net/imageResource/file/202309/04/1dff359d-ec60-4dfd-923f-b11a301ed4eb.jpg)">
            		<span class="blind">카름스테이</span>
            		
            		<span class="text">마음을 채우는 제주 마을여행</span>
            		
            	</a>
            </div>
            
            <div class="item">
            	<a href="#"  class="link" style="background-image: url(https://api.cdn.visitjeju.net/imageResource/file/202308/28/2ecd4065-8db2-4c93-a703-c9bd431318e6.jpg)">
            		<span class="blind">제주도</span>
            		
            		<span class="text">제주, 가을에 취하다</span>
            		
            	</a>
            </div>
            
            <div class="item">
            	<a href="#"  class="link" style="background-image: url(https://www.visitjeju.net/image/main/theme/theme01_0911.jpg)">
            		<span class="blind">노포 이미지</span>
            		
            		<span class="text">세월을 품은 제주 노포투어</span>
            		
            	</a>
            </div>
            
            <div class="item">
            	<a href="#"  class="link" style="background-image: url(https://gi.esmplus.com/contworld/Korea/Jeju/private/1-3%EC%86%A1%EC%95%85%EC%82%B0.jpg)">
            		<span class="blind"> 이미지</span>
            		
            		<span class="text">나도 여행작가! 계절따라 올레</span>
            		
            	</a>
            </div>
            
        </div>
        <div class="play_buttons">
            <button type="button" class="btn play" tabindex="-1"><span class="blind">재생</span></button>
            <button type="button" class="btn pause active" ><span class="blind">정지</span></button>
        </div>
    </section>
    
    <form id="frmSearch" name="frmSearch" method="post" action="">
	<div style="display:none;">
    	<input type="text" class="text" >
     </div>
    <section class="search_form wrap" id="searchContent">
        <h2 class="blind">통합검색</h2>
            <fieldset>
                <legend>통합검색</legend>
                <div class="search_wrap">
                    <label for="total_search" class="blind">검색어 입력</label>
                    <input type="search" name="ipt_intgrfind_kword" id="total_search" class="text" placeholder="검색어를 입력해 주세요.">
                    <input type="button" id="btn_total_search" name="ipt_intgrfind_kword" value="검색" class="search_submit">
                </div>
            </fieldset>
    </section>
    </form>
</main>
<!-- end  -->
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
        <li><a href="/view?seqno=${question.seqno}"${question.seqno}" class="break-word">질문${loop.index + 1}: ${question.title}</a></li>
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
					<a href="travel_Detail?ta_name=${location[0].ta_name}"><img src="${location[0].ta_img}" class="testimg1" /></a>
					<a style="text-decoration: none;" href="travel_Detail?ta_name=${location[0].ta_name}" class="carda">
						${location[0].ta_name} </a>
				</div>

				<!-- db에서 출력 테스트 -->
				<div class="dttcard" data-ta-name="${location[1].ta_name}">
					<a href="travel_Detail?ta_name=${location[1].ta_name }"><img src="${location[1].ta_img}" class="testimg1" /></a>
					<a style="text-decoration: none;" href="travel_Detail?ta_name=${location[1].ta_name }" class="carda">
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
					<a href="travel_Detail?ta_name=${food[0].ta_name}"><img src="img/${food[0].ta_img}"
						class="testimg1" /></a> <a style="text-decoration: none;" href="travel_Detail?ta_name=${food[0].ta_name}"
						class="carda"> ${food[0].ta_name} </a>
				</div>


				<div class="dttcard2" data-ta-name="${food[1].ta_name}">
					<a href="travel_Detail?ta_name=${food[1].ta_name}"><img src="img/${food[1].ta_img}"
						class="testimg1"></a> <a style="text-decoration: none;" href="travel_Detail?ta_name=${food[1].ta_name}"
						class="carda"> ${food[1].ta_name} </a>
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
					<a href="travel_Detail?ta_name=${shopping[0].ta_name}"><img src="img/${shopping[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;" href="travel_Detail?ta_name=${shopping[0].ta_name}" class="carda">
							${shopping[0].ta_name}
						</a>
				</div>
				<div class="dttcard3" data-ta-name="${shopping[1].ta_name}">
					<a href="travel_Detail?ta_name=${shopping[1].ta_name}"><img src="img/${shopping[1].ta_img}" class="testimg1"></a> <a
						style="text-decoration: none;" href="travel_Detail?ta_name=${shopping[1].ta_name }" class="carda">
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
					<a href="travel_Detail?ta_name=${hotel[0].ta_name}"><img src="img/${hotel[0].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;" href="travel_Detail?ta_name=${hotel[0].ta_name }" class="carda">
						${hotel[0].ta_name }</a>
				</div>
				<div class="dttcard4" data-ta-name="${hotel[1].ta_name}">
					<a href="travel_Detail?ta_name=${hotel[1].ta_name}"><img src="img/${hotel[1].ta_img}" class="testimg1" /></a> <a
						style="text-decoration: none;" href="travel_Detail?ta_name=${hotel[1].ta_name}" class="carda">
						${hotel[1].ta_name}</a>
				</div>
			</dt>

			<dd>
				<img src="https://www.visitjeju.net/image/main/icon_coral.png"
					class=dtimg2>
			</dd>

<br><br><br><br><br><br><br><br>




			<%@include file="footer.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>

$(document).ready(function() {
    var classNames = ['dtCard', 'dtCard2', 'dtCard3', 'dtCard4', 'dttcard', 'dttcard2', 'dttcard3', 'dttcard4'];

    classNames.forEach(function(className) {
        $('.' + className).on('click', function() {
            var taName = $(this).data('ta-name');
            if (taName) {
                window.location.href = 'travel_Detail?ta_name=' + taName;
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
