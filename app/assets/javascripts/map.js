$(function(){
  $("input#show_me").click(function(){
    $("input#radius").val('');
    Gmaps.map.map.maxZoom = 11;
    Gmaps.map.replaceMarkers(dat);
    Gmaps.map.callback();
  });
  $("input#replace_markres").click(function(){
    Gmaps.map.map.maxZoom = 20;
    $("input#radius").val('');
    $.getJSON("/locations", function(data){
      data.push(dat);
      Gmaps.map.replaceMarkers(data);
      Gmaps.map.callback();
    });
  });
  $("input#set_radius").click(function(){
    Gmaps.map.map.maxZoom = 20;
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
      //console.log( obj.latLng);
      var lt = Math.round(obj.latLng['Ja']*10000)/10000;
      var lg = Math.round(obj.latLng['Ka']*10000)/10000;
      $.getJSON("/locations", function(data){
	for ( var j = 0; j <  data.length; ++j) {
	   var lat = Math.round(data[j].lat*10000)/10000;
	   var lng = Math.round(data[j].lng*10000)/10000;
	   if ( lt == lat && lg == lng) $("#dsct").val(""+data[j].sidebar);
	}
      });
  }
  $('form').submit(function(){
    Gmaps.map.map.maxZoom = 20;
    $.getJSON("/locations/0/search", { radius: $("input#radius").val(), lat: dat.lat, lng: dat.lng }, function(data){
      data.push(dat);
      Gmaps.map.replaceMarkers(data);
      Gmaps.map.callback();
    });
    return false;
  });
  var dat;
  $(document).ready(function(){
    if($.find("#mapid").length != 0){
      if(google.loader.ClientLocation){
        var latIP = google.loader.ClientLocation.latitude; 
        var longIP = google.loader.ClientLocation.longitude;
      } else {
        var latIP = 0;
	var longIP = 0;
      }
      dat = {
        "description": "<h1>my position</h1>",
        "sidebar": "",
        "lat": ""+latIP,
        "lng": ""+longIP,
        "picture": "/images/blue-marker.png",
        "width": "25",
        "height": "35"
      }
    }
  });
});
