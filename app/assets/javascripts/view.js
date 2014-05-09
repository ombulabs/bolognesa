// Bolognesa view
// ***************

var view = {
	show_remaining_time_as_percentage: false,
	init: function(){
		// On ready listeners, events and actions
		$(document).ready(function(){

			view.showStartButton();
			view.hideWorkingButton();
			view.hideRelaxingButton();

			$('.start-button').click(function(e){
				e.target.blur();
				startToggle();
			});

		});
	},

	// Sets the percentage
	setPercentage: function(percent, remaining_time){
		var _percent = Number(percent);
		$('#timer-progress').attr("value", percent);
		if(view.show_remaining_time_as_percentage){
			$('.visible-progress-value').html(Math.floor(percent) + "%");
		} else {
			var remaining_time_string = remaining_time.getMinutes() + ":" + (remaining_time.getSeconds() < 10 ? "0"+remaining_time.getSeconds() : remaining_time.getSeconds());
			$('.visible-progress-value').html(remaining_time_string);
		}
	},

	// Plays ding sound, using HTML5 <audio> tag
	playDing: function(){
		document.getElementById('audio-ding').currentTime = 0;
		document.getElementById('audio-ding').load();
		document.getElementById('audio-ding').play();
	},

	showStartButton: function(){
		view.hideWorkingButton();
		view.hideRelaxingButton();
		if(current_is_break){
			$('.start-button').html("Start break" +
			"<br /><div style='font-size: 0.4em; margin-bottom: -10px'>" +
			"Or skip pressing esc </div>");
		} else {
			$('.start-button').html("Start");
		}
		$('.start-button').show();
	},
	showWorkingButton: function(){
		view.hideStartButton();
		view.hideRelaxingButton();
		$('.working-button').show();
	},
	showRelaxingButton: function(){
		view.hideStartButton();
		view.hideWorkingButton();
		$('.relaxing-button').show();
	},
	hideStartButton: function(){
		$('.start-button').hide();
	},
	hideWorkingButton: function(){
		$('.working-button').hide();
	},
	hideRelaxingButton: function(){
		$('.relaxing-button').hide();
	},

	// Flashes pomodoro
	flashPomodoro: function($pomodoro_to_flash){
	  if($pomodoro_to_flash && $pomodoro_to_flash.length > 0) {
	    $pomodoro_to_flash.delay(200).effect( "highlight", 1000 );
	  }
	}

}

// Initialize view
view.init();
