require 'generators/ahn'

module Ahn
  module Generators
    class AppGenerator < Base
      def generate_app
        generate_ahn_app
        place_files_for_rails
        remove_ahn_tmp
        place_custom_files
      end

      private

      def ahn_tmp_dir
        'tmp/adhearsion'
      end

      def generate_ahn_app
        run "ahn create #{ahn_tmp_dir}"
      end

      def place_files_for_rails
        run "mv #{ahn_tmp_dir}/components components"
        run "mv #{ahn_tmp_dir}/dialplan.rb app/dialplan.rb"
        run "mv #{ahn_tmp_dir}/events.rb app/events.rb"
      end

      def remove_ahn_tmp
        remove_dir ahn_tmp_dir
      end

      def place_custom_files
        gem "adhearsion", ">= 1.0.1"
        copy_file "adhearsion.rake", "lib/tasks/adhearsion.rake"
        copy_file "adhearsion.rb", "config/adhearsion.rb"
        copy_file "adhearsion.yml", "config/adhearsion.example.yml"
        copy_file "ahnrc", ".ahnrc"
      end
    end
  end
end
