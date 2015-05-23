$(document).ready(function(){

  $("#logo").hover(function(){
    $(".big-e").stop().animate({'font-size': 35});
  },function(){
    $(".big-e").stop().animate({'font-size': 30});
  });

});