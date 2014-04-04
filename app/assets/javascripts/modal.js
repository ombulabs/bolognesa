// Pomodoro modal
// ***************

var $modal, $modal_close, $modal_container;

var $clicked_pomodoro;

$(document).ready(function() {

  $modal = $('#modal');
  $modal_close = $modal.find('.close');
  $modal_container = $('#modal-container');

  applyEditTagButtonListeners();

  $(document).on('click', '#modal .close, #modal-container', function() {
    $modal_container.hide();
    $modal.hide();
    if($clicked_pomodoro && $clicked_pomodoro.length > 0){
      view.flashPomodoro($clicked_pomodoro);
    }
    return false;
  });

  /* $('input[name=submit]').click(function(){
    $modal_container.hide();
    $modal.hide();
    return false;
  }); */

});

function applyEditTagButtonListeners(){
  $('.edit_tags').click(function(xhr, data, status) {
    $clicked_pomodoro = $(this).closest("li");
    $modal.html(data).prepend($modal_close).css('top', $(window).scrollTop() + 40).show();
    $modal_container.show();
  });
}