$(document).ready(function() {

  var api = $("div.scrollable").scrollable({
      vertical: true,
      size: 1,
      api: true
  });
  // scroll to today after load
  var idx = $(".today").attr("rel")
  api.seekTo(parseInt(idx-1))
});

