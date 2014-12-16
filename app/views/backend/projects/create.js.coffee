$(".projects_wrapper").html("<%= escape_javascript(render(@client.projects)) %>")
initializeClients($(".projects_wrapper"))
$(".sliding-field.project").removeClass 'active'
$(".sliding-field.project").val ('')
$(".cancel-adding-btn2").removeClass 'active'
setTimeout (->
  $('#id_add-project-form .plus').removeClass('my-visible')
), 500
setTimeout (->
  $('#id_add-project-form .text').removeClass('my-invisible')
), 500
$('.add-project-btn').removeClass 'green-bg smaller-btn'

