// Bolognesa timer
// ***************

var current_interval_id;

var current_start_date;
var current_finish_date;
var current_remaining_time = new Date();

var show_remaining_time_as_percentage = false;

// Sets the percentage
function setPercentage(percent, remaining_time){
	var _percent = Number(percent);
	$('#timer-progress').attr("value", percent);
	if(show_remaining_time_as_percentage){
		$('.visible-progress-value').html(Math.floor(percent) + "%");
	} else {
		var remaining_time_string = remaining_time.getMinutes() + ":" + remaining_time.getSeconds();
		$('.visible-progress-value').html(remaining_time_string);
	}
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
		var _percent;

		var percent_to_add = 100 / (25*60); // el posta
		// var percent_to_add = 100 / (25*60) * 100; // provisorio para testing

		_percent = getPercentage() + percent_to_add;
		current_remaining_time.setTime(current_finish_date.getTime() - 1000);
		console.log("current_remaining_time: "+current_remaining_time);
		setPercentage(_percent, current_remaining_time);
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
  current_finish_date.setTime(current_start_date.getTime()+(25*60*1000));

	setPercentage(0, current_finish_date);
	current_interval_id = setInterval(addPercentage,1000);
  $.ajax("/pomodoris/create");
}

// Time remaining until the end of the pomodoro
// Returns Date object
function getRemainingTime(){
	var now = new Date();
	var difference = new Date();
	difference.setTime(now.getTime() - current_finish_date.getTime());
	return difference;
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
