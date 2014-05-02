$ ->
  $.fn.toggleForm = () ->
    this.each () ->
      element = $(this)
      form = element.next()
      element.click () ->
        form.show().find("input:visible").focus()
        element.hide()
        false
      form.hide().find("a.cancel").click () ->
        element.next().hide()
        element.show()
        false
      form.submit () ->
        $.ajax(
              url: form.find("form").attr("action"),
              type: "POST"
              data: form.find("form").serializeObject(),
              statusCode:
                406: () -> form.find(".control-group").addClass("error")
                200: () ->
                  form.find("input:visible").val("")
                  form.hide()
                  element.show()
            )
        false
  $.fn.toggleClient = () ->
    this.each () ->
      element = $(this)
      content = element.parents(".fluid-container").find(".client-content")
      element.click () ->
        content.toggle()
        element.find("span").toggleClass("icon-chevron-down").toggleClass("icon-chevron-up")
        $.cookie("toggled_#{content.attr('id')}", if content.is(":visible") then "visible" else "hidden")
        false
      if $.cookie("toggled_#{content.attr('id')}") !="visible"
        content.hide()
      else
        element.find("span").toggleClass("icon-chevron-down").toggleClass("icon-chevron-up")

  $.fn.liveEdit = () ->
    this.each () ->
      element = $(this)
      element.click () ->
        form_original = $("#new_client_form").parent(".form_wrapper")
        wrapper = $("#"+$(this).attr("data-live-edit"))
        url = $(this).attr("data-live-edit-url")
        name = $.trim(wrapper.text())
        wrapper.data("during-editing", true)
        wrapper.html(form_original.html())
        wrapper.find("form").attr("action", url)
        wrapper.find("form").submit () ->
          $.ajax(url: url, type: "PUT", data: {name: wrapper.find("input.client_name").val()})
          false

        wrapper.find(".client_name").val(name)
        wrapper.find(".action_text").text("Zmień")
        wrapper.find(".action_btn .icon-plus").attr("class", "icon-edit")
        wrapper.find("a.cancel").click () ->
          wrapper.find("*").remove()
          wrapper.text(name)
          wrapper.data("during-editing", null)
          false
        true
