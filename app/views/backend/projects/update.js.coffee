$("#edit-project-<%= @project.id.to_s %>-btn").liveEdit("destroy", value: "<%= @project.name %>")
