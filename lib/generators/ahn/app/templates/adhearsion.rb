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
