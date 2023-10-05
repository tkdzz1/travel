$(document)
.ready(function(){
	let infoWindow = new naver.maps.InfoWindow();
    let isInfoWindowOpen = false;
    let mapOptions = { 
        center: new naver.maps.LatLng(33.3595704, 126.600000),
        zoom: 10
    };	

    let map = new naver.maps.Map('map', mapOptions);
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