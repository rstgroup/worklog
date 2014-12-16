$(".clients_wrapper").html("<%= escape_javascript(render(@clients)) %>")
initializeClients($(".clients_wrapper"))
$(".sliding-field.client").removeClass 'active'
$(".sliding-field.client").val('')
$(".cancel-adding-btn2").removeClass 'active'
setTimeout (->
  $('#id_add-client-form .plus').removeClass('my-visible')
), 500
setTimeout (->
  $('#id_add-client-form .text').removeClass('my-invisible')
), 500

$('.add-client-btn').removeClass 'green-bg smaller-btn'