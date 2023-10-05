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
</head>
<body>
<%-- <%@ include file = "../header.jsp" %> --%>
<div id=wrapper>
	<div style="float:left;">
	    <h1>여행 준비</h1>
	    <hr>
	    <h5>작성자 : ${id}</h5>
	    <table>
	      <tr>
	        <td>제목</td>
	        <td><input type="text" placeholder="예시) 나의 3박4일 제주여행"></td>
	      </tr>
	      <tr>
	        <td>기간</td>
	        <td id="0bak0il"></td>
	      </tr>
	      <tr>
	        <td><input type="date" data-placeholder="시작 날짜" required aria-required="true" value={startDateValue} className={styles.selectDay} onChange={StartDateValueHandler}></td>
	        <td><input type="date" data-placeholder="종료 날짜" required aria-required="true" value={startDateValue} className={styles.selectDay} onChange={StartDateValueHandler}></td>
	      </tr>
	      <tr>
	        <td colspan="2"><button class="w-btn w-btn-red">일정 만들기</button></td>
	      </tr>
	    </table>
	</div>

	  <div class="right-panel">
	    <div id="map-container"> 
	      <div id="map" style="width: 860px; height: 400px;"></div> 
	    </div>
	  </div>
	  
	  <div style="float:left;" class=travel_list id=list>
			<ul>
				<li class=select>찜한 여행지<hr></li>
				<li>검색<hr></li>
			</ul>
			<div class=option>
				<ul>
					<li class=select>전체<hr></li>
					<li>관광지<hr></li>
					<li>음식<hr></li>
					<li>쇼핑<hr></li>
				</ul>
			</div>
<!-- 			<div class=listContent> -->
<!-- 				<img src="/img/t_img/${tList.ta_img}"> -->
<!-- 				<div class=text> -->
<!-- 					<h3>이름</h3> -->
<!-- 					<p>주소</p> -->
<!-- 					<button class="w-btn w-btn-red">일정에 추가</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<hr> -->
			<div style="text-align:center; margin-top: 50%;">
				<img src="img/heart.png" style="width:100px;">
				<h3>찜한 여행지가 없습니다.</h3>
			</div>
	  </div>
  
  <div>
  	<table class=timeTable>
  		<thead style="background-color:black;">
  			<tr><td style="color:white; width:60px;">시간</td><td style="width:800px;"></td></tr>
  		</thead>
  		<tbody>
  			<tr><td>05:00</td>  <td rowspan=19>일정을 추가해주세요.</td></tr>
  			<tr><td>06:00</td></tr>
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
  
  <div style="text-align:center;">
  		<button class="w-btn w-btn-red">저장</button> <button class="w-btn w-btn-black">취소</button>
  </div>
  
</div>
<%-- <%@ include file = "../footer.jsp" %> --%>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="js/my_jeju_travel.js"></script>
</html>