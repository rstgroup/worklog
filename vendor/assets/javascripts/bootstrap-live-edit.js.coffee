$ ->

  form = """
    <form accept-charset="UTF-8" action="#" class="form-inline" method="put">
      <div class="control-group">
        <input class="form_name" name="client[name]" type="text">
        <button class="btn action_btn" type="submit"><i class="icon-edit"></i><span class="action_text">Zmień</span></button>
        <a class="cancel" href="#">Anuluj</a>
      </div>
    </form>
    """
  oldUrl = ''

  preventClickDuringEditing = (e) ->
    e.preventDefault()

  methods = {
    init: (options) ->
      this.each () ->
        element = $(this)
        element.click () ->
          wrapper = $("#"+$(this).attr("data-live-edit"))
          oldUrl = wrapper.attr('href')
          wrapper.attr 'href', null
          url = $(this).attr("data-live-edit-url")
          wrapper.data("during-editing", true)
          wrapper.data("live-edit-old-name", $.trim(wrapper.text()))
          wrapper.data("during-editing", true)
          wrapper.html(form)
          wrapper.find("form").attr("action", url)
          wrapper.find("form").submit () ->
            $.ajax(
              url: url,
              type: "PUT",
              data: {name: wrapper.find("input.form_name").val()},
              statusCode:
                406: () -> wrapper.find(".control-group").addClass("error")
            )
            false
          wrapper.find(".form_name").val(wrapper.data("live-edit-old-name"))
          wrapper.find("a.cancel").click () ->
            element.liveEdit("destroy")
            false
          wrapper.find("input.form_name").focus()
          true
    destroy: (options) ->
      this.each () ->
        wrapper = $("#"+$(this).attr("data-live-edit"))
        wrapper.attr 'href', oldUrl
        wrapper.find("*").remove()
        wrapper.text(if options?["value"] then options["value"] else wrapper.data("live-edit-old-name"))
        wrapper.data("during-editing", null)
  }

  $.fn.liveEdit = (method) ->
    if (methods[method])
      return methods[method].apply(this, Array.prototype.slice.call( arguments, 1 ))
    else if( typeof method == 'object' || !method)
      return methods.init.apply( this, arguments )
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.liveEdit' )
