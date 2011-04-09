require 'generators/ahn'

module Ahn
  module Generators
    class DeploymentGenerator < Base
      argument :project_name, :type => :string, :default => 'my_company', :banner => 'project_name'

      def create_god_config
        template "adhearsion.god", "config/adhearsion.god"
      end

    end
  end
end
