# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  
  car_models = $('#carprofile_car_model_id').html()
  $('#carprofile_car_make_id').change ->
    car_make = $('#carprofile_car_make_id :selected').text()
    escaped_car_make = car_make.replace(/([ #;&,.+*~\':"!^$[\][ ][()=>|\/@])/g, '\\$1')
    options = $(car_models).filter("optgroup[label='#{escaped_car_make}']").html()
    if options
      $('#carprofile_car_model_id').html(options)
      $('#carprofile_car_model_id').parent().show()
    else
      $('#carprofile_car_model_id').empty()
      $('#carprofile_car_model_id').parent().hide()


      
