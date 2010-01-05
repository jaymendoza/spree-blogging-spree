# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class BlogExtension < Spree::Extension
  version "0.1.0"
  description "BloggingSpree: A Spree blogging solution"
  url "git://github.com/jaymendoza/BloggingSpree.git"

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
