$(".sliding-field.worker").removeClass 'active'
$(".sliding-field.worker").val('')
$(".cancel-adding-btn2").removeClass 'active'
setTimeout (->
  $('#id_add-coworker-form .plus').removeClass('my-visible')
), 500
setTimeout (->
  $('#id_add-coworker-form .text').removeClass('my-invisible')
), 500
$(".add-coworker-btn").removeClass 'green-bg smaller-btn'