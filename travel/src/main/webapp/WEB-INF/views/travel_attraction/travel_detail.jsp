<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/detail.css"> <!-- CSS 파일 연결 -->
<link rel="stylesheet" type="text/css" href="/css/star.css">

<title>Insert title here</title>
</head>
<%@ include file="../header.jsp" %>
<body>
<section>
<div class="background-img" style="background-image: url('img/t_img/${detail.ta_img}');">
    <div class="travel-info">
        <h1>여행지 상세 정보</h1>
        <h2 class="ta_name">${detail.ta_name}</h2>
        <input type="hidden" id="hidname" value="${detail.ta_name }">
        <input type="hidden" id="pagestr" value="${pagestr}">
        <input type="hidden" id="ta_num" value="${detail.ta_num }">
        <input type="hidden" id="ta_category" value="${detail.ta_category}">
        <p><strong>주소:</strong><span>${detail.ta_address}</span></p>
        <p><strong>분류:</strong>${detail.ta_category}</p>
    </div>
</div>
<div class="detail-info">
 	<table id="tbl">
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
	<fieldset id="field">
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
	<div id="insertReview" class="insertReview">
		<input type="hidden" id="taname" value="${detail.ta_name}">
		<textarea class="col-auto form-control" id="reviewContents" placeholder="좋은 리뷰를 남겨주세요!"></textarea>
	  <input type="button" id=btnreview class="btnreview" style="height:50px;" value="작성완료">
	</div>
	
