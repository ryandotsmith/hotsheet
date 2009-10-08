function capacities_list_initCallback(carousel) {
    $('#move_forward').bind('click', function() {
      carousel.next();
      return false;
    });

    $('#move_back').bind('click', function() {
      carousel.prev();
      return false;
    });
    $('#today_link').bind('click', function(){
      var todayIndex = $(".today").attr('jcarouselindex');
      carousel.scroll(todayIndex);
      return false;
    });
};

$(document).ready(function() {

  $("#capacities_list").jcarousel({
      scroll: 1,
      vertical: true,
      visible: 3,
      initCallback: capacities_list_initCallback,
      buttonNextHTML: null,
      buttonPrevHTML: null
  });

});

