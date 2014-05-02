$ ->
  # $("select").ptprSelectTag({allValuesText: 'Wybrano wszystkie', placeholder: 'ggg'})
  # allValuesText: string
  # placeholder: string
  # size: int
  
  #$(document).keyup (e) -> console.log getKey(e.keyCode)
  

$.fn.ptprSelectTag = (opts) ->
  $(this).each ->
    $(this).ptprSelectTagInit(opts)
    $(this).ptprSelectTagSetValues($(this).val(), opts)
    #unless opts.disabled || opts.disabled && $(this).attr('disabled') || opts.disabled!=false && $(this).attr('disabled')
    unless $(this).attr('disabled')
      $(this).ptprSelectTagSetEvents(opts)
  
$.fn.ptprSelectTagInit = (opts) ->
  $.fn.prepareOptions = ->
    option = $(this)
    value = option.val()
    text = option.html()
    check_box = if $(this).parents('select').attr('multiple') then "<div class='check_box'/>" else ""
    newselect += "<li class='option opt_#{value}' data-value='#{value}'>#{check_box}<div class='text'>#{text}</div></li>"
  item = $(this)
  newselect_id = if item.attr('id') then "id=\"ptpr-#{item.attr('id')}\"" else ""
  
  item.hide()
  
  #prepare new select
  disabled = if item.attr('disabled') then "disabled" else ""
  multiple = if item.attr('multiple') then "multiple" else ""
  newselect = "<div #{newselect_id} class='ptpr-select-tag #{multiple} #{disabled}'>"
  newselect += "<div class='main'><div class='values' /><div class='button' /><div class='mist' /></div>"
  newselect += "<div class='drop-down-list'><div class='list_wrapper'><div class='scroll_wrapper'><ul class='options'>"
  if item.find('optgroup').length > 0
    item.find('optgroup').each ->
      label = $(this).attr('label')
      newselect += "<li class='optgroup' data-label='#{label}'><div class='label'>#{label}</div>"
      newselect += "<ul class='inner'>"
      $(this).find('option').each ->
        $(this).prepareOptions()
      newselect += "</ul></li>"
  else
    item.find("option").each () ->
      $(this).prepareOptions()
  newselect += "</ul></div></div></div>"
  newselect += "</div>"
  item.after(newselect).ptprSelectTagSetSize(opts)
  return newselect
  
$.fn.ptprSelectTagSetValues = (values, opts) ->
  item = $(this)
  newselect_id = if item.attr('id') then "#ptpr-#{item.attr('id')}" else false
  if newselect_id && $(newselect_id).length > 0
    $(newselect_id).find('.option').removeClass('selected')
    if values && values.length > 0
      if $.isArray(values)
        if values.length == item.find('option').length
          values_names = if item.data('all-values-text') then item.data('all-values-text') else if opts && opts.allValuesText && opts.allValuesText != '' then opts.allValuesText else "Wszystkie"
          for v in values
            $(newselect_id).find(".opt_#{v}").addClass('selected')
        else
          values_names = if values.length > 1 then "<span class='number_of_values'>[#{values.length}]</span> " else ""
          for v in values
            $(newselect_id).find(".opt_#{v}").addClass('selected')
            vn = $(newselect_id).find(".opt_#{v} .text").html()
            if v==values[values.length-1]
              values_names += vn
            else
              values_names += "#{vn}, "
        $(newselect_id).find('.values').html(values_names)
      else if values != ''
        $(newselect_id).find(".opt_#{values}").addClass('selected')
        $(newselect_id).find('.values').html($(newselect_id).find(".opt_#{values} .text").html())
    else
      values_names = if item.data('placeholder') then "<span class='placeholder'>#{item.data('placeholder')}</span>" else if $(item).find('option:first').attr('value') == '' then "<span class='placeholder'>#{$(item).find('option:first').html()}</span>" else if opts && opts.placeholder && opts.placeholder != '' then "<span class='placeholder'>#{opts.placeholder}</span>" else "<span class='placeholder'>[Wybierz]</span>"
      $(newselect_id).find('.values').html(values_names)
      $(newselect_id).find(".opt_").addClass('selected')
    item.val(values)
    item.trigger 'change'
  else
    console.log "There are more than one select tags with the same ID!"

