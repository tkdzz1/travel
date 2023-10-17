<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/resources/css/home.css" />
<link rel="stylesheet" href="/resources/css/member.css" />
<link rel="stylesheet" href="/resources/css/mypage.css" />
<link rel="stylesheet" href="css/my_jeju_travel.css" />
    <link rel="stylesheet" type="text/css" href="css/map.css">
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=81hlrkxaq1"></script>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
										<li class="on"><a href="/mypage">나의여행일정</a></li>
										<li><a href="/mybbs">나의질문</a></li>
										<li><a href="/myreview">나의리뷰</a></li>
										<li><a href="/mylike">찜한여행지</a></li>
									</ul>
								</div>

								<div class="my_tour_wrap">
									<div class="wrap_tit_zone">
										<p class="wrap_tit">나의 여행일정 (${cnt1})</p>
									</div>

									<div class="tour_list clear">
										<dl class="item_section add">
											<dt>나의 여행 일정 만들기</dt>
											<dd>
												<a href="/my_jeju_travel" id="btn_add_schedule1"
													class="btn_add_schedule">만들기</a>
											</dd>
										</dl>
										<c:forEach items="${pList}" var="pList">
											<dl class="item_section add" style="cursor:pointer;" id="${pList.planner_num}" name=planner>
												<dt>${pList.title}</dt>
												<dd>
												 <span>${pList.days}</span> <br>
												 <span>${pList.startDay} ~ ${pList.endDay}</span> <br>
												 <span>${pList.people} 명</span> <br>
												 <span>${pList.party}</span>
												</dd>
											</dl>
										</c:forEach>
									</div>
									
									<div id="myModal" class="modal">
									  <div class="modal-content">
									    <span class="close" id="closeModalBtn">&times;</span>
									    <h2 id=modalTitle style="color:#ffa458;">모달 제목</h2>
									    <hr>
									    <div style="float:left;">
											<table>
												<tr>
													<td style="color:#ffa458; font-weight:bold;"><span id=id></span> 의 제주 여행</td>
												</tr>
												<tr>
													<td><span style="color:gray">제목</span><span id=title style="margin-left:10px;">제목</span></td>
												</tr>
												<tr>
													<td><span style="color:gray">기간</span><span id=days style="margin-left:10px;"></span></td>
												</tr>
												<tr>
													<td><span id=startDay></span> ~ <span id=endDay></span></td>
												</tr>
												<tr>
													<td><span style="color:gray">인원</span><span id=people style="margin-left:10px;"></span> 명</td>
												</tr>
												<tr>
													<td><span style="color:gray">일행</span><span id=party style="margin-left:10px;"></span></td>
												</tr>
											</table>
									    </div>
									    
										  <div class="right-panel" style="border:1px solid white;">
										    <div id="map-container"> 
										      <div id="map" style="width: 850px; height: 400px;"></div> 
										    </div>
										 </div>
										 
									    <div style="margin-left:5%;">
									    	<table id=planTable class=timeTable>
									    	
									    	</table>
									    </div>
									    
									  </div>
									</div>
									
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
	<script src="js/mypage.js"></script>
</body>
</html>