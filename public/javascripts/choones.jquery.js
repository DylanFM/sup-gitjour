(function ($) {
	$.choones = function (title, message) {
		var args = arguments[2] || {};
		
		init(title, message, args);
	}
	
	//
	// == Public methods
	//
	$.extend($.choones, {
	  settings: {
	    type: 'success',
			display_time: 5000
	  },
	  
		display: function () {
			$('#choones').fadeIn();
			this.timeout = setTimeout(function () {
				$('#choones').fadeOut();
			}, $.choones.settings.display_time);
		}
	});
	
	//
	// == Private methods
	//
	
	init = function (title, message, args) {
		display = {title: title, message: message};
		$.choones.settings = $.extend($.choones.settings, args);
		
		resetTimeout();
		setType();
		setMessage();
		$.choones.display();
	}
	
	resetTimeout = function () {
		if(this.timeout) {
			clearTimeout(this.timeout);
		}
	}
	
	// Set either a success or failure state
	setType = function () {
		$('#choones')[0].className = $.choones.settings.type;
	}
	
	setMessage = function () {
		$('#choones').children('h3').text(display.title);
		$('#choones').children('p').text(display.message || '');
	}

})(jQuery);