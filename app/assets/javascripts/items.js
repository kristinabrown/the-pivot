$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });

});