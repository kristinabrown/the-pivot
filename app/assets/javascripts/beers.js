$(document).ready(function(){
  
  toggleCategory(".sportsmemorabilia", ".sportsmemorabilia_items")
  toggleCategory(".tvmovieclassics", ".tvmovieclassics_items")
  toggleCategory(".luxury", ".luxury_items")
  toggleCategory(".animationcomics", ".animationcomics_items")
  toggleCategory(".celebrity", ".celebrity_items")
  toggleCategory(".automobiles", ".automobiles_items")
  toggleCategory(".vintageclothing", ".vintageclothing_items")
  toggleCategory(".toysgames", ".toysgames_items")
  toggleCategory(".literature", ".literature_items")
  toggleCategory(".music", ".music_items")
  toggleAllCategory()
  
  
  
  function toggleCategory(categoryID, beerID){
    var currentCategory = this.value;
    
    $(categoryID).click(function(){
      $(beerID).toggleClass("hidden");
    });
  }
  
  function toggleAllCategory(){
    $(".all").click(function(){
      $(".two").toggleClass("hidden");
    });
  }  
  
});