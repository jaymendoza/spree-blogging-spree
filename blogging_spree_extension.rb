# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class BloggingSpreeExtension < Spree::Extension
  version "0.2.1"
  description "BloggingSpree: A Spree blogging solution"
  url "git://github.com/jaymendoza/spree-blogging-spree.git"

  def activate
  end

  def self.require_gems(config)
    config.gem 'is_taggable'
  end

  def deactivate
  end
end