</div>
<%-- <%@ include file="../footer.jsp" %> --%>
</section>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){

	let ta_name = $("#hidname").val();
    $.ajax({
        url:"/totalCart",
        method:"post",
        data:{ta_name:ta_name},
        success: function(data){
            console.log("찜:"+data);

            // 찜 수를 표시할 위치를 선택합니다.
            var cartCountContainer = $("<span>").text("찜 수: " + data);

            // 해당 위치에 찜 수를 추가합니다.
            $("#heart").append(cartCountContainer);
        }
    });

    $.ajax({
        url:"/totalLike",
        method:"post",
        data:{ta_name:ta_name},
        success: function(data){
            console.log("좋아요:"+data);

            // 좋아요 수를 표시할 위치를 선택합니다.
            var likeCountContainer = $("<span>").text("좋아요 수: " + data);

            // 해당 위치에 좋아요 수를 추가합니다.
            $("#like").append(likeCountContainer);
        }
    });

    
        // 서버로부터 찜 목록 정보를 가져옴
    $.ajax({
        url: "/cntCart",
        method: "post",
        data: { ta_name: ta_name },
        success: function(data) {
            console.log(data);

            // 서버로부터 받은 데이터에 따라 이미지 설정
            if (data === "1") {
                // 찜 목록에 있는 경우
                $("#heart img").attr("src", "img/red_heart.png");
            } else {
                // 찜 목록에 없는 경우
                $("#heart img").attr("src", "img/heart.png");
            }
        },
        error: function(xhr, status, error) {
            console.log("찜 목록 정보를 가져오는 데 실패했습니다." + error);
        }
    });
        // 서버로부터 찜 목록 정보를 가져옴
    $.ajax({
        url: "/cntLike",
        method: "post",
        data: { ta_name: ta_name },
        success: function(data) {
            console.log(data);

            // 서버로부터 받은 데이터에 따라 이미지 설정
            if (data === "1") {
                // 좋아요 눌렀을 경우
                $("#like img").attr("src", "img/color_like.png");
            } else {
                // 좋아요 안눌렀을 경우
                $("#like img").attr("src", "img/black_like.png");
            }
        },
        error: function(xhr, status, error) {
            console.log("좋아요 정보를 가져오는것을 실패했습니다." + error);
        }
    });

    // 나머지 코드...
	
	let queryString = window.location.search;

	// 쿼리 문자열을 파싱하여 파라미터와 값들을 객체로 추출합니다.
	let params = new URLSearchParams(queryString);

	// 페이지 번호에 해당하는 파라미터의 값을 가져옵니다.
	let pageno = params.get("pageno");

    $.ajax({
        url: "/getReviewList",
        data: { ta_name: ta_name, pageno:pageno },
        method: "post",
        success: function(data) {
            console.log(data);

            // JSON 문자열을 JavaScript 객체로 파싱
            let responseData = JSON.parse(data);

            // 'pagestr' 속성 가져오기
            let pagestr = responseData.pagestr;

            // 'reviews' 속성 가져오기 (리뷰 데이터)
            let reviewData = responseData.reviews;

            // 리뷰 목록을 감싸는 div 생성
            let reviewListContainer = $("<div class='review-list-container'></div>");

            // 리뷰 데이터 반복 처리
            for (let i = 0; i < reviewData.length; i++) {
                let review = reviewData[i];

                // 리뷰 댓글 창을 만들어서 리뷰 목록 컨테이너에 추가
                let reviewComment = $("<div class='review-comment'></div>");
                reviewComment.append("<div>아이디: " + review.review_id + "</div>");
                reviewComment.append("<div>작성일자: " + review.review_created + "</div>");

                // 별점 이미지 출력
                let starRating = $("<div class='star-rating'></div>");
                for (let j = 0; j < review.review_rating; j++) {
                    starRating.append("<span class='rating' >★</span>");
                }
                reviewComment.append(starRating);

                // 리뷰 내용 및 삭제 버튼 추가
                reviewComment.append("<div class='review-content' style='height:50px;'>" + review.review_content + "</div><br>");
                
                reviewComment.append("<div id='star-rating' style='display:none;direction: rtl;'>");
                reviewComment.find("#star-rating").append("<input type='radio' name='updatedStar" + review.review_num + "' class='radio2' value='5' id='updateRate1" + review.review_num + "' data-review-num='" + review.review_num + "'><label for='updateRate1" + review.review_num + "'>★</label>");
                reviewComment.find("#star-rating").append("<input type='radio' name='updatedStar" + review.review_num + "' class='radio2' value='4' id='updateRate2" + review.review_num + "' data-review-num='" + review.review_num + "'><label for='updateRate2" + review.review_num + "'>★</label>");
                reviewComment.find("#star-rating").append("<input type='radio' name='updatedStar" + review.review_num + "' class='radio2' value='3' id='updateRate3" + review.review_num + "' data-review-num='" + review.review_num + "'><label for='updateRate3" + review.review_num + "'>★</label>");
                reviewComment.find("#star-rating").append("<input type='radio' name='updatedStar" + review.review_num + "' class='radio2' value='2' id='updateRate4" + review.review_num + "' data-review-num='" + review.review_num + "'><label for='updateRate4" + review.review_num + "'>★</label>");
                reviewComment.find("#star-rating").append("<input type='radio' name='updatedStar" + review.review_num + "' class='radio2' value='1' id='updateRate5" + review.review_num + "' data-review-num='" + review.review_num + "'><label for='updateRate5" + review.review_num + "'>★</label>");
                reviewComment.append("</div><br>");
				
                reviewComment.append("<input type='hidden' id='rating_num" + review.review_num + "' value='" + review.review_rating + "'>");


                reviewComment.append("<textarea class='update-content' style='height:50px;display:none;'>" + review.review_content + "</textarea>");
				reviewComment.append("<div class='button-container'>");
				reviewComment.append("<input type='button' style='height:40px;' class='delete-button' data-review-num='" + review.review_num + "' value='삭제'>");
				reviewComment.append("<input type='button' style='height:40px;' class='update-button' data-review-num='" + review.review_num + "' value='수정'>");
				reviewComment.append("<input type='button' style='height:40px;display:none;' class='accept-button' data-review-num='" + review.review_num + "' value='확인'>");
				reviewComment.append("<input type='button' style='height:40px;display:none;' class='cancle-button' data-review-num='" + review.review_num + "' value='취소'>");
				reviewComment.append("</div><br><br>");


                // 리뷰 댓글 창을 리뷰 목록 컨테이너에 추가
                reviewListContainer.append(reviewComment);
            }

            // 페이지 숫자를 화면 하단에 추가
            reviewListContainer.append("<div class='pagestr' style='text-align:center;'>" + pagestr + "</div>");

            // 페이지에 리뷰 목록 컨테이너 추가
            $(".review").append(reviewListContainer);
        },
    });
});

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

    let ta_name = $("#hidname").val();
    let ta_category = $("#ta_category").val();
    let ta_num = $("#ta_num").val();

    console.log(ta_name);
    console.log(ta_category);
    console.log(ta_num);
    
    // 이미지의 src 속성을 확인하여 찜 목록을 해제 또는 추가
    if (image.attr("src") === "img/red_heart.png") {
        // 이미 찜한 경우, 찜 해제 로직 수행
        $.ajax({
            url: "/removeCart", // 찜 해제를 처리하는 엔드포인트 URL
            method: "post",
            data: { ta_name: ta_name},
            success: function (data) {
                console.log(data);
                alert("찜 목록을 해제했습니다.");
                // 이미지를 하트 모양으로 변경
                image.attr("src", "img/heart.png");

                // 찜 수를 업데이트
                var updatedCartCount = parseInt(data); // 서버에서 받은 데이터를 정수로 변환
                $("#heart span").text("찜 수: " + updatedCartCount);
            },
            error: function (xhr, status, error) {
                console.log("찜목록 해제에 실패했습니다." + error);
            }
        });
    } else {
        // 찜하지 않은 경우, 찜 목록 추가 로직 수행
        $.ajax({
            url: "/addCart",
            method: "post",
            data: { ta_name: ta_name, ta_category: ta_category, ta_num: ta_num },
            success: function (data) {
                console.log(data);
                alert("찜 목록에 추가했습니다.");
                // 이미지를 빨간 하트 모양으로 변경
                image.attr("src", "img/red_heart.png");
                // 찜 수를 업데이트
                var updatedCartCount = parseInt(data); // 서버에서 받은 데이터를 정수로 변환
                $("#heart span").text("찜 수: " + updatedCartCount);
            },
            error: function (xhr, status, error) {
                console.log("찜목록 추가에 실패했습니다." + error);
            }
        });
    }
})
.on("click", "#like", function () {
	console.log("Like 버튼 클릭 이벤트 발생");
    let likeButton = $(this);
    let image = likeButton.find("img");
   	
    let ta_name = $("#hidname").val();
    let ta_category = $("#ta_category").val();
    let ta_num = $("#ta_num").val();
    
    if (image.attr("src") === "img/color_like.png") {
        // 좋아요 해제
        $.ajax({
            url: "/removeLike",
            method: "post",
            data: { ta_name: ta_name},
            success: function (data) {
                console.log(data);
                alert("좋아요를 해제했습니다.");
                image.attr("src", "img/black_like.png"); // 클릭된 경우
	            // 좋아요 수를 표시할 위치를 선택합니다.
                var updatedCartCount = parseInt(data); // 서버에서 받은 데이터를 정수로 변환
                $("#like span").text("좋아요 수: " + updatedCartCount);
            },
            error: function (xhr, status, error) {
                console.log("좋아요 해제에 실패했습니다." + error);
            },
        });
    } else {
        // 좋아요 추가
        $.ajax({
            url: "/addLike",
            method: "post",
            data: { ta_name: ta_name, ta_category: ta_category, ta_num: ta_num },
            success: function (data) {
                console.log(data);
                alert("좋아요를 눌렀습니다.");
                image.attr("src", "img/color_like.png"); // 클릭되지 않은 경우
	            // 좋아요 수를 표시할 위치를 선택합니다.
                var updatedCartCount = parseInt(data); // 서버에서 받은 데이터를 정수로 변환
                $("#like span").text("좋아요 수: " + updatedCartCount);
            },
            error: function (xhr, status, error) {
                console.log("좋아요 추가에 실패했습니다." + error);
            },
        });
    }
    likeButton.toggleClass("clicked");
})
.on("click","#btnreview", function(){
	let rating = $("input[name='reviewStar']:checked").val();
	let taname = $("#taname").val();
	let content = $("#reviewContents").val();
	if(content==""){
		alert("리뷰 내용을 입력해주십시오")
		return false;
	}
	let id= $(".id").text()
	$.ajax({
		url:"/insertReview",
		data:{rating:rating,ta_name:taname,content:content},
		method:"post",
		success:function(data){
			console.log(data)
			alert("리뷰 작성을 완료하였습니다.")
			console.log("data")
			 $("#reviewContents").val(""); // 리뷰 입력 창 초기화
			location.reload();
			
		},
		error: function(xhr, status, error) {
            console.log("에러가 발생" + error)
        }
	})
})
.on("click", ".delete-button", function () {
    var reviewNum = $(this).data("review-num"); // 데이터 속성을 통해 리뷰 번호 가져오기
    console.log("클릭한 삭제 버튼의 리뷰 번호: " + reviewNum);
    
    var reviewComment = $(this).closest(".review-comment"); // 삭제할 리뷰 댓글을 찾기
    
    // Ajax 요청
    $.ajax({
        type: "POST", // 또는 다른 HTTP 메서드 (GET, DELETE 등)
        url: "/deleteReview", // 서버에서 삭제 작업을 수행할 엔드포인트 URL
        data: { reviewNum: reviewNum }, // 서버에 전달할 데이터 (리뷰 번호)
        success: function (response) {
            console.log("리뷰가 성공적으로 삭제되었습니다.");
            
            // 리뷰 댓글 div를 화면에서 제거
            reviewComment.remove();
            location.reload();
            // 여기에서 필요한 업데이트 작업을 수행할 수 있습니다.
        },
        error: function (error) {
            // 삭제 중에 오류가 발생하면 이 부분이 실행됩니다.
            console.error("리뷰 삭제 중 오류 발생: " + error);
            // 오류 처리를 위한 코드를 추가할 수 있습니다.
        }
    });
})
.on("click", ".update-button", function () {
    var reviewComment = $(this).closest(".review-comment");
    var updateContent = reviewComment.find(".update-content");
    var deleteButton = reviewComment.find(".delete-button");
    var updateButton = reviewComment.find(".update-button");
    var acceptButton = reviewComment.find(".accept-button");
    var cancleButton = reviewComment.find(".cancle-button");
	let starRating = reviewComment.find("#star-rating");
	
    // 기존 별점 값을 가져오기
    var existingRating = reviewComment.find("#rating_num" + reviewComment.data("review-num")).val();
    
    console.log(existingRating)
    // 수정 별점 입력란 설정 및 체크
    starRating.find("input[name^='updatedStar']").prop("checked", false); // 모든 별점 선택 해제
    starRating.find("input[name^='updatedStar'][value='" + existingRating + "']").prop("checked", true); // 수정 별점 선택
	
    // 수정할 내용을 보이도록 스타일 변경
    starRating.css("display","inline-block")
    acceptButton.css("display", "inline-block"); // inline-block으로 변경
    updateButton.css("display", "none");
    cancleButton.css("display", "inline-block"); // inline-block으로 변경
    updateContent.css("display", "inline-block"); // inline-block으로 변경
    deleteButton.css("display", "none");
})
.on("click",".cancle-button", function(){
    var reviewComment = $(this).closest(".review-comment"); // 수정할 리뷰 댓글을 찾기
    var updateContent = reviewComment.find(".update-content"); // 수정할 내용을 찾기
	let cancleButton = reviewComment.find(".cancle-button");
    let deleteButton = reviewComment.find(".delete-button");
    let updateButton = reviewComment.find(".update-button");
    let acceptButton = reviewComment.find(".accept-button");
    let starRating = reviewComment.find("#star-rating");
    
    acceptButton.css("display","none");
    updateButton.css("display","inline-block");
    cancleButton.css("display","none");
    updateContent.css("display", "none");
    deleteButton.css("display","inline-block")
    starRating.css("display","none")
})
.on("click", ".accept-button", function () {
    var reviewComment = $(this).closest(".review-comment"); // 수정할 리뷰 댓글을 찾기
    var updateContent = reviewComment.find(".update-content"); // 수정할 내용을 찾기
    var updatedText = updateContent.val(); // 수정된 텍스트 내용 가져오기
    
    // 수정 대상 리뷰 번호 가져오기
    var reviewNum = $(this).data("review-num");
    
    // 수정 대상 리뷰의 별점을 찾기
    var rating = $("input[name='updatedStar" + reviewNum + "']:checked").val();
    
    // 리뷰 번호와 별점 확인
    console.log("Review Number: " + reviewNum);
    console.log("Selected Rating: " + rating);
    console.log("Updated Text: " + updatedText);
    
    // 이제 필요한 정보를 Ajax 요청으로 서버에 전송할 수 있습니다.
    $.ajax({
        url: "/update_content",
        method: "post",
        data: { reviewNum: reviewNum, updatedText: updatedText, rating: rating },
        success: function (data) {
            console.log(data);
            location.reload();
        }
    });
})


	


</script>
</html>