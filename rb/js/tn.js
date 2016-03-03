(function($){
  $(function(){

    $('.slider').slider({full_width: false, height: 250});
    $('.slider').slider('start');
    $('.slider').slider('next');
    $('.button-collapse').sideNav({
      closeOnClick: true
    });
    $('.parallax').parallax();
    setInterval(,10);
  }); // end of document ready

  var mn = $(".mainNav");
  // min-height for header is 700
  $(window).scroll(function() {
    if($(this).scrollTop() > 700) {
      mn.addClass("mainNavScrolled");
    }
    else {
      mn.removeClass("mainNavScrolled");
    }
    if($(this).scrollTop() > 700) {
      mn.addClass("smallNav");
    }
    else {
      mn.removeClass("smallNav");
    }
  })
  $("#logo-container").click(function() {
    $("body").animate({
      scrollTop:0
    },"slow");
  });
})(jQuery); // end of jQuery name space


//***** Changing Gradient for mainNav start *****/
var colors = new Array(
  [239,154,154],
  [244,143,177],
  [206,147,216],
  [41,182,246],
  [66,165,245],
  [171,71,188]
);
var step = 0;
//color table indices for: 
// current color left
// next color left
// current color right
// next color right
var colorIndices = [0,1,2,3];

//transition speed
var gradientSpeed = 0.002;

function updateGradient()
{
  if ( $===undefined ) return;
  
  var c0_0 = colors[colorIndices[0]];
  var c0_1 = colors[colorIndices[1]];
  var c1_0 = colors[colorIndices[2]];
  var c1_1 = colors[colorIndices[3]];

  var istep = 1 - step;
  var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
  var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
  var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
  var color1 = "rgb("+r1+","+g1+","+b1+")";

  var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
  var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
  var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
  var color2 = "rgb("+r2+","+g2+","+b2+")";

  $('#mainNav').css({
    background: "-webkit-gradient(linear, left top, right top, from("+color1+"), to("+color2+"))"
  }).css({
    background: "-moz-linear-gradient(left, "+color1+" 0%, "+color2+" 100%)"
  });
  
  step += gradientSpeed;
  if ( step >= 1 )
  {
    step %= 1;
    colorIndices[0] = colorIndices[1];
    colorIndices[2] = colorIndices[3];
    
    //pick two new target color indices
    //do not pick the same as the current one
    colorIndices[1] = ( colorIndices[1] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    colorIndices[3] = ( colorIndices[3] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    
  }
}
//***** Changing Gradient for mainNav end *****/

//***** Scrollspy feature start *****/
var lastId,
    mainNav = $("#mainNav"),
    mainNavHeight = mainNav.outerHeight()+15,
    navItems = mainNav.find(".scrollspy"),
    scrollItems = navItems.map(function(){
      var item = $($(this).attr("href"));
      if (item.length) { return item; }
    });

navItems.click(function(e){
  var href = $(this).attr("href"),
      offsetTop = href === "#" ? 0 : $(href).offset().top-mainNavHeight+1;
  $('html, body').stop().animate({ 
      scrollTop: offsetTop
  }, 300);
  e.preventDefault();
});

$(window).scroll(function(){
   var fromTop = $(this).scrollTop()+mainNavHeight;
   
   var cur = scrollItems.map(function(){
     if ($(this).offset().top < fromTop)
       return this;
   });
   cur = cur[cur.length-1];
   var id = cur && cur.length ? cur[0].id : "";
   
   if (lastId !== id) {
       lastId = id;
       navItems
         .parent().removeClass("active")
         .end().filter("[href='#"+id+"']").parent().addClass("active");
   }                   
});
//***** Scrollspy feature end *****/

//***** Animation *****/
function animateIfVisible(el, sub_el) {
  currentTop = $(window).scrollTop();
  windowHeight = $(window).height();
  currentBottom = currentTop + windowHeight;
  elTop = $(el).offset().top;
  elHeight = $(el).height();
  elBottom = elTop + elHeight;

  if(elTop >= currentTop && elBottom <= currentBottom) {
    $(sub_el).addClass("fadeUp");
  }
}

function addfadeInClass(el){
  $(el).addClass("foo");
}
