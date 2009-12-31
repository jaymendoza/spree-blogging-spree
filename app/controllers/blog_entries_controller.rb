class BlogEntriesController < Spree::BaseController
  before_filter :load_news_archive_data

  resource_controller
  actions :show, :index

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
