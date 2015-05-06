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
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  
  toggleCategory(".lager", "#lager_beers")
  toggleCategory(".stout", "#stout_beers")
  toggleCategory(".ipa", "#ipa_beers")
  toggleCategory(".ale", "#ale_beers")
  toggleCategory(".blonde", "#blonde_beers")
  
  
  function toggleCategory(categoryID, beerID){
    $(categoryID).click(function(){
      $(beerID).toggleClass("hidden");
    });
  }
  
});