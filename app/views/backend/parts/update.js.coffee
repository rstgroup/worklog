$("#edit-part-<%= @part.id.to_s %>-btn").liveEdit("destroy", value: "<%= @part.name %>")
