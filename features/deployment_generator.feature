Feature: Adhearsion Deployment Generator
  In order to integrate Adhearsion and Rails
  As a rails developer
  I want to be able to deploy adhearsion as part of my rails app

  Scenario: Generate rails integrated deployment config
    Given a new Rails app
    When I cd to "rails_app"
    And I have capistrano setup
    And I run `rails g ahn:deployment world_domination -f`

    Then the file "config/all.god" should contain exactly:
      """
      God::Contacts::Email.defaults do |d|
        d.from_email      = "status@mydomain.com"
        d.from_name       = "World Domination Status Monitor"
        d.delivery_method = :sendmail
      end

      God.contact(:email) do |c|
        c.name = "me"
        c.to_email = "me@mydomain.com"
        c.group = "support"
      end

      # load in all god configs
      God.load File.join(File.dirname(__FILE__), 'god', '*.god')

      """
    And the file "config/god/adhearsion.god" should contain exactly:
      """
      @deploy_path = '/home/deploy/application'
      @app_path = File.join @deploy_path, 'current', 'adhearsion'
      @pid_file = File.join @deploy_path, 'shared', 'adhearsion', 'pids', 'adhearsion.pid'

      def ahnctl_command(action = :start)
        "cd #{@app_path} && bundle exec ahnctl #{action} #{@app_path} --pid-file=#{@pid_file}"
      end

      God.watch do |w|
        w.name = "world_domination-adhearsion"
        w.group = "world_domination"

        w.interval = 30.seconds
        w.start_grace = 20.seconds
        w.restart_grace = 20.seconds

        w.dir = @app_path

        w.start = ahnctl_command :start
        w.stop = ahnctl_command :stop
        w.restart = ahnctl_command :restart

        w.pid_file = @pid_file
        w.behavior :clean_pid_file

        w.uid = "deploy"
        w.gid = "deploy"

        w.start_if do |start|
          start.condition(:process_running) do |c|
            c.interval = 5.seconds
            c.running = false
          end
        end

        w.restart_if do |restart|
          restart.condition(:memory_usage) do |c|
            c.above = 150.megabytes
            c.times = [3, 5] # 3 out of 5 intervals
          end

          restart.condition(:cpu_usage) do |c|
            c.above = 50.percent
            c.times = 5
          end
        end

        w.lifecycle do |on|
          on.condition(:flapping) do |c|
            c.to_state = [:start, :restart]
            c.times = 5
            c.within = 5.minute
            c.transition = :unmonitored
            c.retry_in = 10.minutes
            c.retry_times = 5
            c.retry_within = 2.hours
            c.notify = {:contacts => ['support'], :priority => 1, :category => 'adhearsion'}
          end
        end
      end

      """
    And the file "config/deploy.rb" should contain "god load #{release_path}/config/all.god"
    And the file "config/deploy.rb" should contain "god restart world_domination-adhearsion"
