$ ->
  initializeClients($("body"))
  initializeChart()




window.initializeClients = (wrapper) ->
  $(wrapper).find(".form-toggle").toggleForm()
  $(wrapper).find('.client-well h3 .client-name').click () ->
    if !$(this).data("during-editing")
      window.location = $(this).data("href")
      false
    else
      true
  $(wrapper).find("a[data-live-edit]").liveEdit()

window.initializeChart = () ->
  data = []
  sum = 0
  $(".users_wrapper_above_chart .user_element").each (e) ->
    sum += parseInt($.trim($(this).find("label.badge").text()))
  $(".users_wrapper_above_chart .user_element").each (e) ->
    v = parseInt(parseInt($.trim($(this).find("label.badge").text()))*100/sum)
    l = $.trim($(this).find("span.user_name").text())
    data.push {label: l, value: v}

  if $(".users_wrapper_above_chart .user_element").length > 0
    new Morris.Donut(
      element: 'users_division_chart',
      data: data,
      formatter: (y, data) -> "#{y} %"
    )
