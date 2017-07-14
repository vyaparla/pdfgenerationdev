class AddingFacilitySysidField < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_facility_sys_id, :string
  end
end
