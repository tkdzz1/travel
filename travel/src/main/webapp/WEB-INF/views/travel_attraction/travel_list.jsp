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
        <h1>여행지 정보</h1>
        <c:if test="${admin !=0}">
        <button class="w-btn w-btn-red" id="addtravellist">관광지 추가</button>
        </c:if>
        <c:forEach items="${list}" var="alist">
        <div class="travel-card">
            <div class="image-and-text">
			    <img src="../img/t_img/${alist.ta_img}" alt="여행지 이미지" data-name="${alist.ta_img}">
			    <div class="text">
			        <h2>${alist.ta_name}</h2>
			        <br>
			        <span class="tooltip" data-tooltip="조회수">
		       		<strong><img src="../img/조회수.png" style="width:25px;height:25px;" title="조회수"></strong>${alist.ta_hit}
			        </span>
			        <span class="tooltip" data-tooltip="좋아요">
			        <strong><img src="../img/color_like.png" style="width:25px;height:25px;" title="좋아요"></strong>${alist.like_count} 
					</span>	
			        <span class="tooltip" data-tooltip="리뷰">
			        <strong><img src="../img/리뷰.png" style="width:25px;height:25px;" title="리뷰"></strong>${alist.review_count} 
					</span>
			        <span class="tooltip" data-tooltip="찜"  >
			        <strong><img src="../img/찜.png" style="width:25px;height:25px;" title="찜"></strong>${alist.cart_count} 
					</span>						
			        <span class="tooltip" data-tooltip="별점"  >
			        <strong><img src="../img/별.png" style="width:25px;height:25px;" title="별점"></strong>${alist.avgStar} 
					</span>	
												
						<strong></strong>
						  <c:choose>
						    <c:when test="${alist.ta_category eq '관광지'}">
						      <span class="tooltip" data-tooltip="관광지">
						        <img src="../img/관광지.png" style="width:25px;height:25px;">
						      </span>
						    </c:when>
						    <c:when test="${alist.ta_category eq '음식'}">
						      <span class="tooltip" data-tooltip="음식점">
						        <img src="../img/음식.png" style="width:25px;height:25px;">
						      </span>
						    </c:when>
						    <c:when test="${alist.ta_category eq '숙박'}">
						      <span class="tooltip" data-tooltip="숙박">
						        <img src="../img/숙박.png" style="width:25px;height:25px;">
						      </span>
						    </c:when>
						    <c:when test="${alist.ta_category eq '쇼핑'}">
						      <span class="tooltip" data-tooltip="쇼핑">
						        <img src="../img/쇼핑.png" style="width:25px;height:25px;">
						      </span>
						    </c:when>
						  </c:choose>
						
			        <input type=hidden id=category value="${alist.ta_category}">
			        <c:if test="${admin !=0}">
			        <button class="btndelete" data-name="${alist.ta_name}">삭제</button> <!-- 수정된 버튼 -->
			        </c:if>
   			        <input type="hidden" id="h_num" name="h_num" value="${alist.ta_num}" class="h_num">
			        <input type="hidden" id="h_name" name="h_name" value="${alist.ta_name}" class="h_name">
			        <input type="hidden" id="h_name" name="h_latitude" value="${alist.ta_latitude}" class="h_latitude">
			        <input type="hidden" id="h_name" name="h_longitude" value="${alist.ta_longitude}" class="h_longitude">
			    </div>	
            </div>
        </div>
        </c:forEach>
       <div id="pagestr">${pagestr}</div>
    </div>
    <div class="right-panel">
        <div id="map-container"> 
            <div id="map" style="width: 1000px; height: 600px;"></div> 
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

 
    var documentHeight = Math.max(
        document.body.scrollHeight,
        document.body.offsetHeight,
        document.documentElement.clientHeight,
        document.documentElement.scrollHeight,
        document.documentElement.offsetHeight
    );

    // 뷰포트의 높이
    var windowHeight = window.innerHeight || document.documentElement.clientHeight;

    // 스크롤의 최대값
    var maxScroll = documentHeight - windowHeight;

    console.log("스크롤의 최대값: " + maxScroll);

    var $mapContainer = $("#map-container");
    var $map = $("#map");
    var isFixed = false;
    var originalPosition = $mapContainer.offset(); // 이미지의 원래 위치

    // 이미지를 고정할 스크롤 위치 (이미지가 들어 있는 컨테이너의 상단 위치)
    var triggerPosition = $mapContainer.offset().top;
    var releasePosition = maxScroll - 200; // 예를 들어, 200px 스크롤 후에 이미지를 해제하도록 설정

    $(window).scroll(function() {
        scrollY = $(this).scrollTop();

        // 스크롤 >= 184 and 스크롤 < 384 and isFixed=="false"
        // 이미지를 고정

        $map.css({
            position: "fixed",
            top:  originalPosition.top + "px",
        });

        if( scrollY >= releasePosition) {
            $map.css({
                position: "fixed",
                top: "0",
                transition: "position 0.3s ease-out, top 0.3s ease-out, width 0.3s ease-out",
            });
            console.log("하단:");
        }
    });

    let infoWindow = new naver.maps.InfoWindow();
    let isInfoWindowOpen = false;
    let mapOptions = { 
        center: new naver.maps.LatLng(33.3595704, 126.600000),
        zoom: 10,
        zoomControl: true, // 축소와 확대 버튼 표시
        disableDoubleClickZoom: false
    };	

    let map = new naver.maps.Map('map', mapOptions);

    // 변수 추가: 현재 열린 정보 창을 담는 변수
    let currentInfoWindow = null;
    // 이미지를 저장하는 변수를 전역변수로 설정
    let customMarkerImage = null;
    
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
                    
                    if(travelInfo.ta_category=="관광지"){
                    	console.log("카테고리:" + travelInfo.ta_category);
                    	customMarkerImage = 'img/관광마커.png';
                    } else if(travelInfo.ta_category=="음식"){
                    	console.log("카테고리:" + travelInfo.ta_category);
                    	customMarkerImage = 'img/음식마커.png';
                    } else if(travelInfo.ta_category=="숙박"){
                    	console.log("카테고리:" + travelInfo.ta_category);
                    	customMarkerImage = 'img/숙박마커.png';
                    } else if(travelInfo.ta_category=="쇼핑"){
                    	console.log("카테고리:" + travelInfo.ta_category);
                    	customMarkerImage = 'img/쇼핑마커.png';
                    }             
                    
                    let marker = new naver.maps.Marker({
                        position: allPosition,
                        map: map,
                        title: travelInfo.ta_name,
                        icon: {
                            content: '<img src="' + customMarkerImage + '" style="width: 32px; height: 32px;">', // 사용자 정의 마커 이미지
                            anchor: new naver.maps.Point(16, 16) // 마커 이미지의 중심 위치 설정
                        }
                    });

                    let infoWindow = new naver.maps.InfoWindow({
                        content: '<div class="detail" ><img src="../img/t_img/' + travelInfo.ta_img + '" alt="여행지 이미지" class="detail_img" "><br><div>' + travelInfo.ta_name + '</div><a href="/travel_Detail?ta_name=' + travelInfo.ta_name + '">' + '<button class="detail_button">자세히보기</button>' + '</a></div><br>'
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
            title: ta_name,
            icon: {
                content: '<img src="' + customMarkerImage + '" style="width: 32px; height: 32px;">', // 사용자 정의 마커 이미지
                anchor: new naver.maps.Point(16, 16) // 마커 이미지의 중심 위치 설정
            }
        });

        let infoWindowContent = '<div class="detail" style="padding:10px;text-align:center;width:400px;height:250px;"><img src="../img/t_img/'+ta_img+'" alt="여행지 이미지" style="width:400px;height:200px" "><br><div>'+ta_name+'</div><a href="/travel_Detail?ta_name=' + ta_name + '">' + '<button>자세히보기</button>' + '</a></div><br>';
        let infoWindow = new naver.maps.InfoWindow({
            content: infoWindowContent
        }); 
		
        infoWindow.open(map, marker);
        
        if (isInfoWindowOpen) {
            infoWindow.close();
            isInfoWindowOpen = false;
        } else {
            infoWindow.open(map, marker);
            isInfoWindowOpen = true;
        }
    });

    // 페이지 로드 시 여행지 데이터를 가져옴
    loadTravelData(page);

    // 삭제 버튼 클릭 이벤트 리스너
    $(".btndelete").click(function() {
        // 클릭한 버튼의 data-name 속성에서 여행지 이름을 가져옴
        let ta_name = $(this).data("name");

        // 사용자에게 삭제 확인 대화상자 표시
        let confirmDelete = confirm("정말로 삭제하시겠습니까?");

        if (confirmDelete) {
            // 삭제 확인이 된 경우
            let ta_img = $(this).closest(".travel-card").find("img").data("name");
            let ta_num = $(this).closest(".travel-card").find("#h_num").val();

            // 여행지 삭제 요청을 보냄
            $.ajax({
                url: "/delete_list",
                method: "post",
                data: { ta_name: ta_name, ta_img: ta_img, ta_num: ta_num },
                success: function(response) {
                    // 삭제가 성공하면 해당 카드를 화면에서 제거
                    var cardToRemove = $(this).closest(".travel-card");
                    cardToRemove.remove();
                    alert(response);

                    // 이미지 파일 삭제 요청을 보냄
                    $.ajax({
                        url: "/delete_image",
                        method: "post",
                        data: { ta_name: ta_name }, // 이미지 파일명을 서버로 전달
                        success: function(response) {
                            console.log("이미지 파일 삭제 완료");
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
        } else {
            // 삭제 확인이 취소된 경우
            console.log("삭제가 취소되었습니다.");
        }
    });

    $("#addtravellist").on("click",function(){
        document.location="/add_TravelList"
    })

});
</script>
</html>