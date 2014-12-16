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
    unless $('.sliding-field.client').hasClass('active')
      e.preventDefault()
    $(".sliding-field.client").addClass 'active'
    $(".plus").addClass 'my-visible'
    $(".text").addClass 'my-invisible'
    $('.add-client-btn').addClass 'green-bg smaller-btn'
    $('.cancel-adding-btn2').addClass 'active'
    $('.cancel-adding-btn2').text 'Anuluj'

  $('body').on 'click', '.add-part-btn', (e) ->
    unless $(this).parent().find('.sliding-field.part').hasClass('active')
      e.preventDefault()
    $('.parts-wrapper #part_name').removeClass('create-fail')
    $('.parts-wrapper #part_name').attr 'placeholder', 'Nazwa zadania'
    $(this).parent().find(".sliding-field.part").addClass 'active'
    $(this).parent().find(".plus").addClass 'my-visible'
    $(this).parent().find(".text").addClass 'my-invisible'
    $(this).parent().find(".add-part-btn").addClass 'smaller-btn'
    $(this).siblings('.cancel-adding-btn2').addClass 'active'
    $(this).parent().find('.cancel-adding-btn2').text 'Anuluj'

  $('body').on 'click', '.add-project-btn', (e) ->
    unless $('.sliding-field.project').hasClass('active')
      e.preventDefault()
    $(".sliding-field.project").addClass 'active'
    $(this).parent().find(".plus").addClass 'my-visible'
    $(this).parent().find(".text").addClass 'my-invisible'
    $(".add-project-btn").addClass 'green-bg smaller-btn'
    $(this).parent('.add-project-row').find('.cancel-adding-btn2').addClass 'active'
    $(this).parent('.add-project-row').find('.cancel-adding-btn2').text 'Anuluj'

  $('body').on 'click', '.add-coworker-btn', (e) ->
    unless $('.sliding-field.worker').hasClass('active')
      e.preventDefault()
    $(".sliding-field.worker").addClass 'active'
    $(this).parent().find(".plus").addClass 'my-visible'
    $(this).parent().find(".text").addClass 'my-invisible'
    $(".add-coworker-btn").addClass 'green-bg smaller-btn'
    $(this).parent('.add-worker-row').find('.cancel-adding-btn2').addClass 'active'
    $(this).parent('.add-worker-row').find('.cancel-adding-btn2').text 'Anuluj'


# Workers dropdown
  $(document).click (e) ->
    btnGroup = $(".dropdown-menu").parents('.btn-group')
    workersBtn = btnGroup.find('*').andSelf().not('.select-workers-btn')
    target = $(e.target)
    if $.inArray(target, workersBtn) < 0 && btnGroup.hasClass('open')
      btnGroup.removeClass('open')

# Hiding 'add project field', when clicking on 'cancel' btn
  $(document).on 'click', 'body', (e) ->
    $addProjectBtnInv = $('#id_add-project-form .plus')
    $addProjectBtnVis = $('#id_add-project-form .text')
    $projectNameInput = $('#id_add-project-form #project_name')
    if $(e.target).is('.cancel-adding-btn2.project-cancel')
      if $projectNameInput.hasClass('active')
        $projectNameInput.removeClass('active')
        $('.add-project-btn').removeClass('green-bg')
        $('.sliding-field.project').val ''
        if $('.sliding-field.project').hasClass('create-fail')
          $('.sliding-field.project').removeClass('create-fail')
        $('.sliding-field.project').attr 'placeholder', 'Nazwa projektu'
        $('.cancel-adding-btn2.project-cancel').removeClass 'active'
        $('.add-project-btn').removeClass 'smaller-btn'
        setTimeout (->
          $addProjectBtnInv.removeClass('my-visible')
        ), 500
        setTimeout (->
          $addProjectBtnVis.removeClass('my-invisible')
        ), 500

