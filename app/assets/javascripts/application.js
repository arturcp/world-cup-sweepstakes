// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require rails-ujs
//= require materialize
//= require select2
//= require page
//= require almond
//= require event-dispatcher
//= require loading

//= require_tree .

// Source: https://stackoverflow.com/questions/995183/how-to-allow-only-numeric-0-9-in-html-inputbox-using-jquery
jQuery.fn.forceNumericOnly = function() {
  return this.each(function() {
    $(this).keydown(function(e) {
      var key = e.charCode || e.keyCode || 0;
      // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
      // home, end, period, and numpad decimal
      return (
          key == 8 ||
          key == 9 ||
          key == 13 ||
          key == 46 ||
          key == 110 ||
          key == 190 ||
          (key >= 35 && key <= 40) ||
          (key >= 48 && key <= 57) ||
          (key >= 96 && key <= 105));
    });
  });
};

$(document).on('ready page:load', function() {
  page.dispatch();
});
