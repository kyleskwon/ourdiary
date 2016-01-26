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
//= require bootstrap
//= require moment
//= require fullcalendar
//= require_tree .
//= require_self

function initialize() {
  console.log("initializing!");
  var mapProp = {
    center:new google.maps.LatLng(51.508742, -0.120850),
    zoom: 7,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
}

$(document).ready(function() {
  console.log("loaded!");
  initialize();
});
