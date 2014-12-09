$(".sliding-field-part.active").addClass 'create-fail'
$("#project-<%= @project.id %>-content .sliding-field-part.active").attr 'placeholder', 'Nie może być puste'