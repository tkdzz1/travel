let tbodyIndex;
let markers = [];
var numList = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'];
let ta_name;
var count = 0;
var day1;

let infoWindow = new naver.maps.InfoWindow();
let isInfoWindowOpen = false;
let mapOptions = { 
    center: new naver.maps.LatLng(33.3612909, 126.6954437),
    zoom: 10
};	
let map = new naver.maps.Map('map', mapOptions);

$(document)
.ready(function(){

})
.on('click','dl[name=planner]',function(){
	markerReload();
	
	let planNum = $(this).attr("id");
	console.log(planNum);
	$.ajax({ url:"/getPlanner", data: { planNum : planNum }, type: 'post', dataType: 'json',
		success: function(response){
			let obj = response[0];
			$('#modalTitle').text( obj['title'] );
			$('#id').text( obj['writer'] );
			$('#title').text( obj['title'] );
			$('#days').text( obj['days'] );
			$('#startDay').text( obj['startDay'] );
			$('#endDay').text( obj['endDay'] );
			$('#people').text( obj['people'] );
			$('#party').text( obj['party'] );
			
			var days = [];
			var plan = [];
			var dayPlan = obj['plan'].split("=>");
			
			dayPlan.forEach(function(items){
				dayPlanSplit = items.split("?");
				
				days.push(dayPlanSplit[0]);
				plan.push(dayPlanSplit[1]);
			})
			
			var day = days[days.length - 1];
			day = parseInt( day.match(/\d+/)[0] );
			
			var table = "";
			
			for ( let i = 1 ; i <= day ; i++ ){
				table += createTable(i);
			}
			
			$('#planTable').html(table);
			
			$('#planTable thead').each(function() {
			    $(this).hide();
			});
			$('#planTable tbody').each(function() {
			    $(this).hide();
			});
			
			$('#planTable thead:eq(0)').show();
			$('#planTable tbody:eq(0)').show();
			
			console.log(days);
			console.log(plan);
			
			day = 1;
			tbodyIndex = 0;
			day1 = true;
			
			$('#planTable tbody').each(function(){
				
				let planNum = 0;	
				
				$(this).find('tr').each(function(){
					
					let att = $(this).find('td:eq(1)');
					
					let time = $(this).find('td:eq(0)').attr("name");
					
					planTime = plan[day-1].split("*");

					if ( planTime[planNum].split(":")[0] == time ) {
						let travel_att = planTime[planNum].split(":")[1];
						if ( day1 ) {
						    loadTravelData(travel_att, function(ta_name) {
						        att.html('<h1 name=' + travel_att + '><span name=num></span> ' + ta_name + '</h1>');
						        changePlan();
						    });
						} else {
							// 여기어캄 ???????????????????????????????????????????????
						}
						
						planNum++;
						
					}

					if ( planNum == planTime.length ) {
						day++;
						day1 = false;
						return false;
					}
				
				})
				
			})
			
			$("#myModal").show();
			
		}, error: function(){
			
		}
		
	})
})

.on('click','#planTable thead tr td span',function(){
	var thead = $(this).closest('thead').attr("name");
	var tbody = $(this).closest('thead').next().attr("name");
	var dayCheck =  $(this).parent().text().split(" ")[2] + $(this).parent().text().split(" ")[3];

	if ( $(this).attr("name") == "before" ) {
		if ( dayCheck == "DAY1" ) {
			return false;
		}
		
		$('thead[name=' + thead + ']').hide();
		$('tbody[name=' + tbody + ']').hide();
		
		var numberZone = thead.match(/\d+/);
		
		if ( numberZone ) {
			tbodyIndex = parseInt(numberZone[0], 10) - 2;
			var decrement = ( parseInt(numberZone[0], 10) - 1 ).toString();
			var updateDay = thead.replace(/\d+/, decrement);
		}
		
		$('thead[name=' + updateDay + ']').show();
		$('tbody[name=' + updateDay + ']').show();
		count = 0;
		markerReload();
		
	} else {
		if ( dayCheck == "DAY" + $('#planTable tbody').length ) {
			return false;
		}
		
		$('thead[name=' + thead + ']').hide();
		$('tbody[name=' + tbody + ']').hide();
		
		var numberZone = thead.match(/\d+/);
		
		if ( numberZone ) {
			tbodyIndex = parseInt(numberZone[0], 10);
			var increment = ( parseInt(numberZone[0], 10) + 1 ).toString();
			var updateDay = thead.replace(/\d+/, increment);
		}
		
		$('thead[name=' + updateDay + ']').show();
		$('tbody[name=' + updateDay + ']').show();
		count = 0;
		markerReload();
		
	}
})

