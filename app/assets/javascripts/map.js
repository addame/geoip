$(function(){
  $("input#show_me").click(function(){
    Gmaps.map.replaceMarkers(dat);
    Gmaps.map.callback();
  });
  $("input#replace_markres").click(function(){
    $.getJSON("/locations", function(data){
      data.push(dat);
      Gmaps.map.replaceMarkers(data);
      Gmaps.map.callback();
    });
  });
  $("input#set_radius").click(function(){
    $.getJSON("/locations/0/search", { radius: $("input#radius").val(), lat: dat.lat, lng: dat.lng }, function(data){
      data.push(dat);
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
      var lt = Math.round(obj.latLng['Ka']*10000)/10000;
      var lg = Math.round(obj.latLng['La']*10000)/10000;
      $.getJSON("/locations", function(data){
	for ( var j = 0; j <  data.length; ++j) {
	   var lat = Math.round(data[j].lat*10000)/10000;
	   var lng = Math.round(data[j].lng*10000)/10000;
	   if ( lt == lat && lg == lng) $("#dsct").val(""+data[j].sidebar);
	}
      });
  }
  var dat;
  $(document).ready(function(){
    var latIP = geoip_latitude();
    var longIP = geoip_longitude();
    dat = {
      "description": "<h1>my position</h1>",
      "sidebar": "",
      "lat": ""+latIP,
      "lng": ""+longIP,
      "picture": "/images/blue-marker.png",
      "width": "25",
      "height": "35"
    }
  });
});
