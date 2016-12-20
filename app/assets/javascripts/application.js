// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
	$('input.lazy-search').on('keydown',function(e) {
 		var query = $(this).val();
 		var results = ""
		if (query.length > 0) {
			var data = $(this).data('queries')
			results = $(data)
				.map(function(i,v){ 
				    if(v.toLowerCase().indexOf(query.toLowerCase())!=-1){return v} 
				}).get()
			$(this).parents('.form-group').find('.hints').html(results.join(', ')).show()
		} else {
			$(this).parents('.form-group').find('.hints').html("")
			$(this).parents('.form-group').find('.hints').hide()
		}
		if (e.keyCode == 192) {
			e.preventDefault();
			$(this).val( results[0] ).blur()
			return false;
		}
	}).on('blur', function() {
		$(this).parents('.form-group').find('.hints').html("")
		$(this).parents('.form-group').find('.hints').hide()
	})
})