<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TRAVEL JEJU - 관광지</title>
    <link rel="stylesheet" type="text/css" href="css/map.css">
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=81hlrkxaq1"></script>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="container">
    <div class="left-panel">
        <h1>여행지 정보</h1> <button id="addtravellist">관광지 추가</button>
        <c:forEach items="${list}" var="alist">
        <div class="travel-card">
            <div class="image-and-text">
			    <img src="../img/t_img/${alist.ta_img}" alt="여행지 이미지" data-name="${alist.ta_img}">
			    <div class="text">
			        <h2>${alist.ta_name}</h2>
			        <p><strong>주소:</strong> ${alist.ta_address}</p>
		       		<p><strong><img src="../img/조회수.png" style="width:25px;height:25px;" title="조회수"></strong>${alist.ta_hit}</p>
			        <p><strong><img src="../img/color_like.png" style="width:25px;height:25px;" title="좋아요"></strong>${alist.like_count} </p>
			        <p><strong></strong><c:choose>
											    <c:when test="${alist.ta_category eq '관광지'}">
											        <img src="../img/관광지.png" style="width:25px;height:25px;" title="관광지">
											    </c:when>
											    <c:when test="${alist.ta_category eq '음식'}">
											        <img src="../img/음식.png" style="width:25px;height:25px;" title="음식점">
											    </c:when>
   											    <c:when test="${alist.ta_category eq '숙박'}">
											        <img src="../img/숙박.png" style="width:25px;height:25px;" title="숙박">
											    </c:when>
											    <c:when test="${alist.ta_category eq '쇼핑'}">
											        <img src="../img/쇼핑.png" style="width:25px;height:25px;" title="쇼핑">
											    </c:when>
											</c:choose>
											</p>
			        <input type=hidden id=category value="${alist.ta_category}">
			        <button class="btndelete" data-name="${alist.ta_name}">삭제</button> <!-- 수정된 버튼 -->
   			        <input type="hidden" id="h_num" name="h_num" value="${alist.ta_num}" class="h_num">
			        <input type="hidden" id="h_name" name="h_name" value="${alist.ta_name}" class="h_name">
			        <input type="hidden" id="h_name" name="h_latitude" value="${alist.ta_latitude}" class="h_latitude">
			        <input type="hidden" id="h_name" name="h_longitude" value="${alist.ta_longitude}" class="h_longitude">
			    </div>	
            </div>
        </div>
        </c:forEach>
       <div style="text-align: center;">${pagestr}</div>
    </div>
    <div class="right-panel">
        <div id="map-container"> 
            <div id="map" style="width: 800px; height: 600px;"></div> 
        </div>
    </div>
