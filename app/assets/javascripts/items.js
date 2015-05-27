$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });

  var time = $(".remaining-time").text();
  

  var clock = new FlipClock($('.your-clock'), {
  "countdown":true
  });
  
  clock.setTime(36);
  clock.start(time);
  
});