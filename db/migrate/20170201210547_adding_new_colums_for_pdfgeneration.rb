class AddingNewColumsForPdfgeneration < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_damper_name,  :string
  	add_column :lsspdfassets, :u_non_accessible_reasons,  :string
  end
end
