class BlogEntriesController < Spree::BaseController
  resource_controller
  actions :show, :index
  caches_page :show, :index

  before_filter :load_news_archive_data

  index.before do
    @blog_entries = BlogEntry.find :all, :order => "created_at DESC"
  end

  show.before do
    @blog_entry = BlogEntry.find params[:id]
  end

  def load_news_archive_data
    @news_archive = NewsArchive.new.entries
  end
end
