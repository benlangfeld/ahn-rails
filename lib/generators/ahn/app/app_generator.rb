require 'generators/ahn'

module Ahn
  module Generators
    class AppGenerator < Base
      argument :config_name, :type => :string, :default => 'app', :banner => 'config_name'

      def generate_app
        # template "load_config.rb", "config/initializers/load_#{file_name}_config.rb"
        # copy_file "config.yml", "config/#{file_name}_config.yml"
      end

      private

      def file_name
        config_name.underscore
      end

      def constant_name
        config_name.underscore.upcase
      end
    end
  end
end
