// Bolognesa timer
// ***************

var interval_id;

function setPercentage(percent){
	var _percent = Number(percent);
	$('#timer-progress').attr("value", percent);
	$('.visible-progress-value').html(percent);
}

function getPercentage(){
	var percent_value = Number( $('#timer-progress').attr("value") );
	return percent_value;
}
function addPercentage(){
	if(getPercentage() >= 100){
		stop();
		playDing();
	} else {
		var percent_to_add = 1;
		setPercentage(getPercentage() + percent_to_add);
	}
}
function start(){
	interval_id = setInterval(addPercentage,100);
  $.ajax("/pomodoris/create");
}
function stop(){
	clearInterval(interval_id);
}
function playDing(){
	document.getElementById('audio-ding').play();
}



$(document).ready(function(){
	$('.start-button').click(start);
});
