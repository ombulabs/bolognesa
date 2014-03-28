// Pomodoro modal
// ***************

$(document).ready(function() {

  var $modal, $modal_close, $modal_container;

  $modal = $('#modal');
  $modal_close = $modal.find('.close');
  $modal_container = $('#modal-container');

  $('.edit_tags').click(function(xhr, data, status) {
    $modal.html(data).prepend($modal_close).css('top', $(window).scrollTop() + 40).show();
    $modal_container.show();
  });

  $(document).on('click', '#modal .close', function() {
    $modal_container.hide();
    $modal.hide();
    return false;
  });

  /* $('input[name=submit]').click(function(){
    $modal_container.hide();
    $modal.hide();
    return false;
  }); */

});
