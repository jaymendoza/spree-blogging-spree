class NewsArchiveSweeper < ActionController::Caching::Sweeper
  observe BlogEntry

  def after_create(product)
    expire_cache_for(product)
  end

  def after_update(product)
    expire_cache_for(product)
  end

  def after_destroy(product)
    expire_cache_for(product)
  end

  private
  def expire_cache_for(record)
    expire_fragment(:controller => '#{record}', :action => %w[index show])
  end
end
