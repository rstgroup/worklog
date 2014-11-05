$ ->
  currentHeight = $('.top-container').height()

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


  $(".datetimepicker1").datetimepicker({pickTime: false})
  $(".datetimepicker4").datetimepicker({
    pickDate: false
    minuteStepping:5
    format: 'HH:mm'
    pick12HourFormat: false
    defaultTime: '00:00'
  })

  $(".add-client-btn").click (e) ->
    unless $('.sliding-field-client').hasClass('active')
      e.preventDefault()
    $(".sliding-field-client").addClass 'active'

  $(".add-project-btn").click (e) ->
    unless $('.sliding-field-project').hasClass('active')
      e.preventDefault()
    $(".sliding-field-project").addClass 'active'

  $(".add-part-btn").click (e) ->
    unless $(this).parent().find('.sliding-field-part').hasClass('active')
      e.preventDefault()
    $(this).parent().find(".sliding-field-part").addClass 'active'






setTopContainerHeight = (currentHeight)->
  if $('.top-container').length > 0
    futureHeight = $(window).height() - $('body > header').height()
    if currentHeight < futureHeight
      $('.top-container').height(futureHeight)
    else
      $('.top-container').height(currentHeight)