// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
  
  toggleCategory(".sports", ".sports_items")
  toggleCategory(".film", ".film_items")
  toggleCategory(".clothing", ".clothing_items")
  toggleCategory(".toys", ".toys_items")
  toggleCategory(".literature", ".literature_items")
  toggleCategory(".automobiles", ".automobiles_items")
  toggleCategory(".space", ".space_items")
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