<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/header.css" />
<link rel="stylesheet" href="/resources/css/member.css" />
<meta charset="UTF-8">
<title>나의게시글</title>
</head>
<%@ include file="/WEB-INF/views/header.jsp"%>
<body class="my_tour">
	<div id="wrap">
		<div id="container">
			<div id="content">
				<div class="cont my_tour ">
					<div class="location_wrap clear"></div>
					<h3 class="mytourH3">나의 여행</h3>
					<!-- content  -->
					<div id="containernew">
						<div class="inner">
							<div class="subwrap">
								<div class="myp-head">
									<div class="myp-inner">
										<div class="myp-profile">
											<p class="profile-img">
												<img
													src="https://media.bunjang.co.kr/product/177600551_1_1643548856_w320.jpg">
											</p>
										</div>
										<div class="myp-info">
											<div class="myTop">
												<div class="infoLV">
													<span class="myN">이름</span>&nbsp;님의 제주여행
												</div>
											</div>
											<div class="myBtm">
												<ul>
													<li><p>나의여행일정</p>
														<em>0</em></li>
													<li><p>나의게시글</p>
														<em>0</em></li>
													<li><p>나의리뷰</p>
														<em>0</em></li>
													<li><p>찜한여행지</p>
														<em>0</em></li>
													<li><p>제주방문지</p>
														<em>0</em></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="tabmenu_wrap mt50">
									<ul class="tabStyle wid5 innerwrap" id="tab">
										<li><a href="/mypage">나의여행일정</a></li>
										<li class="on"><a href="/mybbs">나의게시글</a></li>
										<li><a href="/myreview">나의리뷰</a></li>
										<li><a href="/mylike">찜한여행지</a></li>
										<li><a href="#">제주방문지</a></li>
									</ul>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- cont my tour -->
			</div>
		</div>
	</div>
<script src="https://code.jquery.com/jquery-latest.js"></script>
</body>
</html>