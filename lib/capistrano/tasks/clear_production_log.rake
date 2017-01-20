namespace :custom do
  desc 'run some rake db task'
  task :run_clear_production do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "log:clear"
        end
      end
    end
  end
end