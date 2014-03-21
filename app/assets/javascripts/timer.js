// Bolognesa timer
// ***************

var interval_id;

function setPercentage(percent){
	var _percent = Number(percent);
	$('#timer-progress').attr("value", percent);
	$('.visible-progress-value').html(Math.floor(percent*100)/100);
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
		var percent_to_add = 100 / (25*60) * 100;
		setPercentage(getPercentage() + percent_to_add);
	}
}
function start(){
	setPercentage(0);
	interval_id = setInterval(addPercentage,1000);
  $.ajax("/pomodoris/create");
}
function stop(){
	clearInterval(interval_id);
}
function playDing(){
	document.getElementById('audio-ding').currentTime = 0;
	document.getElementById('audio-ding').load();
	document.getElementById('audio-ding').play();
}



$(document).ready(function(){
	$('.start-button').click(start);
});
