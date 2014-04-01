// Bolognesa timer
// ***************


// GLOBAL VARIABLES (should be properties of some object)
var current_interval_id;
var current_start_date;
var current_finish_date;
var current_remaining_time = new Date();
var current_is_break = false;
var testing_fast_mode = false;
var current_total_time_lapse = TIME_LAPSE_WORK;

// CONSTANTS
var TIME_LAPSE_WORK = 25*60*1000;
var TIME_LAPSE_BREAK = 5*60*1000;
var TIME_LAPSE_BREAK_LONG = 15*60*1000;



// TIMER METHODS

// Gets the percentage
// Returns number
function getPercentage(){
	var percent_value = 100 - ( current_remaining_time/current_total_time_lapse*100 );
	return percent_value;
}

// It checks if percentage reached 100, if not
// it adds percentage
function incrementProgress(){
	if(getPercentage() >= 100){
		current_remaining_time.setTime(0);
		view.setPercentage(100, current_remaining_time);
		if(current_is_break) {
			finishBreak();
		} else {
			finishPomodoro();
		}
	} else {
		if(testing_fast_mode){
			current_remaining_time.setTime(current_remaining_time.getTime() - 1000*100);
		} else {
			current_remaining_time.setTime(current_remaining_time.getTime() - 1000);
		}
		view.setPercentage(getPercentage(), current_remaining_time);
	}
}

// Finishes and saves pomodoro
function finishPomodoro(){
	stop();
	$.ajax({
		type: 'POST',
		url: "/pomodoris/set_finished"
	});
	view.playDing();
	/* $.ajax({
		type: 'POST',
		url: "/pomodoris/set_tags"
	}); */
	current_is_break = true;
	view.showStartButton();
}

// Starts counting working time
function start(){
	stop();

  current_start_date = new Date();
  current_finish_date = new Date();
  current_finish_date.setTime(current_start_date.getTime()+current_total_time_lapse);
  current_remaining_time = new Date();
  current_remaining_time.setTime(current_total_time_lapse);

	view.setPercentage(0, current_remaining_time);
	current_interval_id = setInterval(incrementProgress, 1000);
	if (!current_is_break) {
		$.ajax({
			type: 'POST',
			url: "/pomodoris/create"
		});
	}
}

// Stops timer
function stop(){
	clearInterval(current_interval_id);
	view.setPercentage(0, current_remaining_time);
}

function startPomodoro(){
	current_is_break = false;
	view.showWorkingButton();
	$('body').removeClass("break");
	current_total_time_lapse = TIME_LAPSE_WORK;
	start();
}
function startBreak(){
	current_is_break = true;
	view.showRelaxingButton();
	$('body').addClass("break");
	current_total_time_lapse = TIME_LAPSE_BREAK;
	start();
}
function finishBreak(){
	stop();
	view.playDing();
	current_total_time_lapse = TIME_LAPSE_WORK;
	$('body').removeClass("break");
	view.showStartButton();
	current_is_break = false;
}
function startToggle(){
	if(current_is_break) {
		startBreak();
	} else {
		startPomodoro();
	}
}
