class AddingNewFieldsForDamperrepairPdfReport < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_dr_passed_post_repair,  :string
  	add_column :lsspdfassets, :u_dr_description,  :string
  	add_column :lsspdfassets, :u_dr_damper_model,  :string
  	add_column :lsspdfassets, :u_dr_installed_damper_type,  :string
  	add_column :lsspdfassets, :u_dr_installed_damper_height,  :string
  	add_column :lsspdfassets, :u_dr_installed_damper_width,  :string
  	add_column :lsspdfassets, :u_dr_installed_actuator_model,  :string
  	add_column :lsspdfassets, :u_dr_installed_actuator_type,  :string
  	add_column :lsspdfassets, :u_dr_actuator_voltage,  :string
  end
end