</div>
<%@ include file="../footer.jsp" %>
</body>
<!-- <script src="js/map.js"></script> -->
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
var category = $('#category').val();
$(document).ready(function() {
    let infoWindow = new naver.maps.InfoWindow();
    let isInfoWindowOpen = false;
    let mapOptions = { 
        center: new naver.maps.LatLng(33.3595704, 126.600000),
        zoom: 10
    };	

    let map = new naver.maps.Map('map', mapOptions);

    // 변수 추가: 현재 열린 정보 창을 담는 변수
    let currentInfoWindow = null;

    // 페이지 번호를 가져옴
    let page = new URLSearchParams(window.location.search).get("pageno");

    // 여행지 데이터를 서버에서 가져오는 함수
function loadTravelData(page) {
    $.ajax({
        url: "/getTravelData",
        method: "post",
        data: { pageno: page, category: category },
        dataType: "json",
        success: function(data) {
            // 여행지 정보를 순회하면서 마커를 생성하고 이름 설정
            data.forEach(function(travelInfo) {
                let allPosition = new naver.maps.LatLng(travelInfo.ta_latitude, travelInfo.ta_longitude);
                console.log(allPosition);
                let marker = new naver.maps.Marker({
                    position: allPosition,
                    map: map,
                    title: travelInfo.ta_name
                });

                let infoWindow = new naver.maps.InfoWindow({
                    content: '<div class="detail" style="padding:10px;text-align:center;width:400px;height:250px;"><img src="../img/t_img/' + travelInfo.ta_img + '" alt="여행지 이미지" style="width:400px;height:200px" "><br><div>' + travelInfo.ta_name + '</div><a href="/travel_Detail?ta_name=' + travelInfo.ta_name + '">' + '<button>자세히보기</button>' + '</a></div><br>'
                });

                // 마커 클릭 이벤트 리스너 추가
                naver.maps.Event.addListener(marker, 'click', function() {
                    if (isInfoWindowOpen) {
                        infoWindow.close();
                        isInfoWindowOpen = false;
                    } else {
                        infoWindow.open(map, marker);
                        isInfoWindowOpen = true;
                    }
                });

                // 카드 클릭 이벤트 리스너 추가
            });
        },
        error: function(xhr, status, error) {
            console.error("여행지 정보를 불러오는데 실패했습니다.");
        }
    });
}


    $(".travel-card").click(function () {
        // 클릭한 div에서 정보를 가져옴
        let ta_img = $(this).find("img").data("name");
        let ta_name = $(this).find(".h_name").val();
        let ta_latitude = $(this).find(".h_latitude").val();
        let ta_longitude = $(this).find(".h_longitude").val();
        
        // 클릭한 여행지의 위치로 이동
        let nowPosition = new naver.maps.LatLng(ta_latitude, ta_longitude);

        // 마커 생성 및 정보 창 열기
        let marker = new naver.maps.Marker({
            position: nowPosition,
            map: map,
            title: ta_name
        });
		
        let infoWindowContent = '<div class="detail" style="padding:10px;text-align:center;width:400px;height:250px;"><img src="../img/t_img/'+ta_img+'" alt="여행지 이미지" style="width:400px;height:200px" "><br><div>'+ta_name+'</div><a href="/travel_Detail?ta_name=' + ta_name + '">' + '<button>자세히보기</button>' + '</a></div><br>';
        let infoWindow = new naver.maps.InfoWindow({
            content: infoWindowContent
        });

        infoWindow.open(map, marker);
    });
    // 페이지 로드 시 여행지 데이터를 가져옴
    loadTravelData(page);
    
 // 삭제 버튼 클릭 이벤트 리스너
    $(".btndelete").click(function() {
        // 클릭한 버튼의 data-name 속성에서 여행지 이름을 가져옴
        let ta_num = $(this).closest(".travel-card").find("#h_num").val();
        
        let ta_name = $(this).data("name");
        let ta_img = $(this).closest(".travel-card").find("img").data("name"); // 여행지 이미지 파일명 가져오기

        console.log("여행지 번호:" + ta_num);
        console.log("여행지 이름:" + ta_name);
        console.log("이미지 파일명:" + ta_img);

        // 저장소에 대한 참조
        let $this = $(this);

        // 여행지 삭제 요청을 보냄
        $.ajax({
            url: "/delete_list",
            method: "post",
            data: { ta_name: ta_name, ta_img: ta_img, ta_num:ta_num},
            success: function(response) {
                // 삭제가 성공하면 해당 카드를 화면에서 제거
                var cardToRemove = $this.closest(".travel-card");
                cardToRemove.remove();
                alert(response);
				
                // 이미지 파일 삭제 요청을 보냄
                $.ajax({
                    url: "/delete_image",
                    method: "post",
                    data: { ta_name: ta_name }, // 이미지 파일명을 서버로 전달
                    success: function(response) {
                    	console.log("이미지 파일 삭제 완료")
                    },
                    error: function(xhr, status, error) {
                        console.error("이미지 파일 삭제 중 오류가 발생했습니다.");
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("여행지 삭제 중 오류가 발생했습니다.");
            }
        });
    });
 	$("#addtravellist").on("click",function(){
 		document.location="/add_TravelList"
 	})

});
</script>
</html>