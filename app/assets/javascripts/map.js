$(function(){
  var lantitude;
  var longitude;
  $("input#replace_markres").click(function(){
    $.getJSON("/markers", function(data){
      Gmaps.map.replaceMarkers(data);
      Gmaps.map.callback();
    });
  });
  $("input#set_radius").click(function(){
    $.getJSON("/near", { radius: $("input#radius").val(), lat: lantitude, lng: longitude }, function(data){
      Gmaps.map.replaceMarkers(data);
      Gmaps.map.callback();
    });
  });

  Gmaps.map.callback = function() {
    for (var i = 0; i <  this.markers.length; ++i) {
      google.maps.event.addListener( Gmaps.map.markers[i].serviceObject, 'click', function(obj) {
        getDsctMarker(obj);
      });
     }
  };
  function getDsctMarker(obj){
      var lt = Math.round(obj.latLng['Pa']*10000)/10000;
      var lg = Math.round(obj.latLng['Qa']*10000)/10000;
      $.getJSON("/markers", function(data){
	for ( var j = 0; j <  data.length; ++j) {
	   var lat = Math.round(data[j].lat*10000)/10000;
	   var lng = Math.round(data[j].lng*10000)/10000;
	   if ( lt == lat && lg == lng) $("#dsct").val(""+data[j].sidebar);
	}
      });
  }
  $(window).ready(function(){
    lantitude = $("div#lat").text(); 
    longitude = $("div#lng").text();
  });
});
