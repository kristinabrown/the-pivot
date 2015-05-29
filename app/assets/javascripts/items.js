$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });
  
  $(".animate").click(function(){
    $(".animate").animate({    
        left: "+=250",  
      }, 3000);
    }); 
    
  
      $(".animate").click(function(){
        $(".hello").delay(3000).fadeIn(100);
      });

  
  $(".animate").click(function(){
    $(".right-animate").animate({    
        right: "+=280",  
      }, 3000);
    })
   
});