// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// Gem packages
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//
// Kairos
//= require_directory .
//= require_self
//
// Bower packages
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require bootstrap-select/dist/js/bootstrap-select
//
// Turbolinks (must be placed at the end)
//= require turbolinks

$(function() {
    Flash.load();
});
