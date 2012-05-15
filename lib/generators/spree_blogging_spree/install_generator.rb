module SpreeBloggingSpree
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Configures your Rails application for use with BloggingSpree"

      def copy_migrations
        directory "db"
      end

      def copy_public
        directory "public"
      end

    end
  end
end
