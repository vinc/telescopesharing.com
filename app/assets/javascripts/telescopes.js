$(document).on('ready page:load nested:fieldAdded', function() {
  $('[type=date]').datepicker({
    format: 'yyyy-mm-dd',
    startDate: moment().format('YYYY-MM-DD'),
    endDate: moment().add(1, 'month').format('YYYY-MM-DD')
  });
});
