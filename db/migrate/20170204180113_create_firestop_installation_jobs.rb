class CreateFirestopInstallationJobs < ActiveRecord::Migration
  def change
    create_table :firestop_installation_jobs do |t|

      t.timestamps null: false
    end
  end
end
