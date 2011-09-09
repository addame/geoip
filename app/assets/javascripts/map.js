$(function(){
  $("#replace_markres").click(function(){
    $.getJSON("/markers", function(data){
      Gmaps.map.replaceMarkers(data);
    });
  });
});
