class AddNewFieldForDamperRepairJob < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_repair_action_performed,  :string
  end
end
