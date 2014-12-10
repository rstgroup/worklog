$("#project-<%= @project.id %>").find(".sliding-field.part")
  .addClass('create-fail')
  .attr 'placeholder', 'Nie może być puste'