class AddingCustomernameAndTotalassets < ActiveRecord::Migration
  def change
  	add_column :project_completions, :m_customer_name, :string
  	add_column :project_completions, :m_total_firestop_assets, :string
  end
end
