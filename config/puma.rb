# workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# threads_count = Integer(ENV['MAX_THREADS'] || 5)
# threads threads_count, threads_count
# preload_app!
# rackup      DefaultRackup
# port        ENV['PORT']     || 3000
# environment ENV['RACK_ENV'] || 'development'
# on_worker_boot do
#   # Worker specific setup for Rails 4.1+
#   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
#   ActiveRecord::Base.establish_connection
# end

# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../..", __FILE__)
puts "App dir: #{app_dir}"
# App dir: /home/deploy/apps/mll/releases/20160415184544
shared_dir = "#{app_dir}"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
# bind "unix://#{shared_dir}/sockets/puma.sock"
bind "unix://#{shared}/tmp/sockets/puma.sock"

# Logging
stdout_redirect "#{shared}/log/puma.stdout.log", "#{shared}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared}/tmp/pids/puma.pid"
state_path "#{shared}/tmp/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection
end