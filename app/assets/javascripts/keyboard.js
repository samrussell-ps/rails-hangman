$(document).on('page:change', function(){
  $('#keyboard .key').click(function(){
    var character = $(this).attr('letter');
    $('#letter').val(character)
    $(this).closest('form').submit();
  });

  $('#navbar').on('show.bs.collapse', function(){
    $('#keyboard-container').hide();
  });

  $('#navbar').on('hidden.bs.collapse', function(){
    $('#keyboard-container').show();
  });

  $('.alert').click(function(){
    $(this).hide('slow');
  });
});
