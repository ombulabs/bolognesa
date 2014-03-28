// Show and hide notices

function drawFlashMessage(message_text, message_type){
  // message type: notice, warning, error
  if($("#flash-container").length > 0){
    $("#flash-container").html("");
    $("#flash-container").append('<div class="flash ' + message_type + '" style="display: none;">' + message_text + '</div>');
  }
  showFlashMessages();
}

function showFlashMessages(){
  if($(".notice").length > 0){
    $(".notice").hide().delay(500).slideDown(500).delay(6000).slideUp(500);
  }
}

$(document).ready(function(){
	showFlashMessages();
});