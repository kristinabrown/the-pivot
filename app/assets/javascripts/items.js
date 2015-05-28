$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });
  
  $(".animate").click(function(){
    $(".animate").animate({    
        left: "+=150",  
      }, 3000);
    }); 
    
  
      $(".animate").click(function(){
        $(".hello").delay(4000).toggleClass("hidden");
      });

  
  $(".animate").click(function(){
    $(".right-animate").animate({    
        right: "+=150",  
      }, 3000);
    })
   
});