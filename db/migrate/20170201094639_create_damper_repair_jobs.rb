class CreateDamperRepairJobs < ActiveRecord::Migration
  def change
    create_table :damper_repair_jobs do |t|

      t.timestamps null: false
    end
  end
end
