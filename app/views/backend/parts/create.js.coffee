$("#project-<%= @part.project_id.to_s %>-content .parts_wrapper").html("<%= escape_javascript(render(@part.project.parts)) %>")
initializeClients($("#project-<%= @part.project_id.to_s %>-content .parts_wrapper"))
$(".sliding-field.part").removeClass 'active'
$(".sliding-field.part").val('')
$(".cancel-adding-btn2").removeClass 'active'
$(".sliding-field.project").removeClass 'active'
setTimeout (->
  $('#id_add-project-form .plus').removeClass('my-visible')
), 500

setTimeout (->
  $('#id_add-project-form .text').removeClass('my-invisible')
), 500

$(".add-project-btn").removeClass 'smaller-btn green-bg'
setTimeout (->
  $('.parts-wrapper .plus').removeClass('my-visible')
), 500

setTimeout (->
  $('.parts-wrapper .text').removeClass('my-invisible')
), 500

$(".add-part-btn").removeClass 'smaller-btn'
$(".project-collapse[data-target='#project-<%= @project.id %>-content']").removeClass 'collapsed'
$("#project-<%= @project.id %>-content.collapsible").collapse('show')
