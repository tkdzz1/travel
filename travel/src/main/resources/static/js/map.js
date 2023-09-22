var mapOptions = { 
        center: new naver.maps.LatLng(33.3595704, 126.600000), // 초기 중심 좌표 설정
        zoom: 10 // 초기 줌 레벨 설정
    };	
    var map = new naver.maps.Map('map', mapOptions); // 지도생성  
    var newPosition = new naver.maps.LatLng(33.458883000000000, 126.94081912628338); //특정 위치값 변수 설정
    
    var marker = new naver.maps.Marker({ // 마커 생성
        position: newPosition, // 변수 위치에 생성
        map: map
    });
    
    $(document).ready(function() {
    	
        $(".travel-card").click(function () {
            // 클릭한 div에서 정보를 가져옴
            var taName = $(this).find(".hid:nth-child(1)").val();
            var taAddress = $(this).find(".hid:nth-child(2)").val();
            var ta_latitude = $(this).find(".hid:nth-child(3)").val();
            var ta_longitude = $(this).find(".hid:nth-child(4)").val();
            
            // 가져온 정보를 콘솔에 출력
            console.log("여행지 이름: " + taName);
            console.log("위도: " + ta_latitude);
            console.log("경도: " + ta_longitude);
    	
        var marker = new naver.maps.Marker({
            position: newPosition,
            map: map,
            title: '성산일출봉' // 이름 설정
        });

        var infoWindow = new naver.maps.InfoWindow({
            content: '<div style="padding:10px;">' + marker.title + '</div>' // title값을 div에 넣고 css 추가
        });

        // 정보 창 상태를 추적하는 변수
        var isInfoWindowOpen = false; // false면 닫힘, true면 열림

        // 마커 클릭 이벤트 리스너 추가
        naver.maps.Event.addListener(marker, 'click', function() {
            if (isInfoWindowOpen) {
                // 정보 창이 이미 열려 있다면 닫음
                infoWindow.close();
                isInfoWindowOpen = false; // 닫음
            } else {
                // 정보 창을 열고 상태를 열림으로 변경
                infoWindow.open(map, marker); // 
                isInfoWindowOpen = true; // 열음
            }
        });

        $("#moveButton").click(function() {
            // 원하는 위치와 줌 레벨로 천천히 이동
            map.morph(newPosition, 15, naver.maps.Animation.BOUNCE); // 천천히 이동하면서 줌 조절

            // 버튼 클릭 시 정보 창을 닫음
            if (isInfoWindowOpen) {
                infoWindow.close();
                isInfoWindowOpen = false;
            }
        }); 

        // 페이지 로드 시 여행지 데이터를 불러옴
        loadTravelData();
    });