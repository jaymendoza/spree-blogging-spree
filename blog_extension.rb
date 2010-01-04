# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class BlogExtension < Spree::Extension
  version "1.0"
  description "Simple blog facility"
  url "git://github.com/jaymendoza/spree-blog.git"

  define_routes do |map|
    map.resources :blog_entries, :as => 'blog'
    map.namespace :admin do |admin|
      admin.resources :blog_entries, :as => 'blog'
    end  
    map.tag 'blog/tag/:tag', :controller => 'blog_entries', :action => 'tag'
    # map.connect '/blog/:year/:month/:day', :controller => 'blog_entries', :action => 'index'
  end
  
  def activate
    Admin::BaseController.class_eval do
      before_filter :add_blog_tab

      def add_blog_tab
        @extension_tabs << [:blog, { :route => "admin_blog_entries" }]
      end
    end
  end

  def self.require_gems(config)
    config.gem 'is_taggable'
  end

  def deactivate
  end
end
