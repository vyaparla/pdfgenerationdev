class AddUpdatedDateToLsspdfasset < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_updated_date, :datetime 
  end	
end
