// Bolognesa timer
// ***************

var interval_id;

var show_remaining_time_as_percentage = true;

// Sets the percentage
function setPercentage(percent){
	var _percent = Number(percent);
	$('#timer-progress').attr("value", percent);
	$('.visible-progress-value').html(Math.floor(percent) + "%");
}

// Gets the percentage
// Returns number
function getPercentage(){
	var percent_value = Number( $('#timer-progress').attr("value") );
	return percent_value;
}

// It checks if percentage reached 100, if not
// it adds percentage
function addPercentage(){
	if(getPercentage() >= 100){
		finishPomodoro();
	} else {
		// var percent_to_add = 100 / (25*60); // el posta
		var percent_to_add = 100 / (25*60) * 100; // provisorio para testing
		setPercentage(getPercentage() + percent_to_add);
	}
}

// Finishes and saves pomodoro
function finishPomodoro(){
	stop();
	playDing();
	$.ajax("/pomodoris/set_finished");
}

// Starts counting working time
function start(){
	stop();
	setPercentage(0);
	interval_id = setInterval(addPercentage,1000);
  $.ajax("/pomodoris/create");
}

// Stops timer
function stop(){
	clearInterval(interval_id);
}

// Plays ding sound, using HTML5 <audio> tag
function playDing(){
	document.getElementById('audio-ding').currentTime = 0;
	document.getElementById('audio-ding').load();
	document.getElementById('audio-ding').play();
}
