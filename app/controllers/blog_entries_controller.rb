class BlogEntriesController < Spree::BaseController
  resource_controller
  actions :show, :index

  before_filter :load_news_archive_data

  index.before do
    @blog_entries = BlogEntry.find :all
  end

  show.before do
    @blog_entry = BlogEntry.find_by_permalink(params[:slug])
  end

  def tag
    @blog_entries = BlogEntry.by_tag(params[:tag])
    render :action => :index
  end

  def archive
    @blog_entries = BlogEntry.by_date(params)
    render :action => :index
  end

  private

  def load_news_archive_data
    @news_archive = BlogEntry.organize_blog_entries
  end
end
