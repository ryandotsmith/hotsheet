$(document).ready(function() {

  $('#rollup').click( function(){
    var what = $(this).attr('rel');
    $('#' + what ).slideToggle();
  });

 $("#capacities").scrollable({
     items: '.items',
     size: 3
  });

  $("#list").scrollable({
    items: '.items',
    size: 2
  })
});

