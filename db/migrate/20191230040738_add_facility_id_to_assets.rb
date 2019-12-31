class AddFacilityIdToAssets < ActiveRecord::Migration
  def change
    add_column :lsspdfassets, :u_facility_id, :string #Facility Id  
  end
end
