$(document).on('page:change', function(){
  // handle keyboard presses
  // TODO rely less on DOM
  // #keyboard .key
  // $(this).attr('letter') etc
  $('#keyboard li').click(function(){
    var character = $(this).children().first().html();
    // this is yucky
    // TODO make not yucky
    $('#letter').val(character)
    // #(this).closest('form').submit() less reliant on DOM
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
