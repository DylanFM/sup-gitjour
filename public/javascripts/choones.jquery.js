(function ($) {
	$.choones = function (title) {
		var args = arguments[1] || {};
		init(title, args);
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
		  var el = $("#choones div:last");
			el.fadeIn();
			this.timeout = setTimeout(function () {
				el.fadeOut(function(){
				  $(this).remove();
				});
			}, $.choones.settings.display_time);
		}
	});
	
	//
	// == Private methods
	//
	init = function (title, args) {
		display = {title: title};
		$.choones.settings = $.extend($.choones.settings, args);
		
		resetTimeout();
		buildMessage();
		$.choones.display();
	}
	
	resetTimeout = function () {
		if(this.timeout) {
			clearTimeout(this.timeout);
		}
	}
	
	buildMessage = function () {
    $("#choones").append('<div class="'+$.choones.settings.type+'"><h3>'+display.title+'</h3></div>');
	}

})(jQuery);