<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>네이버 지도 이동 예제</title>
    <link rel="stylesheet" type="text/css" href="css/map.css">
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=81hlrkxaq1"></script>
</head>
<body>
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
		       		<p><strong>조회수:</strong>${alist.ta_hit}</p>
			        <p><strong>싫어요:</strong> 10</p>
			        <p><strong>분류:</strong>${alist.ta_category}</p>
			        <button class="btndelete" data-name="${alist.ta_name}">삭제</button> <!-- 수정된 버튼 -->
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

</body>
<!-- <script src="js/map.js"></script> -->
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
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
            data: { pageno: page },
            dataType: "json",
            success: function(data) {
                // 여행지 정보를 순회하면서 마커를 생성하고 이름 설정
                data.forEach(function(travelInfo) {
                    let allPosition = new naver.maps.LatLng(travelInfo.ta_latitude, travelInfo.ta_longitude);
                    console.log(allPosition)
                    let marker = new naver.maps.Marker({
                        position: allPosition,
                        map: map,
                        title: travelInfo.ta_name
                    });

                    let infoWindow = new naver.maps.InfoWindow({
                        content: '<div style="padding: 10px;">' + marker.title + '</div>'
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
		
        let infoWindowContent = '<div class="detail" style="padding:10px;"><a href="/travel_Detail?ta_name=' + ta_name + '">' + ta_name + '</a></div>';
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
        let ta_name = $(this).data("name");
        let ta_img = $(this).closest(".travel-card").find("img").data("name"); // 여행지 이미지 파일명 가져오기

        console.log("여행지 이름:", ta_name);
        console.log("이미지 파일명:", ta_img);

        // 저장소에 대한 참조
        let $this = $(this);

        // 여행지 삭제 요청을 보냄
        $.ajax({
            url: "/delete_list",
            method: "post",
            data: { ta_name: ta_name, ta_img: ta_img },
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
                        // 이미지 파일 삭제 성공 시 추가 로직을 여기에 추가하세요.
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
 	$("#addfoodlist").on("click",function(){
 		document.location="/add_FoodList"
 	})
});
</script>
</html>