class BlogEntriesController < Spree::BaseController
  # helper Spree::BaseHelper

  resource_controller
  actions :show, :index

  index.before do
    @blog_entries = BlogEntry.find :all, :order => "created_at DESC"
  end

  show.before do
    @blog_entries = BlogEntry.find params[:id]
  end
end
