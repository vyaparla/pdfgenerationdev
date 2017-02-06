class AddingFiredoorNewFieldsInPdf < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_door_category,  :string
  	add_column :lsspdfassets, :u_fire_rating,  :string
  	add_column :lsspdfassets, :u_door_inspection_result,  :string
  	add_column :lsspdfassets, :u_door_type,  :string
  end
end
