class CreateDamperInspectionJobs < ActiveRecord::Migration
  def change
    create_table :damper_inspection_jobs do |t|

      t.timestamps null: false
    end
  end
end
