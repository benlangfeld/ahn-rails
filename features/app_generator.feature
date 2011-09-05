Feature: Adhearsion App Generator
  In order to integrate Adhearsion and Rails
  As a rails developer
  I want to generate an Adhearsion app inside my Rails app

  Scenario: Generate railsified application layout
    Given a new Rails app
    When I cd to "rails_app"
    And I run `rails g ahn:app -f`
    Then the following directories should exist:
      | components            |
      | components/simon_game |

    And the following files should exist:
      | app/dialplan.rb      |
      | app/events.rb        |
      | config/adhearsion.rb |

    And the file "config/adhearsion.rb" should contain exactly:
      """
      require 'rubygems'
      require 'bundler'
      Bundler.setup
      Bundler.require :adhearsion

      Adhearsion::Configuration.configure do |config|

        values = YAML.load_file File.expand_path('../adhearsion.yml', __FILE__)

        (values['gem_components'] || []).each do |c|
          config.add_component c
        end

        config.logging :level => values['log_level'].to_sym
        config.automatically_answer_incoming_calls = values['automatically_answer_incoming_calls'] if values.has_key?('automatically_answer_incoming_calls')
        config.end_call_on_hangup = values['end_call_on_hangup'] if values.has_key?('end_call_on_hangup')
        config.end_call_on_error = values['end_call_on_error'] if values.has_key?('end_call_on_error')

        config.enable_asterisk :argument_delimiter => values['argument_delimiter'] || '|'
        config.asterisk.enable_ami values['ami']

        config.enable_drb if values['drb']

        config.enable_rails :path => '.', :env => values['rails_env'].to_sym

      end

      Adhearsion::Initializer.start_from_init_file(__FILE__, File.dirname(__FILE__) + "/..")

      """
    And the file "config/adhearsion.example.yml" should contain exactly:
      """
      gem_components:


      log_level: debug

      automatically_answer_incoming_calls: true
      end_call_on_hangup: true
      end_call_on_error: true

      argument_delimiter: "|"
      ami:
        host: 127.0.0.1
        username: test
        password: test
        events: true

      drb: true

      rails_env: production

      """
    And the file "Gemfile" should contain "adhearsion"
    And the file "Gemfile" should contain "1.0.1"
    And the file "lib/tasks/adhearsion.rake" should contain exactly:
      """
      begin
        require 'adhearsion/tasks'
      rescue LoadError
        STDERR.puts "\nCannot load Adhearsion! Not all Rake tasks will be loaded!\n\n"
      end

      """
    And the file ".ahnrc" should contain exactly:
      """
      # Adhearsion Runtime Configuration.

      paths:

        # All paths are relative to this file's directory
        init: config/adhearsion.rb

        dialplan: app/dialplan.rb

        events: app/events.rb

        models: app/models/*.rb

      """
    And a directory named "tmp/adhearsion" should not exist
