let choicePlan;
let ta_num;
let beforeValue;
let filter;
let markers = [];
let infoWindow = new naver.maps.InfoWindow();
let isInfoWindowOpen = false;
let dragIndex;
let tbodyIndex;
let mapOptions = { 
    center: new naver.maps.LatLng(33.3595704, 126.600000),
    zoom: 10
};	

let map = new naver.maps.Map('map', mapOptions);

$(document)
.ready(function(){
	let today = getFormattedDate();
	$('#start').attr('min', today);
	$('#end').attr('min', today);
	$('#start').attr('value', today);
})

.on('change','#start',function(){
	$('#end').attr('min', $(this).val());
})

.on('change','#end',function(){
	if ( $('#start').val() == '' ) {
		return false;
	}
	var startDate = $('#start').val();
	var endDate = $(this).val();
	var start = new Date(startDate);
	var end = new Date(endDate);
	var daysDiff = Math.floor( ( end - start ) / (1000 * 60 * 60 * 24));
	
	var days = daysDiff + "박 " + (daysDiff + 1) + "일";
	$('#days').text(days);
})

.on('click','#plan',function(){
	if ( $('#title').val() == '' ) {
		alert("제목을 입력하세요.");
		return false;
	}
	
	if ( $('#start').val() == '' || $('#end').val() == '' ) {
		alert("일정을 선택하세요.");
		return false;
	}
	
	if ( $('select').val() == '선택' ) {
		alert("일행을 선택하세요.");
		return false;
	}

	var day = $('#days').text().split(" ")[1];
	day = parseInt(day.match(/\d+/)[0]);
	
	if ( day == 1 ) {
		$('#planTable').html(createTable(day));
	} else {
		var table = "";
		for ( let i = 1 ; i <= day ; i ++) {
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
	}
})

.on('click','#list ul:eq(0) li', function(){
	if ( $(this).hasClass('select') ) {
		return false;
	} else {
		$('#list ul:eq(0) li').removeClass('select');
		$('#list ul:eq(1) li').removeClass('select');
		$(this).addClass('select');
		$('#list ul:eq(1) li:eq(0)').addClass('select');
		return false;
	}
})

.on('click','#list ul:eq(1) li', function(){
	if ( $(this).hasClass('select') ) {
		return false;
	} else {
		filter = $(this).text();
		console.log(filter);
		likeFilter(filter);
		
		$('#list ul:eq(1) li').removeClass('select');
		$(this).addClass('select');

		return false;
	}
})

.on('click','#page a',function(){
	page = $(this).attr("id");
	
	if ( filter == undefined ) {
		filter = "전체";
	}
	
	if ( $(this).hasClass('strong') ){
		return false;
	}
	
	$.ajax({ url:'/pageMove', type:'post', data: {page : page, filter : filter}, dataType: 'json',
		success: function(data) {
			if (data.length == 5) {
				for( let i=0; i<data.length; i++ ) {
					ListShow(data, i);
				}
			} else {
				for( let i=0; i<data.length; i++ ) {
					ListShow(data, i);
				}
				for ( let i=data.length; i<=$('div[name=contentList]').length; i++){
					let set = $('div[name=contentList]').eq(i);
					set.prev('hr').hide();
					set.hide();
				}
			}
		}, error: function() {
			alert("ERROR !");
		}
	})
	
	$('#page a').removeClass('strong');
	$('#page a').addClass('a');
	$(this).removeClass('a');
	$(this).addClass('strong');
	
	let div = $('#list');
	div.scrollTop(0);
})

.on('click','button[name=add]',function(){
	if ( $('#days').text() == '' ) {
		alert("일정을 먼저 만들어주세요.");
		return false;
	}
	
	choicePlan = $(this).closest('.listContent').find('input[name=taNum]').val();
	
	$('#planTable tbody td:first-child').each(function() {
	    var td = $(this);
	    
	    var button = $('<button>', {
	        class: 'w-btn w-btn-red',
	        name: 'selectTime'
	    });
	
	    td.wrap(button);
	});
	return false;
})

.on('click','button[name=selectTime]',function(){
	let addPlan = $(this).closest('tr').find('td:eq(1)');
	var thead = $(this).closest('tbody').prev().attr('name');
    var numberZone = thead.match(/\d+/);
    tbodyIndex = parseInt(numberZone[0], 10) - 1;
	$.ajax({ url:'/getChoice', data: {choice : choicePlan}, type:'post', dataType:'json',
			success:function(data) {
				let obj = data[0];
				ta_num = obj['ta_num'];
				addPlan.html('<h1 name='+ta_num+'><span name=num></span>' + '<span name='+ta_num+'>' + obj['ta_name'] + '</span>' + '<span name=empty> ❌ </span></h1>');	
				changePlan();
				loadTravelData(ta_num);
			}, error:function(){
				console.log('error!');
			}
		
	})
	
	$('#planTable tbody td:first-child').each(function() {
		 var td = $(this);
		 td.unwrap();
	})
	
	return false;
})

.on('click','#planTable thead td span',function(){
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
		
		markerReload();
	}
})

.on('click','span[name=empty]',function(){
	ta_num = parseInt( $(this).parent().attr("name") );
	console.log('선택한 일정' + ta_num);
	if( !confirm("일정에서 삭제 할까요?") ){
		return false;
	} else {
		
		for (let i = 0; i<markers.length; i++) {
			if ( markers[i]['title'] == ta_num ) {
				markers.splice(i, 1);
				markers[i].setMap(null);
				break;
			}
		}
		
		$(this).closest('td').html('');
		changePlan();
		return false;
	}
})

