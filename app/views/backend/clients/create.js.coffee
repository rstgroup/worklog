$(".clients_wrapper").html("<%= escape_javascript(render(@clients)) %>")
initializeClients($(".clients_wrapper"))
$(".sliding-field-client").removeClass 'active'
$(".sliding-field-client").val('')
