function capacities_list_initCallback(carousel) {
    $('#move_forward').bind('click', function() {
      carousel.next();
      return false;
    });

    $('#move_back').bind('click', function() {
      carousel.prev();
      return false;
    });
};

$(document).ready(function() {

  $('#rollup').click( function(){
    var what = $(this).attr('rel');
    $('#' + what ).slideToggle();
  });


  $("#capacities_list").jcarousel({
      vertical: true,
      initCallback: capacities_list_initCallback,
      buttonNextHTML: null,
      buttonPrevHTML: null
  });
});

