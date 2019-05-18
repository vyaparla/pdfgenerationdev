class ChangeLocationDataType < ActiveRecord::Migration
  def change
    change_column :lsspdfassets, :u_location_desc, :text
  end
end
