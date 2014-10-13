//= require jquery-1.11.0.min
//= require jquery-ui-1.10.4.custom.min
//= require jquery_ujs
//= require tag-it.min
//= require notices
//= require timer
//= require view
//= require modal
//= require_tree .

var skip_pomodoro = false;
// Stop/skip current pomodoro/break using escape key.
$(document).keyup(function(e) {
    if (e.keyCode == 27) { //escape key
      if(confirm("Skip current pomodoro/break?")) {
        window.location.reload();
        skip_pomodoro = true;
      }
    }
});

$(window).bind('beforeunload', function(){
  if(getPercentage() >= 0 && getPercentage() < 100 && skip_pomodoro == false) {
    return 'A pomodoro is currently running, and it will be lost if you exit.';
  }
});

window.addEventListener('load', function () {
  if (window.Notification && Notification.permission !== "granted") {
    Notification.requestPermission(function (status) {
      if (Notification.permission !== status) {
        Notification.permission = status;
      }
    });
  }
});
