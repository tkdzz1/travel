<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TRAVEL JEJU - 나만의 제주 여행</title>
<link rel="stylesheet" href="css/my_jeju_travel.css" />
<link rel="stylesheet" href="css/login.css" />
    <link rel="stylesheet" type="text/css" href="css/map.css">
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=81hlrkxaq1"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<body>
<%@ include file = "../header.jsp" %>
<div id=wrapper>

	<div id=main>
	    <h1 style="color:#ffa458;">나만의 제주 여행</h1>
	    <br>
	    <hr>
	    <h5>작성자 : <span id=writer>${id}</span></h5>
	    <br>
	    <table style="width:400px;">
	      <tr>
	        <td>제목</td>
	        <td><input type="text" id=title placeholder="예) 나의 3박4일 제주여행"></td>
	      </tr>
	      <tr>
	        <td>기간</td>
	        <td id="days"></td>
	      </tr>
	      <tr>
	        <td><input type="date" id=start data-placeholder="시작 날짜" required aria-required="true"></td>
	        <td><input type="date" id=end data-placeholder="종료 날짜" required aria-required="true"></td>
	      </tr>
	      <tr>
	      	<td>인원</td><td><input type=number id=people value=1 style="width:50px;"></td>
	      </tr>
	      <tr>
	      	<td>일행</td><td><select id=party>
	      									<option selected>선택</option>
	      									<option>혼자</option>
	      									<option>부모</option>
	      									<option>아이</option>
	      									<option>친구</option>
	      								</select>
	   	  </tr>
	    </table>
	    <br>
	    <table>
	       <tr>
	        <td colspan="2"><button id=plan class="w-btn w-btn-red">일정 만들기</button></td>
	      </tr>
		</table>	      
	</div>

	  <div class="right-panel" style="border:1px solid white;">
	    <div id="map-container"> 
	      <div id="map" style="width: 75%; height: 400px;"></div> 
	    </div>
	  </div>
	  
	  <div style="	float:left; margin-left:10%;" class=travel_list id=list>
	  		<br>
			<ul>
				<li class=select>찜한 여행지<hr></li>
				<li>검색<hr></li>
			</ul>
			<br>
			<div class=option>
				<ul>
					<li class=select>전체<hr></li>
					<li>관광지<hr></li>
					<li>음식<hr></li>
					<li>쇼핑<hr></li>
					<li>숙박<hr></li>
				</ul>
			</div>
			<div id=searchDIV style="text-align:center; display:none;">
				<input type=text id=search placeholder="검색어 입력">
			</div>
			<div id=listResult>
				<c:if test="${tList != 'empty' }">
					<c:forEach items="${tList}" var="tList">
						<hr>
						<div name=contentList class=listContent>
							<input type=hidden value="${tList.ta_num}" name=taNum>
							<img src="/img/t_img/${tList.ta_img}">
							<div class=text>
								<h5 style="font-size:20px;">${tList.ta_name}</h5>
								<p style="font-size:20px;">${tList.ta_local}</p>
								<button class="w-btn w-btn-red" name=add>일정에 추가</button>
							</div>
						</div>
					</c:forEach>
					<div id=addList>
					
					</div>
					<hr>
					<div id=page>
					 	${page}
					</div>
				</c:if>
			</div>
			
			<div style="text-align:center; margin-top: 50%; display:none;" id="filterListEmpty">
				<img src="img/heart.png" style="width:100px;">
				<h3>찜한 여행지가 없습니다.</h3>
			</div>
			
			<div style="text-align:center; margin-top: 50%; display:none;" id="searchListEmpty">
				<img src="img/heart.png" style="width:100px;">
				<h3>검색 결과가 없습니다.</h3>
			</div>
			
			<c:if test="${tList == 'empty' }">
			<div style="text-align:center; margin-top: 50%; display:block;">
				<img src="img/heart.png" style="width:100px;">
				<h3>찜한 여행지가 없습니다.</h3>
			</div>
			</c:if>
	  </div>

  <div>
  	<table id=planTable class=timeTable>
  		<thead style="background-color:black;">
  			<tr><td style="width:60px;">시간</td><td style="width:800px;">스케줄</td></tr>
  		</thead>
  		<tbody>
  			<tr><td>06:00</td><td rowspan=18 style="vertical-align:middle;color:#ff5f2e;"><h2>여행 정보 입력 후 일정 만들기를 클릭해 주세요.</h2></td></tr>
  			<tr><td>07:00</td></tr>
  			<tr><td>08:00</td></tr>
  			<tr><td>09:00</td></tr>
  			<tr><td>10:00</td></tr>
  			<tr><td>11:00</td></tr>
  			<tr><td>12:00</td></tr>
  			<tr><td>13:00</td></tr>
  			<tr><td>14:00</td></tr>
  			<tr><td>15:00</td></tr>
  			<tr><td>16:00</td></tr>
  			<tr><td>17:00</td></tr>
  			<tr><td>18:00</td></tr>
  			<tr><td>19:00</td></tr>
  			<tr><td>20:00</td></tr>
  			<tr><td>21:00</td></tr>
  			<tr><td>22:00</td></tr>
  			<tr><td>23:00</td></tr>
  		</tbody>
  	</table>
  </div>
	
	<br>
	
  <div style="text-align:center;">
  		<button class="w-btn w-btn-red" id=save>저장</button> <button class="w-btn w-btn-black" id=cancel>취소</button>
  </div>
  
</div>
<br>
<%@ include file = "../footer.jsp" %>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/my_jeju_travel.js"></script>
</html>