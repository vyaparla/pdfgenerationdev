class AddDamperFieldsToAssets < ActiveRecord::Migration
  def change
    add_column :lsspdfassets, :u_reason2, :string #Subsequent Failure Reason
  end
end
