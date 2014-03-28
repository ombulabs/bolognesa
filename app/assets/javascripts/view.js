// Bolognesa view
// ***************

var view = {
	init: function(){
		// On ready listeners, events and actions
		$(document).ready(function(){
				$('.start-button').click(function(e){
					e.target.blur();
					startToggle();
				});

		});
	}
}

// Initialize view
view.init();
