$( function (){
  $.getJSON("/get_me", function(data){
    Gmaps.map.addMarkers(data);
  });
});  
$(function(){
  $("#replace_markers").click(function(){
    $.getJSON("/markers", function(data){
      Gmaps.map.map_options.auto_adjust = false;
      Gmaps.map.replaceMarkers(data);       
      Gmaps.map.addMarkers(data);
    });
  });               
});
