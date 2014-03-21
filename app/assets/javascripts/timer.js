// Bolognesa timer
// ***************

function setPercentage(percent){
	$('#timer-progress').attr("value", percent);
	$('.visible-progress-value').html(percent);
}

$(document).ready(function() {
  $('button').on('click', function () {
    $.ajax("/pomodoris/create")
	});
});
