$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });
  
  $(".animate").click(function(){
    $(".animate").animate({    
        left: "+=280",  
      }, 3000);
    }); 
    
  $(".animate").click(function(){
    $(".right-animate").animate({    
        right: "+=330",  
      }, 3000);
    })
  
      $(".animate").click(function(){
        $(".hello").delay(3000).fadeIn(100);
      });

  var time = $(".remaining-time").text();

  var clock = new FlipClock($('.your-clock'), {
  "countdown":true 
  });
  
  clock.setTime(time);
  clock.start();

});