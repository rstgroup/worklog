$ ->
  currentHeight = $('.top-container').height()
  currentDate = new Date()

  setTopContainerHeight(currentHeight)
  $(window).resize -> setTopContainerHeight(currentHeight)

  $("input").focus ->
    $(this).parent(".input-line").addClass('focused')

  $('input').blur ->
    $(this).parent(".input-line").removeClass('focused')

  $("input").focus ->
    $(this).parent(".details-column").addClass('focused')

  $('input').blur ->
    $(this).parent(".details-column").removeClass('focused')

  $('.to-section').click (e)->
    e.preventDefault()
    $('html, body').stop().animate({'scrollTop': $($(this).attr('href')).offset().top},{duration: 800})
    false


  $(".datepicker").datetimepicker({
    pickTime: false
    format: "DD.MM.YYYY"
  })

  $("#timelog_clock_duration").datetimepicker({
    pickDate: false
    minuteStepping:5
    format: 'HH:mm'
    pick12HourFormat: false
    defaultTime: '00:00'
  })

  $(document).click (e) ->
    btnGroup = $(".dropdown-menu").parents('.btn-group')
    workersbtn = btnGroup.find('*').andSelf().not('.select-workers-btn')
    target = $(e.target)
    if $.inArray(target, workersbtn) < 0 && btnGroup.hasClass('open')
      btnGroup.removeClass('open')



  $("#timelog_clock_duration").on("dp.show", (e)->
    $('.timepicker').parent().addClass('only-timepicker')
  )

  $(".add-client-btn").click (e) ->
    unless $('.sliding-field-client').hasClass('active')
      e.preventDefault()
    $(".sliding-field-client").addClass 'active'
    $(".default-invisible").removeClass 'invisible'
    $(".default-visible").addClass 'invisible'

  $(".add-project-btn").click (e) ->
    unless $('.sliding-field-project').hasClass('active')
      e.preventDefault()
    $(".sliding-field-project").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'

  $(".add-part-btn").click (e) ->
    unless $(this).parent().find('.sliding-field-part').hasClass('active')
      e.preventDefault()
    $(this).parent().find(".sliding-field-part").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'


  $("#timelog_full_part_name").typeahead
    ajax:
      url: '/backend/parts/autocomplete'
      timeout: 500
      displayField: "text"
      triggerLength: 1
      method: "get"
      loadingClass: "loading-circle"


setTopContainerHeight = (currentHeight)->
  if $('.top-container').length > 0
    futureHeight = $(window).height() - $('body > header').height()
    if currentHeight < futureHeight
      $('.top-container').height(futureHeight)
    else
      $('.top-container').height(currentHeight)