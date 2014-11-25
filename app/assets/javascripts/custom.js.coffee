$ ->
  currentHeight = $('.top-container').height()
  currentDate = new Date()

  setTopContainerHeight(currentHeight)
  $(window).resize -> setTopContainerHeight(currentHeight)

  $('.input-line').on 'focus', 'input', ->
    $(this).parent(".input-line").addClass('focused')

  $('.input-line').on 'focus', 'input', ->
    $(this).parent(".clearfix").parent(".input-line").parent(".controls").addClass('focused')

  $('input').blur ->
    $(this).parent(".clearfix").parent(".input-line").parent(".controls").removeClass('focused')

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


  $("#timelog_clock_duration").on("dp.show", (e)->
    $('.timepicker').parent().addClass('only-timepicker')
  )

  $(".add-client-btn").click (e) ->
    unless $('.sliding-field-client').hasClass('active')
      e.preventDefault()
    $(".sliding-field-client").addClass 'active'
    $(".default-invisible").removeClass 'invisible'
    $(".default-visible").addClass 'invisible'
    $('.add-client-btn').addClass 'green-bg'

  $(".add-project-btn").click (e) ->
    unless $('.sliding-field-project').hasClass('active')
      e.preventDefault()
    $(".sliding-field-project").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'
    $('.add-project-btn').addClass('green-bg')

  $(".add-part-btn").click (e) ->
    unless $(this).parent().find('.sliding-field-part').hasClass('active')
      e.preventDefault()
    $(".add-part-btn").parent().find(".sliding-field-part").removeClass('active')
    $(".add-part-btn").parent().find(".default-visible").removeClass('invisible')
    $(".add-part-btn").parent().find(".default-invisible").addClass('invisible')

    $(this).parent().find(".sliding-field-part").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'


  # Workers dropdown
  $(document).click (e) ->
    btnGroup = $(".dropdown-menu").parents('.btn-group')
    workersBtn = btnGroup.find('*').andSelf().not('.select-workers-btn')
    target = $(e.target)
    if $.inArray(target, workersBtn) < 0 && btnGroup.hasClass('open')
      btnGroup.removeClass('open')

  # Hiding 'add project field', when clicking outside of it
  $addProjectBtnInv = $('#id_add-project-form .default-invisible')
  $addProjectBtnVis = $('#id_add-project-form .default-visible')
  $projectNameInput = $('#id_add-project-form #project_name')
  $(document).click (e) ->
    if $(e.target).parents('#id_add-project-form').length is 0
      if $projectNameInput.hasClass('active')
        $projectNameInput.removeClass('active')
        $addProjectBtnInv.addClass('invisible')
        $addProjectBtnVis.removeClass('invisible')
        $('.add-project-btn').removeClass('green-bg')
        if $('.sliding-field-project').hasClass('create-fail')
          $('.sliding-field-project').removeClass('create-fail')
        $('.sliding-field-project').attr 'placeholder', 'Nazwa projektu'

  # Hiding 'add parts field', when clicking outside of it
  $addPartBtnInv = $('.parts-wrapper .default-invisible')
  $addPartBtnVis = $('.parts-wrapper .default-visible')
  $partNameInput = $('.parts-wrapper #part_name')
  $(document).click (e) ->
    if $(e.target).parents('.parts-wrapper').length is 0
      if $partNameInput.hasClass('active')
        $partNameInput.removeClass('active')
        $addPartBtnInv.addClass('invisible')
        $addPartBtnVis.removeClass('invisible')
        if $('.sliding-field-part').hasClass('create-fail')
          $('.sliding-field-part').removeClass('create-fail')
        $('.sliding-field-part').attr 'placeholder', 'Nazwa zadania'

  # Hiding 'add clients field', when clicking outside of it
  $addClientBtnInv = $('#id_add-client-form .default-invisible')
  $addClientBtnVis = $('#id_add-client-form .default-visible')
  $clientNameInput = $('#id_add-client-form #client_name')
  $(document).click (e) ->
    if $(e.target).parents('#id_add-client-form').length is 0
      if $clientNameInput.hasClass('active')
        $clientNameInput.removeClass('active')
        $addClientBtnInv.addClass('invisible')
        $addClientBtnVis.removeClass('invisible')
        $('.add-client-btn').removeClass('green-bg')
        if $('.sliding-field-client').hasClass('create-fail')
          $('.sliding-field-client').removeClass('create-fail')
        $('.sliding-field-client').attr 'placeholder', 'Wpisz nazwę'


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