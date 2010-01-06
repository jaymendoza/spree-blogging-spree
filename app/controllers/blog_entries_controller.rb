class BlogEntriesController < Spree::BaseController
  resource_controller
  actions :show, :index

  before_filter :load_news_archive_data

  index.before do
    @blog_entries = BlogEntry.find :all
  end

  show.before do
    @blog_entry = BlogEntry.find(params[:id])
  end

  def tag
    @blog_entries = BlogEntry.by_tag(params[:tag])
    render :action => :index
  end

  def archive
    @blog_entries = BlogEntry.by_date(params)

    if params[:slug]
      @blog_entry = @blog_entries.detect {|e| e.url == params[:slug] }
      render :action => :show
    else
      render :action => :index
    end
  end

  private
  def load_news_archive_data
    @news_archive = NewsArchive.new.entries
  end
end
