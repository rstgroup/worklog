$("#project-<%= @part.project_id.to_s %>-content .parts_wrapper").html("<%= escape_javascript(render(@part.project.parts)) %>")
initializeClients($("#project-<%= @part.project_id.to_s %>-content .parts_wrapper"))
$(".sliding-field-part").removeClass 'active'
$(".sliding-field-part").val('')
$(".default-invisible").removeClass 'visible'
$(".default-invisible").addClass 'invisible'
$(".default-visible").removeClass 'invisible'
$(".cancel-adding-btn2").removeClass 'active'
$(".add-part-btn").removeClass 'smaller-btn'
$(".project-collapse[data-target='#project-<%= @project.id %>-content']").removeClass 'collapsed'
$("#project-<%= @project.id %>-content.collapsible").collapse('show')
