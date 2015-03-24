$(document).on('ready page:load nested:fieldAdded', function() {
  var format = 'YYYY-MM-DD';

  $('[type=date]').datetimepicker({
    format: format,
    minDate: moment().format(format),
    maxDate: moment().add(1, 'month').format(format)
  });
});
