begin
  require 'adhearsion/tasks'
rescue LoadError
  STDERR.puts "\nCannot load Adhearsion! Not all Rake tasks will be loaded!\n\n"
end
