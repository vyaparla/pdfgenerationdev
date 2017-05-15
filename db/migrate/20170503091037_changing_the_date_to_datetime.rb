class ChangingTheDateToDatetime < ActiveRecord::Migration
  def change
  	change_column :lsspdfassets, :u_job_start_date, :datetime
    change_column :lsspdfassets, :u_job_end_date, :datetime
    change_column :lsspdfassets, :u_inspected_on, :datetime
  end
end
