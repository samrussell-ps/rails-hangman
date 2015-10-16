$(function(){
  // handle keyboard presses
  $('#keyboard li').click(function(){
    var $this = $(this),
    character = $this.children().first().html(); // If it's a lowercase letter, nothing happens to this variable
    // this is yucky
    // TODO make not yucky
    $('#letter').val(character)
    $('#guess_form').submit()
  });

  $('#navbar').on('show.bs.collapse', function(){
    $('#keyboard-container').hide();
  });

  $('#navbar').on('hidden.bs.collapse', function(){
    $('#keyboard-container').show();
  });

  // tap to hide alerts
  $('.alert').click(function(){
    $(this).hide('slow');
  });
});
