require 'spree_core'
require 'spree_blogging_spree_hooks'

module SpreeBloggingSpree
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Ability.register_ability(SpreeBloggingSpreeAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end
