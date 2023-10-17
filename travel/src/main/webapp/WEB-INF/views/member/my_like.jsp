<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/home.css" />
<link rel="stylesheet" href="/resources/css/member.css" />
<link rel="stylesheet" href="/resources/css/mypage.css" />
<link rel="stylesheet" href="/resources/css/bbs.css" />
<meta charset="UTF-8">
<title>나의여행일정</title>
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
												<c:if test="${empty profile}">
													<img
														src="https://media.bunjang.co.kr/product/177600551_1_1643548856_w320.jpg">
												</c:if>
												<c:if test="${!empty profile}">
													<img src="${profile}">
												</c:if>
											</p>
										</div>
										<div class="myp-info">
											<div class="myTop">
												<div class="infoLV">
													<span class="myN"><c:if test="${empty nickname}">${id}</c:if>
														<c:if test="${!empty nickname}">${nickname}</c:if> </span>&nbsp;님의
													제주여행
												</div>
											</div>
											<div class="myBtm">
												<ul>
													<li><p>나의여행일정</p> <em>${cnt1}</em></li>
													<li><p>나의질문</p> <em>${cnt2}</em></li>
													<li><p>나의리뷰</p> <em>${cnt3}</em></li>
													<li><p>찜한여행지</p> <em>${cnt4}</em></li>
												</ul>
											</div>
										</div>
									</div>
								</div>

								<div class="tabmenu_wrap mt50">
									<ul class="tabStyle wid5 innerwrap" id="tab">
										<li><a href="/mypage">나의여행일정</a></li>
										<li><a href="/mybbs">나의질문</a></li>
										<li><a href="/myreview">나의리뷰</a></li>
										<li class="on"><a href="/mylike">찜한여행지</a></li>
									</ul>
								</div>

								<div class="my_tour_wrap">
									<div class="wrap_tit_zone">
										<p class="wrap_tit">찜한 여행지 (${cnt4})</p>
									</div>
									
									<table class="bbs" id="tblBoard">
										<colgroup>
											<col style="width: 100px;">
											<col>
											<col style="width: 130px;">
											<col style="width: 140px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">사진</th>
												<th scope="col">여행지</th>
												<th scope="col">지역</th>
												<th scope="col">카테고리</th>
											</tr>
										</thead>
										<tbody>
										    <c:forEach items="${cart}" var="cart">
											<tr>
												<td><a href="/travel_Detail?ta_name=${cart.ta_name}"><img src="/img/t_img/${cart.ta_img}" style="width:100px; height:100px;"></a></td>
												<td><a href="/travel_Detail?ta_name=${cart.ta_name}">${cart.ta_name}</a></td>
												<td>${cart.ta_local}</td>
												<td>${cart.ta_category}</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
									
									<div class="paging">
										<div id="paging" class="page-wrap">
											<a href="javascript:void(0)" class="spr_com page-first">처음</a><a
												href="javascript:void(0)" class="spr_com page-prev">이전</a><a
												href="javascript:void(0)" class="spr_com page-next">다음</a><a
												href="javascript:void(0)" class="spr_com page-last">마지막페이지</a>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- cont my tour -->
			</div>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
	<script src="https://code.jquery.com/jquery-latest.js"></script>
</body>
</html>