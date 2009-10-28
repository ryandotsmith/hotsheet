$(document).ready(function() {

  var api = $("div.scrollable").scrollable({
      vertical: true,
      size: 1,
      keyboard:false, 
      api: true
  });
  $("div.scrollable").mousewheel();
  // scroll to today after load
  var idx = $(".today").attr("rel")
  api.seekTo(parseInt(idx-1))
});

