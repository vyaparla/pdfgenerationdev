class AddingNewFieldsForFirestopInstallationJob < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_penetration_type,  :string
  	add_column :lsspdfassets, :u_barrier_type,  :string
  	add_column :lsspdfassets, :u_service_type,  :string
  	add_column :lsspdfassets, :u_issue_type,  :string
  	add_column :lsspdfassets, :u_corrected_url_system,  :string
  	add_column :lsspdfassets, :u_active,  :boolean, :default => true
  	add_column :lsspdfassets, :u_delete,  :boolean, :default => false
  end
end
