class AddingServiceFieldForLsspdfgeneration < ActiveRecord::Migration
  def change
    add_column :lsspdfassets, :u_report_type,  :string
  end
end
