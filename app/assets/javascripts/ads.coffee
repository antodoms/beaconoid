# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#

$(document).on "turbolinks:load", ->
	$('#adCategory').text $('#category').find(":selected").text();
	$('#category').change ->
		$('#adCategory').text $(this).find(":selected").text();
		return
	$('#adDescription').text $('#description').val()
	$('#description').change ->
		$('#adDescription').text $(this).val()
		return
	$('#description').keyup ->
		$('#adDescription').text $(this).val()
		return
	$('#adPrice').text '$'+$('#price').val()
	$('#price').change ->
		$('#adPrice').text '$'+$(this).val()
		return
	$('#price').keyup ->
		$('#adPrice').text '$'+$(this).val()
		return