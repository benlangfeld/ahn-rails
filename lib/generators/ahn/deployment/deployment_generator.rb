require 'generators/ahn'

module Ahn
  module Generators
    class DeploymentGenerator < Base
      argument :project_name, :type => :string, :default => 'my_company', :banner => 'project_name'

      def create_god_config
        template "general.god", "config/all.god"
        template "adhearsion.god", "config/god/adhearsion.god"
      end

      def use_god_via_capistrano
        return unless got_capistrano?

        append_file "config/deploy.rb", <<-STRING
after 'deploy:restart', 'deploy:restart_adhearsion'
role :adhearsion, "adhearsion.domain.com"
namespace :deploy do
  task :restart_adhearsion, :roles => :adhearsion do
    sudo "god load \#{release_path}/config/all.god"
    sudo "god restart #{project_name}-adhearsion"
  end
end
        STRING
      end

      private

      def got_capistrano?
        File.exists? File.join(destination_root, "config/deploy.rb")
      end

    end
  end
end
