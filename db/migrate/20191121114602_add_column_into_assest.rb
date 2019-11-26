class AddColumnIntoAssest < ActiveRecord::Migration
  def change
  	add_column :lsspdfassets, :u_department_str_firestopinstall, :string
  end
end
