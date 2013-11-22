# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  
  engines = $('#carprofile_engine_id').html()
  $('#carprofile_car_model_id').change ->
    car_model = $('#carprofile_car_model_id :selected').text()
    escaped_car_model = car_model.replace(/([ #;&,.+*~\':"!^$[\][ ][()=>|\/@])/g, '\\$1')
    options = $(engines).filter("optgroup[label='#{escaped_car_model}']").html()
    if options
      $('#carprofile_engine_id').html(options)
      $('#carprofile_engine_id').parent().show()
    else
      $('#carprofile_engine_id').empty()
      $('#carprofile_engine_id').parent().hide()
