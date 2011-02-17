jQuery(function() {
  $('#news-archive ul.months').hide().filter(':first').show().parent().addClass('open');

  $('#news-archive h6').click( function() {
    $(this).parent().toggleClass('open').find('ul.months').slideToggle(100);
  });
});
