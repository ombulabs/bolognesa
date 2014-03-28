// Bolognesa view
// ***************

var view = {
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
	showStartButton: function(){
		view.hideWorkingButton();
		view.hideRelaxingButton();
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
	}
}

// Initialize view
view.init();
