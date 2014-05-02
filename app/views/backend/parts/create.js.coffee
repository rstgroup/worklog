$("#project-<%= @part.project_id.to_s %>-content .parts_wrapper").html("<%= escape_javascript(render(@part.project.parts)) %>")
initializeClients($("#project-<%= @part.project_id.to_s %>-content .parts_wrapper"))
