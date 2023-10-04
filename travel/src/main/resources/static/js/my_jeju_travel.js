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