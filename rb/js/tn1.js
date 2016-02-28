(function($){
  $(function(){

    $('.button-collapse').sideNav();
    $('.parallax').parallax();

  }); // end of document ready

  var mn = $(".mainNav");
  $(window).scroll(function() {
    if($(this).scrollTop() > 700) {
      mn.addClass("mainNavScrolled");
    }
    else {
      mn.removeClass("mainNavScrolled");
    }
  })
})(jQuery); // end of jQuery name space