# Hiding 'add parts field', when clicking on 'cancel' btn
  $(document).on 'click', 'body', (e) ->
    if $(e.target).is('.cancel-adding-btn2.part-cancel')
      $currentCancel = $(e.target).parents('.parts-wrapper').find('.cancel-adding-btn2')
      $addPartBtnVis = $(e.target).parents('.parts-wrapper').find('.text')
      $partNameInput = $(e.target).parents('.parts-wrapper').find('#part_name')
      $addPartBtnInv = $(e.target).parents('.parts-wrapper').find('.plus')
      $addPartBtnMain =$(e.target).parents('.parts-wrapper').find('.add-part-btn')

      if $partNameInput.hasClass('active')
        $partNameInput.removeClass('active')
        $partNameInput.removeClass('active')
        $partNameInput.val ''
        if $partNameInput.hasClass('create-fail')
          $partNameInput.removeClass('create-fail')
        $partNameInput.attr 'placeholder', 'Nazwa zadania'
        $currentCancel.removeClass 'active'
        $addPartBtnMain.removeClass 'smaller-btn'

        setTimeout (->
          $addPartBtnInv.removeClass('my-visible')
        ), 500
        setTimeout (->
          $addPartBtnVis.removeClass('my-invisible')
        ), 500




# Hiding 'add clients field', when clicking on 'cancel' btn
  $(document).click (e) ->
    $addClientBtnInv = $('#id_add-client-form .plus')
    $addClientBtnVis = $('#id_add-client-form .text')
    $clientNameInput = $('#id_add-client-form #client_name')
    if $(e.target).is('.cancel-adding-btn2')
      if $clientNameInput.hasClass('active')
        $clientNameInput.removeClass('active')
        $('.add-client-btn').removeClass('green-bg')
        $('.sliding-field.client').val ''
        if $('.sliding-field.client').hasClass('create-fail')
          $('.sliding-field.client').removeClass('create-fail')
        $('.sliding-field.client').attr 'placeholder', 'Wpisz nazwę'
        $('.cancel-adding-btn2').removeClass 'active'
        $('.add-client-btn').removeClass 'smaller-btn'

        setTimeout (->
          $addClientBtnInv.removeClass('my-visible')
        ), 500
        setTimeout (->
          $addClientBtnVis.removeClass('my-invisible')
        ), 500

# Hiding 'add workers field', when clicking on 'cancel' btn
  $(document).click (e) ->
    $addWorkerBtnInv = $('#id_add-coworker-form .plus')
    $addWorkerBtnVis = $('#id_add-coworker-form .text')
    $slidingFieldWorker = $('#id_add-coworker-form .sliding-field.worker')
    if $(e.target).is('.cancel-adding-btn2')
      if $slidingFieldWorker.hasClass('active')
        $slidingFieldWorker.removeClass('active')
        $('.add-coworker-btn').removeClass('green-bg')
        $('.sliding-field.worker').val ''
        if $('.sliding-field.worker').hasClass('create-fail')
          $('.sliding-field.worker').removeClass('create-fail')
        $('.sliding-field.worker').first().attr 'placeholder', 'Imię i nazwisko'
        $('.sliding-field.worker').last().attr 'placeholder', 'Email'
        $('.cancel-adding-btn2').removeClass 'active'
        $('.add-coworker-btn').removeClass 'smaller-btn'
        setTimeout (->
          $addWorkerBtnInv.removeClass('my-visible')
        ), 500
        setTimeout (->
          $addWorkerBtnVis.removeClass('my-invisible')
        ), 500

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

# Adding error class to input-line , if there are any errors
  $(".clearfix.error").parents('.input-line').addClass('error')
  $(".clearfix.error").parents('.col-md-6').addClass('error')

  # $forgotPw = $("#new_user .clearfix.error")
  # console.log $forgotPw
  # $forgotPw.parent('.input-line').addClass('error')


# Disabling aria-dropdown when editing name
  $('body').on 'click', '.edit-btn', (e)->
    $(this).parents('.project-row').find('.project-collapse').removeAttr('data-toggle')
    $aCancel = $(this).parents('.project-row').find('.project-collapse').find('a.cancel')
    console.log $aCancel
    $btnActionBtn = $(this).parents('.project-row').find('.project-collapse').find('control-group').find('.action-btn')
    console.log $btnActionBtn
    $('.project-name').on 'click', '.form-inline', (e) ->
      $('.form-inline').on 'click', 'a.cancel', ->
        console.log 'teraz jestem tu'
        $(this).parents('.project-collapse').attr('data-toggle', 'collapse')
      $('.form-inline').on 'click', 'btn.action-btn', ->
        console.log 'a tera jestem tu '
        $(this).parents('.project-collapse').attr('data-toggle', 'collapse')





setTopContainerHeight = (currentHeight)->
  if $('.top-container').length > 0
    futureHeight = $(window).height() - $('body > header').height()
    if currentHeight < futureHeight
      $('.top-container').height(futureHeight)
    else
      $('.top-container').height(currentHeight)