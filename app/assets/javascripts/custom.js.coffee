$ ->
  $("input").focus ->
    $(this).parent(".input-line").addClass('focused')

  $('input').blur ->
    $(this).parent(".input-line").removeClass('focused')

  $("input").focus ->
    $(this).parent(".details-column").addClass('focused')

  $('input').blur ->
    $(this).parent(".details-column").removeClass('focused')