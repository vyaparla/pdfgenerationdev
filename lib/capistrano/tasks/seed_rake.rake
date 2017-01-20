namespace :custom do
  desc 'run some rake db task'
  task :run_db_task do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "db:seed"
        end
      end
    end
  end
end