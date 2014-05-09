//= require jquery-1.11.0.min
//= require jquery-ui-1.10.4.custom.min
//= require jquery_ujs
//= require notices
//= require timer
//= require view
//= require modal
//= require_tree .

// Stop/skip current pomodoro/break using escape key.
$(document).keyup(function(e) {
    if (e.keyCode == 27) { //escape key
      if(confirm("Skip current pomodoro/break?")) {
        window.location.reload();
      }
    }
});
