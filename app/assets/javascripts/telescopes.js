$(document).on('ready page:load nested:fieldAdded', function() {
  var format = 'YYYY-MM-DD';

  $('.telescope_observations_scheduled_on .input-group').datetimepicker({
    format: format,
    minDate: moment().format(format),
    maxDate: moment().add(1, 'month').format(format)
  });
});
