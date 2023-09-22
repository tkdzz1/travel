<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/weather.css"/>
<link rel="stylesheet" href="/resources/css/weather-icons.css"/>
<link rel="stylesheet" href="/resources/css/weather-icons.min.css"/>
<link rel="stylesheet" href="/resources/css/weather-icons-wind.css"/>
<link rel="stylesheet" href="/resources/css/weather-icons-wind.min.css"/>
<link rel="stylesheet" href="/resources/font/weathericons-regular-webfont.eot"/>
<link rel="stylesheet" href="/resources/font/weathericons-regular-webfont.woff"/>
<link rel="stylesheet" href="/resources/font/weathericons-regular-webfont.woff2"/>
<title>날씨</title>
</head>
<body>
<div class="weather-container">
<div class="vis-weather">
<!-- <i class="wi wi-day-sunny"></i> -->
    <!-- <img src="weather-icon.png" alt="Weather Icon" class="weather-icon"> -->
 		<h1>제주도 날씨</h1>
        
		<ul class="list-group list-group-flush weather" style="font-weight: 600;"></ul>
</div>       
</div>



</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
	var arr =[];
	var today = new Date();
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var year = today.getFullYear();
	var month = today.getMonth() +1;
	var day = today.getDate();
	var hours = today.getHours();
	var minutes = today.getMinutes();
	var hours_al = new Array('02', '05', '08', '11', '14', '17', '20', '23');
	var jeju = [ {'region' :'제주도','nx' : 52,'ny' : 38},
		{'region' : '제주시','nx' : 53,'ny' : 38},
		{'region' : '서귀포시','nx' : 52,'ny' : 33} ];
	
	/* $('.weather-date').html(month + "월" + day + "일" + week[today.getDay()]+ "요일"); */
	/*  동네예보 시간이 0200, 0500, ... 3시간 단위로 23시 까지 */
	for(var i=0; i<hours_al.length; i++){
		var h = hours_al[i] - hours;
		if(h == -1 || h==0 || h == -2){
			var now = hours_al[i];
		}
		if(hours == 00){
			var now = hours_al[7]
		}
	}
	/* example
	   9시 -> 09시 변경 필요
	*/
	if(hours<10){
		hours='0' + hours
	}
	if(month<10){
		month='0' + month;
	}
	if(day<10){
		day='0'+ day;
	}
	
	today=year+ "" +month+ "" +day;
	/* 좌표 */
	$.each(jeju,function(j, k) {
		var _nx = jeju[j].nx, _ny = jeju[j].ny, region = jeju[j].region;
		
		ForecastGribURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?";
		ForecastGribURL += "serviceKey=YimpteXz0DkV4RJNO2oLeZVHyf45P11WDD989d78AbKbCYII11otV0umLTyiTAhgoOLnRa2SDzNNSRxzb2sBDQ%3D%3D";
		ForecastGribURL += "&type=XML";
		ForecastGribURL += "&numOfRows=10";
		ForecastGribURL += "&base_date=" + today;
		ForecastGribURL += "&base_time=" + now + "00";
		ForecastGribURL += "&nx=" + _nx + "&ny=" + _ny;
		arr.push({'url': ForecastGribURL, 'region' : region});
		
		$.ajax({
			url : arr[j].url,
			type : 'GET',
			dataType: 'xml',
			success : function(data){
				var $data = $(data).find("response>body>items>item");
				var cate = "";
				var temp = "";
				var sky = "";
				var pty = "";
				var pop = "";
				
				$.each($data,function(i,o){
					cate = $(o).find("category").text();		//카테고리 목록
					if(cate == 'TMP'){
						temp = $(this).find("fcstValue").text();	// 온도
					}
					if(cate == 'SKY'){
						sky = $(this).find("fcstValue").text();		// 하늘상태
					}
					if(cate == 'PTY'){
						pty = $(this).find("fcstValue").text();	// 강수형태
					}
					if(cate == "POP"){
						pop = $(this).find("fcstValue").text();	// 강수 확률
					}
					console.log(o);
					console.log(cate);
					console.log(temp);
					console.log(sky);
					console.log(pty);
					console.log(pop);
				})
				
				$('.weather').append('<li class="list-group-item weather_li'+j+'"></li>');
				$('.weather_li'+j).addClass('in'+j);
				$('.in'+j).html("현재온도:"+temp+"°C"+"<br>");	//온도
			 	$('.in'+j).append("강수확률"+pop+"%");	// 강수 확률
				$('.in'+j).prepend(arr[j].region+'&emsp;');	//지역이름
				
				if(pty !=0){
					switch(pty){
					case '1':
						$('.in'+j).append(" / 비");
						$('.in'+j).prepend('<i class="wi wi-rain"></i>&emsp;');
						break;
					case '2':
						$('.in'+j).append(" / 비/눈");
						$('.in'+j).prepend('<i class="wi wi-wu-flurries"></i>&emsp;');
						break;
					case '3':
						$('.in'+j).append(" / 눈");
						$('.in'+j).prepend('<i class="wi wi-snow"></i>&emsp;');
						break;
					}
				} else {
					switch(sky){
					case '1':
						$('.in'+j).append(" / 맑음");
						$('.in'+j).prepend('<i class="wi wi-day-sunny"></i>&emsp;');
						break;
					case '2':
						$('.in'+j).append(" / 구름조금");
						$('.in'+j).prepend('<i class="wi wi-day-cloudy"></i>&emsp;');
						break;
					case '3':
						$('.in'+j).append(" / 구름많음");
						$('.in'+j).prepend('<i class="wi wi-cloudy"></i>&emsp;');
						break;
					case '4':
						$('.in'+j).append(" / 흐림");
						$('.in'+j).prepend('<i class="wi wi-cloud"></i>&emsp;');
						break;
						
					}
					
				}	//if 종료
			}	//success func 종료
		})
	})
})
</script>
</html>