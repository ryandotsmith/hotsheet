jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});


$(document).ready(function() {

  $("#AddMoreCapacity").click( function(){
    $("#new_capacity_form").slideToggle();
    return false;
  });
  
  $(".driver_autocomplete").autocomplete('/drivers.json');


  $(".covered_check_box").change( function(){
    var url  = '/capacities/' + $(this).attr('id')
    var data = { fulfilled:$(this).is(':checked') , _method: 'put'}
      $.post( url, data, null,"script");
  });

});
