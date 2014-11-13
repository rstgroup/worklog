$ ->
  # $('#timelog_full_part_name').autocomplete
  #   source: '/backend/parts/autocomplete'
  # $('select#timelog_full_part_name').select2()
  #   source: '/backend/parts/autocomplete'

  # $('#timelog_worked_on').datepicker
  #   dateFormat: 'dd.mm.yy'
  $('.dropdown-toggle').dropdown()
  # $('#timelog_clock_duration').timepicker
  #   showMeridian: false
  #   defaultTime: '00:00 AM'
  #   disableFocus: true


  # fix for forms in dropdowns
  $('.dropdown input, .dropdown label').on("click", (e) -> e.stopPropagation())