$.fn.ptprSelectTagSetEvents = (opts) ->
  item = $(this)
  newselect_id = if item.attr('id') then "#ptpr-#{item.attr('id')}" else false
  if newselect_id && $(newselect_id).length > 0
    # Select options
    $(newselect_id).find('.option').click (e) -> 
      $(this).toggleClass('selected')
      if item.attr('multiple')
        values = []
        $(newselect_id).find('.option.selected').each ->
          values.push $(this).data('value')
          true
        item.ptprSelectTagSetValues(values, opts)
      else
        item.ptprSelectTagSetValues($(this).data('value'), opts)
        $(newselect_id).removeClass("active")
    # Click on the main field    
    $(newselect_id).find('.main').click (e) -> 
      $(newselect_id).toggleClass('active')
    # Click out of the select
    $(document).click (e) ->
      objects = $(newselect_id).find("*").andSelf()
      if $.inArray(e.target, objects) < 0 && $(newselect_id).hasClass("active")
        $(newselect_id).removeClass("active")
    # Option hover
    $(newselect_id).find('.option').hover(
      ->
        $(newselect_id).find('.option.hovered').removeClass('hovered') 
        $(this).addClass('hovered')
      -> $(this).removeClass('hovered')
    )
    # Select options with arrows
    $(document).keyup (e) -> 
      if $(newselect_id).hasClass('active')
        
        if item.attr('multiple')
          current = $(newselect_id).find('.option.hovered')
          if current.length == 1
            current_index = current.index()
            optgroup = $(newselect_id).find('.optgroup')
            next = null
            if e.keyCode == 38
              if current_index > 0
                next = current.prev()
              else
                if current.parents('.optgroup').length > 0 && current.parents('.optgroup').index() != 0
                  next = current.parents('.optgroup').prev().find('.option:last')
                else
                  next = $(newselect_id).find('.option:last')
            if e.keyCode == 40
              if current_index < current.parent().find('.option').length-1
                next = current.next()
              else
                if optgroup.length > 0 && current.parents('.optgroup').index() != optgroup.length-1
                  next = current.parents('.optgroup').next().find('.option:first')
                else
                  next = $(newselect_id).find('.option:first')
            if next && next.length == 1
              $(newselect_id).find('.option.hovered').removeClass('hovered')
              next.addClass('hovered')
          else
            if e.keyCode == 38 || e.keyCode == 40
              $(newselect_id).find('.option:first').addClass('hovered')
          if e.keyCode == 32
            if $(newselect_id).find('.option.hovered')
              $(newselect_id).find('.option.hovered').trigger 'click'
        else
          current = $(newselect_id).find('.option.selected')
          if current.length == 1
            current_index = current.index()
            optgroup = $(newselect_id).find('.optgroup')
            next = null
            if e.keyCode == 38
              if current_index > 0
                next = current.prev()
              else
                if current.parents('.optgroup').length > 0 && current.parents('.optgroup').index() != 0
                  next = current.parents('.optgroup').prev().find('.option:last')
                else
                  next = $(newselect_id).find('.option:last')
            if e.keyCode == 40
              if current_index < current.parent().find('.option').length-1
                next = current.next()
              else
                if optgroup.length > 0 && current.parents('.optgroup').index() != optgroup.length-1
                  next = current.parents('.optgroup').next().find('.option:first')
                else
                  next = $(newselect_id).find('.option:first')
            if next && next.length == 1
              item.ptprSelectTagSetValues(next.data('value'))
              $(newselect_id).find('.scroll_wrapper').stop().animate({scrollTop: parseInt(next.position().top)})
            if e.keyCode == 13
              $(newselect_id).removeClass('active')
  else
    console.log "There are more than one select tags with the same ID!"

