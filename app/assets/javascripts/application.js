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
//= require jquery
//= require rails-ujs
//= require popper
//= require bootstrap
//= require summernote/summernote-bs4.min
//= require summernote-init
//= require activestorage
//= require turbolinks
//= require_tree .

// load specific locale(ja-JP)
//= require summernote/lang/summernote-ja-JP

$(function(){
  $('.print').click(function(){
    let header = $('header'),
        footer = $('footer');
        comments = $('.print-hide');

    header.hide();
    footer.hide();
    comments.hide();


    window.print();

    header.show();
    footer.show();
    comments.show();

  });
});

$(document).on('turbolinks:load', function() {
  $(function() {
    $('.a').slick({
        dots: true,
        autoplay: true,
        autoplaySpeed: 5000,
    });
  });
});