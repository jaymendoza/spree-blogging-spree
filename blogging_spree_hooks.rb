class BloggingSpreeHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:blog, { :route => "admin_blog_entries" })  %>)
  end

  insert_after :inside_head do
    %(<%= javascript_include_tag 'news_archive_widget' %>
      <%= stylesheet_link_tag 'blog' %>)
  end
end
