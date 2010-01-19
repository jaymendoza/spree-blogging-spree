class BloggingSpreeHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:blog, { :route => "admin_blog_entries" })  %>)
  end
end
