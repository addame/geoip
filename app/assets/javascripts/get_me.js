$( function (){
  $.getJSON("/get_me", function(data){
    Gmaps.map.addMarkers(data);
  });
});  
