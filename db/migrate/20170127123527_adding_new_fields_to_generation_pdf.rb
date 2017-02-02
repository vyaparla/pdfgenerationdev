class AddingNewFieldsToGenerationPdf < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_job_start_date, :date
    add_column :lsspdfassets, :u_job_end_date, :date
    add_column :lsspdfassets, :u_job_scale_rep, :string

    add_column :lsspdfassets, :u_building, :string
    add_column :lsspdfassets, :u_reason, :string
    add_column :lsspdfassets, :u_access_size, :string
  end
end
