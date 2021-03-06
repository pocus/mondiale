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
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .


// Initializer when page loaded
$(document).ready(function() {

  // Foundation Initialize
  $(document).foundation();

  // Initialize Offcanvas menu
  sidebar();

  // Initialize Welcome Page JavaScript
  welcomePage();

  // Bind flash alerts
  flashAlertEffect();

  // bind delete photo Button
  deletePictureBtn();

  // Set user form to middle of the Y-axis
  var userForm = $('#user.form');
  if (userForm.length) {
    setHeight(userForm);
    setYtoM($('#user.form .form-container'))
  }

  // Set trip cover photo
  coverPage();
  coverPhoto();

  // generate google map
  loadMaps();

  $('#chapters-list').sortable(
    {
       axis: "y",
       update: function(event, ui){
            var data = $(this).sortable('serialize');

            $.ajax({
                data: data,
                url: "/trips/sort_chapter_items",
                type: 'POST'
            });

       }//end function argument
    } //end argument
  ); // end sortable

  smoothScrollHash(500);

});

