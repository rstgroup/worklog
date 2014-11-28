$ ->
  currentHeight = $('.top-container').height()
  currentDate = new Date()

  setTopContainerHeight(currentHeight)
  $(window).resize -> setTopContainerHeight(currentHeight)

# Adding focus on input-field, when clicking on its wrapper
  $('.input-line').click ->
    $(this).find('.my-input').focus()


# Adding/removing class 'focused' on focused '.input-line'
  $('.input-line').on 'focus', 'input', ->
    $(this).parents(".input-line").addClass('focused')
  $('.input-line').on 'blur', 'input', ->
    $(this).parents(".input-line").removeClass('focused')

  $('#cockpit .col-md-6').on 'focus', 'input', ->
    $(this).parents('.col-md-6').addClass('focused')
  $('#cockpit .col-md-6').on 'blur', 'input', ->
    $(this).parents('.col-md-6').removeClass('focused')



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

  $('body').on 'click', '.add-part-btn', (e) ->
    unless $(this).parent().find('.sliding-field-part').hasClass('active')
      e.preventDefault()
    $('.parts-wrapper #part_name').removeClass('create-fail')
    $('.parts-wrapper #part_name').attr 'placeholder', 'Nazwa zadania'
    $(".add-part-btn").parent().find(".sliding-field-part").removeClass('active')
    $(".add-part-btn").parent().find(".default-visible").removeClass('invisible')
    $(".add-part-btn").parent().find(".default-invisible").addClass('invisible')
    $(this).parent().find(".sliding-field-part").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'

  $('body').on 'click', '.add-project-btn', (e) ->
    unless $('.sliding-field-project').hasClass('active')
      e.preventDefault()
    $(".sliding-field-project").addClass 'active'
    $(this).parent().find(".default-invisible").removeClass 'invisible'
    $(this).parent().find(".default-visible").addClass 'invisible'
    $('.add-project-btn').addClass('green-bg')


# Workers dropdown
  $(document).click (e) ->
    btnGroup = $(".dropdown-menu").parents('.btn-group')
    workersBtn = btnGroup.find('*').andSelf().not('.select-workers-btn')
    target = $(e.target)
    if $.inArray(target, workersBtn) < 0 && btnGroup.hasClass('open')
      btnGroup.removeClass('open')

# Hiding 'add project field', when clicking outside of it
  $(document).on 'click', 'body', (e) ->
    $addProjectBtnInv = $('#id_add-project-form .default-invisible')
    $addProjectBtnVis = $('#id_add-project-form .default-visible')
    $projectNameInput = $('#id_add-project-form #project_name')
    if $(e.target).parents('#id_add-project-form').length is 0
      if $projectNameInput.hasClass('active')
        $projectNameInput.removeClass('active')
        $addProjectBtnInv.addClass('invisible')
        $addProjectBtnVis.removeClass('invisible')
        $('.add-project-btn').removeClass('green-bg')
        $('.sliding-field-project').val ''
        if $('.sliding-field-project').hasClass('create-fail')
          $('.sliding-field-project').removeClass('create-fail')
        $('.sliding-field-project').attr 'placeholder', 'Nazwa projektu'

# Hiding 'add parts field', when clicking outside of it
  $(document).on 'click', 'body', (e) ->
    $addPartBtnInv = $('.parts-wrapper .default-invisible')
    $addPartBtnVis = $('.parts-wrapper .default-visible')
    $partNameInput = $('.parts-wrapper #part_name')
    if $(e.target).parents('.parts-wrapper').length is 0
      # debugger
      if $partNameInput.hasClass('active')
        $partNameInput.removeClass('active')
        $addPartBtnInv.addClass('invisible')
        $addPartBtnVis.removeClass('invisible')
        $('.sliding-field-part').val ''
        if $('.sliding-field-part').hasClass('create-fail')
          $('.sliding-field-part').removeClass('create-fail')
        $('.sliding-field-part').attr 'placeholder', 'Nazwa zadania'

# Hiding 'add clients field', when clicking outside of it
  $(document).click (e) ->
    $addClientBtnInv = $('#id_add-client-form .default-invisible')
    $addClientBtnVis = $('#id_add-client-form .default-visible')
    $clientNameInput = $('#id_add-client-form #client_name')
    if $(e.target).parents('#id_add-client-form').length is 0
      if $clientNameInput.hasClass('active')
        $clientNameInput.removeClass('active')
        $addClientBtnInv.addClass('invisible')
        $addClientBtnVis.removeClass('invisible')
        $('.add-client-btn').removeClass('green-bg')
        $('.sliding-field-client').val ''
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


# Adding error message class if error-message.any?
  $logInDevise = $("#id_devise-log-in .error-messages")
  unless ($logInDevise).is(':empty')
    $logInDevise.parents('.input-lines').addClass('error')

# Adding error class to input-line in cockpit form, if there are any errors , #cockpit, .input-line
  $(".clearfix.error").parents('.input-line').addClass('error')
  $(".clearfix.error").parents('.col-md-6').addClass('error')

  # $forgotPw = $("#new_user .clearfix.error")
  # console.log $forgotPw
  # $forgotPw.parent('.input-line').addClass('error')




setTopContainerHeight = (currentHeight)->
  if $('.top-container').length > 0
    futureHeight = $(window).height() - $('body > header').height()
    if currentHeight < futureHeight
      $('.top-container').height(futureHeight)
    else
      $('.top-container').height(currentHeight)