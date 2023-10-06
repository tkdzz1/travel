$(document)
.ready(function(){
	let today = getFormattedDate();
	$('#start').attr('min', today);
	$('#end').attr('min', today);
	$('#start').attr('value', today);
	
	let infoWindow = new naver.maps.InfoWindow();
    let isInfoWindowOpen = false;
    let mapOptions = { 
        center: new naver.maps.LatLng(33.3595704, 126.600000),
        zoom: 10
    };	

    let map = new naver.maps.Map('map', mapOptions);
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
		$('#list ul:eq(1) li').removeClass('select');
		$(this).addClass('select');
		return false;
	}
})

.on('click','#page a',function(){
	page = $(this).attr("id");
	
	if ( $(this).hasClass('strong') ){
		return false;
	}
	
	$.ajax({ url:'/pageMove', type:'post', data: {page : page}, dataType: 'json',
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
	if ( $('#dayCheck').text() == '' ) {
		return false;
	}
	
	
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
	set.find('img').attr("src", "/img/t_img/" + obj['ta_img']);
	set.find('h5').text(obj['ta_name']);
	set.find('p').text(obj['ta_local']);
}

function createTable(day) {
	 let html ='<thead style="background-color:black;">'
  		+	'<tr><td style="color:white; width:60px;">시간</td>'
  		+ '<td style="width:800px;">DAY ' + day + '</td></tr>'
  		+ '</thead>'
  		+ '<tbody>' 
  		+	'<tr><td>05:00</td><td></td></tr>'
  		+	'<tr><td>06:00</td><td></td></tr>'
  		+	'<tr><td>07:00</td><td></td></tr>'
  		+	'<tr><td>08:00</td><td></td></tr>'
  		+	'<tr><td>09:00</td><td></td></tr>'
  		+	'<tr><td>10:00</td><td></td></tr>'
  		+	'<tr><td>11:00</td><td></td></tr>'
  		+	'<tr><td>12:00</td><td></td></tr>'
  		+	'<tr><td>13:00</td><td></td></tr>'
  		+	'<tr><td>14:00</td><td></td></tr>'
  		+	'<tr><td>15:00</td><td></td></tr>'
  		+	'<tr><td>16:00</td><td></td></tr>'
  		+	'<tr><td>17:00</td><td></td></tr>'
  		+	'<tr><td>18:00</td><td></td></tr>'
  		+	'<tr><td>19:00</td><td></td></tr>'
  		+	'<tr><td>20:00</td><td></td></tr>'
  		+	'<tr><td>21:00</td><td></td></tr>'
  		+	'<tr><td>22:00</td><td></td></tr>'
  		+	'<tr><td>23:00</td><td></td></tr>'
  		+  '</tbody>'
  		return html;
}