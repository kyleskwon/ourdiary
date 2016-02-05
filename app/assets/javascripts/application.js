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
    center:new google.maps.LatLng(0, 0),
    zoom: 2,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  window.googleMap = new google.maps.Map(document.getElementById("googleMap"), mapProp);

}
function setMarker(lat, long, title) {
  var marker = new google.maps.Marker({
    position: {lat: lat, lng: long},
    map: window.googleMap,
    title: title
  });
}
$(document).ready(function() {
  console.log("loaded!");
  initialize();
});
