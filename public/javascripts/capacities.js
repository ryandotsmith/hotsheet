jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
// 
// notice the focus date! This is here because 
// the create action needs to know which date the user is 
// focusing on. If the use is focusing on today's date and they 
// add capacity for today, then we generate a new focus capacity table 
// else we throw the new capacity in the sidebar
//
jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize() + "&focus_date=" + FOCUS_DATE , null, "script");
    return false;
  })
  return this;
};

$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});


$(document).ready(function() {
  //
  // look at the capacity rows and if there are coverd we want to remove the links to edit or delete them!
  if($("#capacity_today_table > tbody > tr ").hasClass("covered")){
    $("#capacity_today_table > tbody > tr ").children('.covered > td.edit ').children('a').css("display","none")
    $("#capacity_today_table > tbody > tr ").children('.covered > td.delete').children('a').css("display","none")
  } else {
  }// end if else

  //turn on default page listeners
  $(".covered_check_box").click( function(){
    var url  = '/capacities/' + $(this).attr('id')
    var data = { fulfilled:$(this).is(':checked') , _method: 'put'}
      $.post( url, data, null,"script");
  });
  $(".edit_link").click( function(){
    var url = $(this).attr('href');
    $.ajax({
      type: 'get',
      url: url,
      dataType: "script"
    });
    return false;
  })
  $(".new_link").click( function(){
    $.ajax({
      type: "get",
      url: $(this).attr("href"),
      dataType: "script"
    });
    return false;
  })
  $(".delete_link").click( function(){
    $.ajax({
        type: "delete",
        url: $(this).attr("href"),
        data: "&authenticity_token="+encodeURIComponent(window.rails_authenticity_token),
        dataType: "script"
    });
    return false;
  });
  $('#rollup').click( function(){
    $("#capacity_form").slideToggle();
    return false;
  });

});
