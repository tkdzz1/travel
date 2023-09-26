<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/detail.css"> <!-- CSS 파일 연결 -->
<link rel="stylesheet" type="text/css" href="/css/star.css">

<title>Insert title here</title>
</head>
<body>
<section>
<div class="background-img" style="background-image: url('img/t_img/${detail.ta_img}');">
    <div class="travel-info">
        <h1>여행지 상세 정보</h1>
        <h2 class="ta_name">${detail.ta_name}</h2>
        <p><strong>주소:</strong> ${detail.ta_address}</p>
        <p><strong>분류:</strong> ${detail.ta_category}</p>
    </div>
</div>
<div class="detail-info">
   <table>
   	<thead><tr><th>찜</th><th>좋아요</th><th>조회수</th></thead>
   	<tbody>
   		<tr>
   		<td><button id="heart" class="heart"><img src="img/heart.png" alt ="하트" class="heart"></button></td>
   		<td><button id="like" class="like"><img src="img/black_like.png" alt ="좋아요" class="like"></button></td>
   		<td>${detail.ta_hit}</td>
		</tr>
	</tbody>
</table>
	<c:set var="maxIndex" value="${fn:length(ta_imginfoParts) > fn:length(ta_contentParts) ? fn:length(ta_imginfoParts) : fn:length(ta_contentParts)}" />
	<c:forEach begin="0" end="${maxIndex-1}" varStatus="status">
		<div>
		    <!-- 이미지 출력 -->
		    <c:choose>
		        <c:when test="${empty ta_imginfoParts[status.index]}">
		            <!-- 이미지 정보가 비어 있을 때, 아무것도 출력하지 않음 -->
		        </c:when>
		        <c:otherwise>
		            <!-- 이미지 정보가 비어 있지 않을 때, 이미지 출력 -->
		            <img src="img/t_sub_img/${ta_imginfoParts[status.index]}" alt="이미지 ${status.index + 1}" style="width: 600px; height: 400px;">
		        </c:otherwise>
		    </c:choose>
		
		    <!-- 텍스트 출력 -->
		    <c:if test="${status.index < fn:length(ta_contentParts)}">
		        <p>${ta_contentParts[status.index]}</p>
		    </c:if>
	    </div>
	</c:forEach>
	<table>
		<tr>
	        <td><button id="update">수정</button></td>
	        <td></td>
	        <td><button id="cancle">이전</button></td>
       	</tr>
       </table>
</div>
</section>
<section>
<div class="review">
	<h1 class="reviewh1">리뷰 작성</h1>
	<fieldset>
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="reviewStar" class="radio" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="reviewStar" class="radio" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="reviewStar" class="radio" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="reviewStar" class="radio" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="reviewStar" class="radio" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	<div>
		<input type="hidden" id="taname" value="${detail.ta_name}">
		<textarea class="col-auto form-control" id="reviewContents"
				  placeholder="좋은 리뷰를 남겨주세요!"></textarea>
				  <input type="button" id=btnreview class="btnreview" value="작성완료">
	</div>
	
</div>
</section>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#update',function(){
	let ta_name = $(".ta_name").text();
	document.location="/update?ta_name=" + ta_name
})
.on('click','#cancle',function(){
	let ta_name = $(".ta_name").text();
	document.location="/travel_list"
})
.on("click", "#heart", function () {
   var heartButton = $(this);
   var image = heartButton.find("img"); // 버튼 내부의 이미지 요소 선택

   // 이미지의 src 속성을 변경
   if (heartButton.hasClass("clicked")) {
     image.attr("src", "img/heart.png"); // 클릭된 경우
     alert("찜 목록을 해제했습니다.")
     
   } else {
	   image.attr("src", "img/red_heart.png"); // 클릭되지 않은 경우
	   alert("찜 목록에 추가했습니다.")
	   
   }
   heartButton.toggleClass("clicked");
})
.on("click", "#like", function () {
	console.log("Like 버튼 클릭 이벤트 발생");
    let likeButton = $(this);
    let image = likeButton.find("img");
   
    if (likeButton.hasClass("clicked")) {
   		alert("좋아요를 해제했습니다.")
        image.attr("src", "img/black_like.png"); // 클릭된 경우
    } else {
   	    alert("좋아요를 눌렀습니다.")
    	image.attr("src", "img/color_like.png"); // 클릭되지 않은 경우
    }
    likeButton.toggleClass("clicked");
})
.on("click",".radio",function(){
	console.log($(this).val());
})
.on("click","#btnreview", function(){
	let rating = $("input[name='reviewStar']:checked").val();
	let taname = $("#taname").val();
	let id= $(".id").text()
	$.ajax({
		url:"/review",
		data:{rating:rating,ta_name:taname},
		method:"post",
		success:function(data){
			console.log(data)
		},
		error: function(xhr, status, error) {
            console.error("리뷰 작성에 실패했습니다.");
        }
	})
})
</script>
</html>