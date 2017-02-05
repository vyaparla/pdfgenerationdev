class AddingNewFieldSuggestedUlForFssjob < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_suggested_ul_system,  :string
  end
end
