# config valid only for current version of Capistrano
#lock "3.7.1"

#lock "3.8.2"

set :application, "pdfgenerationdev"
set :repo_url, 'git@github.com:vyaparla/pdfgenerationdev.git' # Edit this to match your repository
#set :branch, :development # This branch is used for production and uat
set :branch, :vsoft_qa # This branch is used for vsoft qa 
set :deploy_to, '/home/deploy/pdfgenerationdev'
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/content}
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, '2.3.3' # Edit this if you are using MRI Ruby
#set :stage, ["staging", "production"]

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
#set :puma_bind,  "unix:///#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,   "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [4, 8]
set :puma_workers, 2
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true
set :assets_roles, [:web, :app]

# for RoR 4
set :default_env, { rvm_bin_path: '~/.rvm/bin' }
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, ''
set :bundle_without, %w{test development}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all

set :console_env, :production

after "deploy:restart", "deploy:cleanup"

namespace :puma do

  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
     # unless `git rev-parse HEAD` == `git rev-parse origin/development` # For production and UAT
     #   puts "WARNING: HEAD is not the same as origin/development" # For production and UAT
     unless `git rev-parse HEAD` == `git rev-parse origin/vsoft_qa` # For VSoft QA
        puts "WARNING: HEAD is not the same as origin/vsoft_qa" # For VSoft QA
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  task :configure_symlinks do
    run "ln -nfs #{shared_path}/public/content #{current_release}/public/content"
  end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     invoke 'puma:restart'
  #   end
  # end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end



  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     invoke 'puma:restart'
  #   end
  # end

  # before :starting,     :check_revision
  # after  :finishing,    :compile_assets
  # after  :finishing,    :cleanup
  # after  :finishing,    :restart


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
