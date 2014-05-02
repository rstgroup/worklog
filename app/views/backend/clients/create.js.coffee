$(".clients_wrapper").html("<%= escape_javascript(render(@clients)) %>")
initializeClients($(".clients_wrapper"))
