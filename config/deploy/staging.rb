server '54.165.215.71', user: 'deploy', roles: %w{web app db}
set :stage, :staging
set :rails_env, :staging