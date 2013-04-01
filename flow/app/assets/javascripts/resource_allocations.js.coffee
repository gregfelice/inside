# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# plan -> milestone -> resource allocation -> person name autocomplete
jQuery ->
  $(".resource_allocation_resource_name").live 'focus', ->
    $('.resource_allocation_resource_name').autocomplete
      source: $('.resource_allocation_resource_name').data('autocomplete-source')
