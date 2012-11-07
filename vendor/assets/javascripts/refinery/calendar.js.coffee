jQuery ->
  datetimes = $(".datetime_range").datetimepicker
    ampm: true
    dateFormat: 'yy-mm-dd'
    timeFormat: 'hh:mm tt'
    changeMonth: true
    changeYear: true
    numberOfMonths: 2
