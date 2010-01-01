class BlogEntriesController < Spree::BaseController
  resource_controller
  actions :show, :index

  before_filter :load_news_archive_data
  cache_sweeper :news_archive_sweeper, :only => [:index, :show]

  index.before do
    @blog_entries = BlogEntry.find :all, :order => "created_at DESC"
  end

  show.before do
    @blog_entries = BlogEntry.find params[:id]
  end

  def load_news_archive_data
    @news_archive = NewsArchive.generate
  end
end
