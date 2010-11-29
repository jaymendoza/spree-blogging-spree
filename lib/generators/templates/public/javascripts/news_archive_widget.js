jQuery(function() {
  $('#news-archive')
    .find('ul').hide()
      .filter('.months:first').show().end()
      .filter('.posts:first').show().end()
      .end()

    .find('span:lt(2)').addClass('open').end()

    .find('span').click(function() {
      $(this).toggleClass('open');
      $(this).siblings('ul:first').toggle();
    });
});
