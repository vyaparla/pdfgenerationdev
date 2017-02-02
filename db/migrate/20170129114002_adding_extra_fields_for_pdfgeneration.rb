class AddingExtraFieldsForPdfgeneration < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_inspected_on,  :date
  	add_column :lsspdfassets, :u_inspector,     :string
  	add_column :lsspdfassets, :u_group_name,    :string
  	add_column :lsspdfassets, :u_facility_name, :string
  end
end
