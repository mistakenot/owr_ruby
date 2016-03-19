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
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
//= require jquery-star-rating

var setupSelectableStars = function() {
  var selector = "input.selectable-star";
  var trueClass = "selected-star";
  var falseClass = "selectable-star";

  $(selector).each(function() {
    $(this).click(function() {
      var selectedValue = this.value;
      var others = selector + "[name=" + this.name + "]"
      $(others).each(function() {
        if (this.value < selectedValue) {
          $(this).removeClass(falseClass);
          $(this).addClass(trueClass);
        } else {
          $(this).removeClass(trueClass);
          $(this).addClass(falseClass);
        }
      })
    })
  })
}
