// Bolognesa timer
// ***************

var current_interval_id;

var current_start_date;
var current_finish_date;
var current_remaining_time;

var time_lapse_work = 25*60*1000;
var time_lapse_break = 5*60*1000;
var time_lapse_break_long = 15*60*1000;

var show_remaining_time_as_percentage = false;
var testing_fast_mode = true;

// Sets the percentage
function setPercentage(percent, remaining_time){
	var _percent = Number(percent);
	$('#timer-progress').attr("value", percent);
	if(show_remaining_time_as_percentage){
		$('.visible-progress-value').html(Math.floor(percent) + "%");
	} else {
		var remaining_time_string = remaining_time.getMinutes() + ":" + (remaining_time.getSeconds() < 10 ? "0"+remaining_time.getSeconds() : remaining_time.getSeconds());
		$('.visible-progress-value').html(remaining_time_string);
	}
}

// Gets the percentage
// Returns number
function getPercentage(){
	var percent_value = 100 - ( current_remaining_time/time_lapse_work*100 );
	return percent_value;
}

// It checks if percentage reached 100, if not
// it adds percentage
function incrementProgress(){
	if(getPercentage() >= 100){
		current_remaining_time.setTime(0);
		setPercentage(100, current_remaining_time);
		finishPomodoro();
	} else {
		if(testing_fast_mode){
			current_remaining_time.setTime(current_remaining_time.getTime() - 1000*100);
		} else {
			current_remaining_time.setTime(current_remaining_time.getTime() - 1000);
		}
		setPercentage(getPercentage(), current_remaining_time);
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

  current_start_date = new Date();
  current_finish_date = new Date();
  current_finish_date.setTime(current_start_date.getTime()+time_lapse_work);
  current_remaining_time = new Date();
  current_remaining_time.setTime(time_lapse_work);

	setPercentage(0, current_remaining_time);
	current_interval_id = setInterval(incrementProgress, 1000);
  $.ajax("/pomodoris/create");
}

// Stops timer
function stop(){
	clearInterval(current_interval_id);
}

// Plays ding sound, using HTML5 <audio> tag
function playDing(){
	document.getElementById('audio-ding').currentTime = 0;
	document.getElementById('audio-ding').load();
	document.getElementById('audio-ding').play();
}
