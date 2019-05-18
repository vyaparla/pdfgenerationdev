class AddingFieldsPassedpostrepairAndRepairedonsiteForDamperinspection < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_di_repaired_onsite, :string
  	add_column :lsspdfassets, :u_di_passed_post_repair, :string
  end
end