class AddingOtherReasonForFailAndNaDamperinspection < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_other_failure_reason,  :string
  	add_column :lsspdfassets, :u_other_nonaccessible_reason,  :string
  end
end