$.fn.ptprSelectTagSetSize = (opts) ->
  item = $(this)
  newselect_id = if item.attr('id') then "#ptpr-#{item.attr('id')}" else false
  if newselect_id && $(newselect_id).length > 0
    size = if opts && opts.size && opts.size != '' then parseInt(opts.size) else if item.attr('size') then parseInt(item.attr('size')) else false
    if size && size < item.find('option').length
      scroll_wrapper = $(newselect_id).find('.drop-down-list .scroll_wrapper')
      $(newselect_id).addClass('active').find('.drop-down-list').css({opacity: 0})
      options_height = 0
      for i in [0..size-1]
        options_height += $($(newselect_id).find('.options .option, .options .label')[i]).outerHeight()
      $(newselect_id).removeClass('active').addClass('size').find('.drop-down-list').css({opacity: 1})
      scroll_wrapper.height(options_height)
        
      
window.getKey = (key_code) ->
  switch key_code
    when 8 then return "backspace"
 	  when 9 then return "tab"
 	  when 13 then return "enter"
 	  when 16 then return "shift"
 	  when 17 then return "ctrl"
 	  when 18 then return "alt"
 	  when 19 then return "pause/break"
    when 20 then return "caps lock"
    when 27 then return "escape"
    when 33 then return "page up"
    when 34 then return "page down"
    when 35 then return "end"
    when 36 then return "home"
    when 37 then return "left arrow"
    when 38 then return "up arrow"
    when 39 then return "right arrow"
    when 40 then return "down arrow"
    when 45 then return "insert"
    when 46 then return "delete"
    when 48 then return "0"
    when 49 then return "1"
    when 50 then return "2"
    when 51 then return "3"
    when 52 then return "4"
    when 53 then return "5"
    when 54 then return "6"
    when 55 then return "7"
    when 56 then return "8"
    when 57 then return "9"
    when 65 then return "a"
    when 66 then return "b"
    when 67 then return "c"
    when 68 then return "d"
    when 69 then return "e"
    when 70 then return "f"
    when 71 then return "g"
    when 72 then return "h"
    when 73 then return "i"
    when 74 then return "j"
    when 75 then return "k"
    when 76 then return "l"
    when 77 then return "m"
    when 78 then return "n"
    when 79 then return "o"
    when 80 then return "p"
    when 81 then return "q"
    when 82 then return "r"
    when 83 then return "s"
    when 84 then return "t"
    when 85 then return "u"
    when 86 then return "v"
    when 87 then return "w"
    when 88 then return "x"
    when 89 then return "y"
    when 90 then return "z"
    when 91 then return "left window key"
    when 92 then return "right window key"
    when 93 then return "select key"
    when 96  then return "numpad 0"
    when 97  then return "numpad 1"
    when 98  then return "numpad 2"
    when 99  then return "numpad 3"
    when 100 then return "numpad 4"
    when 101 then return "numpad 5"
    when 102 then return "numpad 6"
    when 103 then return "numpad 7"
    when 104 then return "numpad 8"
    when 105 then return "numpad 9"
    when 106 then return "multiply"
    when 107 then return "add"
    when 109 then return "subtract"
    when 110 then return "decimal point"
    when 111 then return "divide"
    when 112 then return "f1"
    when 113 then return "f2"
    when 114 then return "f3"
    when 115 then return "f4"
    when 116 then return "f5"
    when 117 then return "f6"
    when 118 then return "f7"
    when 119 then return "f8"
    when 120 then return "f9"
    when 121 then return "f10"
    when 122 then return "f11"
    when 123 then return "f12"
    when 144 then return "num lock"
    when 145 then return "scroll lock"
    when 186 then return "semi-colon"
    when 187 then return "equal sign"
    when 188 then return "comma"
    when 189 then return "dash"
    when 190 then return "period"
    when 191 then return "forward slash"
    when 192 then return "grave accent"
    when 219 then return "open bracket"
    when 220 then return "back slash"
    when 221 then return "close braket"
    when 222 then return "single quote"  