$("#edit-client-<%= @client.id.to_s %>-btn").liveEdit("destroy", value: "<%= @client.name %>")
