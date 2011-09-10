$(function(){
  $("#replace_markres").click(function(){
    $.getJSON("/markers", function(data){
      Gmaps.map.replaceMarkers(data);
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
    for ( var j = 0; j <  Gmaps.map.markers.length; ++j) {
      var lat =  Gmaps.map.markers[j].lat;
      var lng =  Gmaps.map.markers[j].lng;
      var lt = Math.round(obj.latLng['Pa']*100000000)/100000000;
      var lg = Math.round(obj.latLng['Qa']*100000000)/100000000;
      if ( lt == lat && lg == lng) $("#dsct").val(""+Gmaps.map.markers[j].sidebar);
    }
  }
});
