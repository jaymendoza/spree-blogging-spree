class Admin::BlogEntriesController < Admin::BaseController
  resource_controller

  index.before do 
    @blog_entries = BlogEntry.all
  end

  new_action.before do
    @blog_entry.images.build
  end

  create.wants.html { redirect_to admin_blog_entries_path }
  update.wants.html { redirect_to admin_blog_entries_path }
end
