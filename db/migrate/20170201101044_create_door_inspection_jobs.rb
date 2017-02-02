class CreateDoorInspectionJobs < ActiveRecord::Migration
  def change
    create_table :door_inspection_jobs do |t|

      t.timestamps null: false
    end
  end
end
