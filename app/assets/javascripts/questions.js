// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('#ex1').slider({
	formatter: function(value) {
		return 'Current value: ' + value;
	}
});
