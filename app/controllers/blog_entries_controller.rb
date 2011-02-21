class BlogEntriesController < Spree::BaseController

  before_filter :load_news_archive_data

  def show
    unless @blog_entry = BlogEntry.find_by_permalink(params[:slug])
        render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
    end
  end

  def index
    @blog_entries = BlogEntry.published.paginate(pagination_options(params))
  end

  def tag
    @blog_entries = BlogEntry.by_tag(params[:tag]).paginate(pagination_options(params))
    render 'index'
  end

  def archive
    @blog_entries = BlogEntry.by_date(params)
    render 'index'
  end

  private

  def load_news_archive_data
      unless Spree::Config[:blog_entries_recent_sidebar].blank?
          if @latest = BlogEntry.latest(Spree::Config[:blog_entries_recent_sidebar])
            @archives = BlogEntry.organize_archives(@latest.to_a.last.created_at)
          end
      else
          @archives = BlogEntry.organize_archives
      end
  end

  def pagination_options(params)
    @pagination_options ||= {:per_page  => Spree::Config[:blog_entries_per_page],
                             :page      => params[:page]}
  end

end
