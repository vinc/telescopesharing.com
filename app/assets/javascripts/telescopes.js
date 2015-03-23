$(document).on('ready page:load nested:fieldAdded', function() {
  $('[type=date]').datepicker({
    format: 'yyyy-mm-dd'
  });
});
