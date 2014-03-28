// Bolognesa view
// ***************

var view = {
	init: function(){
		// On ready listeners, events and actions
		$(document).ready(function(){
				$('.start-button').click(start);
		});
	}
}

// Initialize view
view.init();
