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
	let planNum = $(this).attr("id");
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
			
			$('#planTable tbody').each(function(){
				
				let planNum = 0;	
				
				$(this).find('tr').each(function(){
					
					let att = $(this).find('td:eq(1)');
					
					let time = $(this).find('td:eq(0)').attr("name");
					
					planTime = plan[day-1].split("*");
					
					if ( planTime[planNum].split(":")[0] == time ) {
						att.html( planTime[planNum].split(":")[1] );
						planNum++;
					}
					
					if ( planNum == planTime.length ) {
						return true;
					}
					
				})
				
				day++;
				
			})
			
		}, error: function(){
			
		}
		
	})
	$("#myModal").show();
})

$("#closeModalBtn").click(function() {
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
  		+ '<td style="width:800px;"><span name=before>◀ </span> <span name=day>DAY ' + day + '</span><span name=after> ▶</span></td></tr>'
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