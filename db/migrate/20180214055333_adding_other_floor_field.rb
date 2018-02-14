class AddingOtherFloorField < ActiveRecord::Migration
  def change
    add_column :lsspdfassets, :u_other_floor, :string
  end
end
