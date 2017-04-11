class AddingNewFieldReplaceDamaper < ActiveRecord::Migration
  def change
    add_column :lsspdfassets, :u_di_installed_access_door,  :string
  	add_column :lsspdfassets, :u_di_replace_damper,  :string
  end
end