$("#closeModalBtn").click(function() {
	count = 0;
	
  $("#myModal").hide();
});

$(window).click(function(event) {
  var modal = $("#myModal");
  if (event.target == modal[0]) {
    modal.hide();
  }
});

function createTable(day) {
	 let html ='<thead style="background-color:black;" name=day' + day +'>'
  		+	'<tr><td style="color:white; width:60px;">시간</td>'
  		+ '<td style="width:800px;"><span name=before>◀ </span> <span name=day>DAY ' + day + '</span> <span name=after> ▶</span></td></tr>'
  		+ '</thead>'
  		+ '<tbody name=day' + day + '>' 
  		+	'<tr><td name=6>06:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=7>07:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=8>08:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=9>09:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=10>10:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=11>11:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=12>12:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=13>13:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=14>14:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=15>15:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=16>16:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=17>17:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=18>18:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=19>19:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=20>20:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=21>21:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=22>22:00</td><td draggable="true"></td></tr>'
  		+	'<tr><td name=23>23:00</td><td draggable="true"></td></tr>'
  		+  '</tbody>'
  		return html;
}

function changePlan() {
  var numList = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'];
  let ndx = 0;
  
  $('#planTable tbody:eq('+tbodyIndex+') tr').each(function() {
    var $this = $(this).find('td:eq(1)');
    var text = $this.text().trim(); // 공백 제거
    
    if (text !== '') {
      $this.find('span[name=num]').html('<img src="img/logo/' + numList[ndx] + '.png" style="width:30px;"></img>');
      ndx++;
    }
    
  });
}

function loadTravelData(ta_num, callback) {
    $.ajax({
        url: "/getPlanData",
        method: "post",
        data: { ta_num : ta_num },
        dataType: "json",
        success: function(data) {
            // 여행지 정보를 순회하면서 마커를 생성하고 이름 설정
            data.forEach(function(travelInfo) {
                let allPosition = new naver.maps.LatLng(travelInfo.ta_latitude, travelInfo.ta_longitude);
                
                ta_name = travelInfo.ta_name;
                
                callback(ta_name);
				
                let marker = new naver.maps.Marker({
                    position: allPosition,
                    map: map,
                    title: ta_num,
                        icon: {
					        content: '<img src="img/logo/' + numList[count] + '.png"' + 'width="30" height="30" />', // 이미지 URL 및 크기를 지정
					        size: new naver.maps.Size(30, 30), // 마커 이미지의 크기
					        anchor: new naver.maps.Point(15, 15) // 마커 이미지의 중심 위치
					    }
                });
                markers.push(marker);
                count++;
                
                let infoWindow = new naver.maps.InfoWindow({
                    content: travelInfo.ta_name
                });

               naver.maps.Event.addListener(marker, 'click', function() {
                    if (isInfoWindowOpen) {
                        infoWindow.close();
                        isInfoWindowOpen = false;
                    } else {
                        infoWindow.open(map, marker);
                        isInfoWindowOpen = true;
                    }
                });
                
                marker.infoWindow = infoWindow;

            });
        },
        error: function(xhr, status, error) {
            console.error("여행지 정보를 불러오는데 실패했습니다.");
        }
    });
}

function markerReload(){
		var planList = [];
		
		for (let i = 0; i<markers.length; i++) {
			markers[i].setMap(null);
			if (markers[i].infoWindow) {
            	markers[i].infoWindow.close();
        	}
		}
		
		markers = [];
		
		$('#planTable tbody:eq(' +tbodyIndex+ ') tr').each(function(){
			 let $this = $(this).find('h1').attr('name');
			 if ( $this == undefined ) {
				 return;
			 }
			 planList.push($this);
		})
		
		for (let i = 0; i<planList.length; i++) {
			loadTravelData(planList[i], function(){
				changePlan();
			});
		}
}