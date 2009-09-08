$(document).ready(function() {
  $("#AddMoreCapacity").click( function(){
    $("#new_capacity_form").slideToggle();
    return false;
  });
  
  $(".driver_autocomplete").autocomplete('/drivers.json');

 
});

