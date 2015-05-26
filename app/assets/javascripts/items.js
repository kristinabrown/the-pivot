$(document).ready(function(){

  $(".stores").hover(function(){
    $(this).stop().animate({"opacity": .65});
},function(){
    $(this).stop().animate({"opacity": 1});
  });
  
  $(".animate").click(function(){
    $(".animate").animate({    
        left: "+=200",  
      }, 3000);
    }); 
  
  $(".animate").click(function(){
    $(".right-animate").animate({    
        right: "+=200",  
      }, 3000);
    }).addClass(".re-animate")
  
  $(".re-animate").click(function(){
    $(".animate").animate({    
        right: "+=200",  
      }, 3000);
    });       
});