// drag & drop (일정 수정)
.on('dragstart', "#planTable tbody tr td:odd", function(e) {
    if ($(this).html() == '') {
        return false;
    }
    var thead = $(this).closest('tbody').prev().attr('name');
    var numberZone = thead.match(/\d+/);
    tbodyIndex = parseInt(numberZone[0], 10) - 1;
    e.originalEvent.dataTransfer.setData('data', $(this).html());
    dragIndex = $(this).closest('tr').index();
    $(this).css('background-color', 'gray');
})

.on('dragover', "#planTable tbody tr td:odd", function(e) {
    e.preventDefault();
    $(this).css('background-color', 'gray');
})

.on('dragleave', "#planTable tbody tr td:odd", function(e) {
    e.preventDefault();
    $(this).css('background-color', 'white');
})

.on('dragend', "#planTable tbody tr td:odd", function(e) {
    $('#planTable tbody tr td:odd').each(function() {
        $(this).css('background-color', 'white');
    })
})

.on('drop', "#planTable tbody tr td:odd", function(e) {
    e.preventDefault();

    var data = e.originalEvent.dataTransfer.getData('data');
    var dropIndex = $(this).closest('tr').index();

    if (dropIndex === dragIndex) {
        return false;
    } else {
        var dragData = $(this).html();
        $(this).html(data);
        $('#planTable tbody:eq('+tbodyIndex+') tr:eq(' + dragIndex + ') td:odd').html(dragData);
        changePlan();
    }
    
})

.on('click','#cancel',function(){
	Swal.fire({
	   title: '변경 사항은 저장되지 않습니다.',
	   text: '플래너 생성을 중단하고 홈으로 돌아갈까요?',
	   icon: 'warning',
	   
	   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	   confirmButtonText: '예', // confirm 버튼 텍스트 지정
	   cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
	   
	   reverseButtons: false, // 버튼 순서 거꾸로
   
	}).then(result => {
	   // 만약 Promise리턴을 받으면,
	   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	   
	      document.location ="/";
	      
	   }
	});
})

.on('click','#save',function(){
	console.log("작성자 : " + $('#writer').text());
	console.log("제목 : " + $("#title").val());
	console.log("기간 : " + $('#days').text())
	console.log("시작 날짜 : " + $('#start').val());
	console.log("종료 날짜 : " + $('#end').val());
	console.log("인원 : " + $('#people').val());
	console.log("일행 : " + $('#party').val());
	
	var plan = [];
	
	$('#planTable thead').each(function(){

	})
})
;

function getFormattedDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 포맷
    const day = String(today.getDate()).padStart(2, '0'); // 일도 두 자리로 포맷

    const formattedDate = `${year}-${month}-${day}`;
    return formattedDate;
}

function ListShow(data, i){
	let set = $('div[name=contentList]').eq(i);
	set.show();
	set.prev('hr').show();
	let obj = data[i];
	set.find('input[type=hidden]').attr("value",obj['ta_num']);
	set.find('img').attr("src", "/img/t_img/" + obj['ta_img']);
	set.find('h5').text(obj['ta_name']);
	set.find('p').text(obj['ta_local']);
	console.log(set.parent().find('#page').html());
}

function createTable(day) {
	 let html ='<thead style="background-color:black;" name=day' + day +'>'
  		+	'<tr><td style="color:white; width:60px;">시간</td>'
  		+ '<td style="width:800px;"><span name=before>◀ </span> DAY ' + day + ' <span name=after> ▶</span></td></tr>'
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
  var numList = ['1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣', '6️⃣', '7️⃣', '8️⃣', '9️⃣', '🔟'];
  let ndx = 0;
  $('#planTable tbody:eq('+tbodyIndex+') tr').each(function() {
    var $this = $(this).find('td:eq(1)');
    var text = $this.text().trim(); // 공백 제거
    if (text !== '') {
      $this.find('span[name=num]').text(numList[ndx]);
      ndx++;
    }
  });
}

function loadTravelData(ta_num) {
    $.ajax({
        url: "/getPlanData",
        method: "post",
        data: { ta_num : ta_num },
        dataType: "json",
        success: function(data) {
            // 여행지 정보를 순회하면서 마커를 생성하고 이름 설정
            data.forEach(function(travelInfo) {
                let allPosition = new naver.maps.LatLng(travelInfo.ta_latitude, travelInfo.ta_longitude);
                console.log(data.length);
                let marker = new naver.maps.Marker({
                    position: allPosition,
                    map: map,
                    title: ta_num
                });
                markers.push(marker);
                
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
			loadTravelData(planList[i]);
		}
		
		changePlan();
}

function likeFilter(filter) {
	page = "";
	
	$.ajax({ url:'/likeFilter', data: {page : page, filter : filter }, type: 'post', dataType: 'json',
			success: function(data) {
				if (data.length == 5) {
					for( let i=0; i<data.length; i++ ) {
						ListShow(data, i);
					}
				} else {
					for( let i=0; i<data.length; i++ ) {
						ListShow(data, i);
					}
					for ( let i=data.length; i<=$('div[name=contentList]').length; i++){
						let set = $('div[name=contentList]').eq(i);
						set.prev('hr').hide();
						set.hide();
					}
				}
			}, error: function(){
				alert("error!!!");
			}
	})
}