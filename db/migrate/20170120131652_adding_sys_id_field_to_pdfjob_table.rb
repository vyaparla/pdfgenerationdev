class AddingSysIdFieldToPdfjobTable < ActiveRecord::Migration
  def change
  	add_column :pdfjobs, :sys_id, :string
  end
end
