jQuery(function() {
  $('.months li').children('ul:not(:first)').hide();
  $('.months li').children(':first').show();

  $('ul.months > li').click(function(evt) {
    var entry_list = $(this).find('ul');

    if($(evt.target).parent().hasClass('months')) {
      if(entry_list.is(':visible')) {
        entry_list.slideUp('fast');
      } else {
        entry_list.slideDown('fast');
      }
    }
  });

  $('li.year').click(function(evt) {
    var month_list = $(this).find('ul.months');

    if($(evt.target).parent().is('#news-archive')) {
      if(month_list.is(':visible')) {
        month_list.find('ul.posts').slideUp('fast');
        month_list.slideUp('fast');
      } else {
        month_list.slideDown('fast');
      }
    }
  });
});
