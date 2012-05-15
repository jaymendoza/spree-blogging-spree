class Admin::BlogEntriesController < Admin::BaseController
  resource_controller

  index.before do 
    @blog_entries = BlogEntry.find(:all, :order => "created_at DESC")
  end

  new_action.before do
    @blog_entry.build_blog_entry_image
  end

  create.wants.html { redirect_to admin_blog_entries_path }
  update.wants.html { redirect_to admin_blog_entries_path }
end
