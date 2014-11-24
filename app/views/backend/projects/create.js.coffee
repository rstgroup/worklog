$(".projects_wrapper").html("<%= escape_javascript(render(@client.projects)) %>")
initializeClients($(".projects_wrapper"))
$(".sliding-field-project").removeClass 'active'
$(".sliding-field-project").val ('')
$(".default-invisible").removeClass 'visible'
$(".default-invisible").addClass 'invisible'
$(".default-visible").removeClass 'invisible'
$('.add-project-btn').removeClass('green-bg')

