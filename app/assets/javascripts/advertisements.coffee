$(document).on "turbolinks:load", ->
  $('#advertisement_search_filter').autocomplete source: $('#advertisement_search_filter').data('autocomplete-source')

