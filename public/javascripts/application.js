$(document).ready(function() {

  $('#rollup').click( function(){
    var what = $(this).attr('rel');
    $('#' + what ).slideToggle();
  });

  $("#capacities").scrollable();

});

