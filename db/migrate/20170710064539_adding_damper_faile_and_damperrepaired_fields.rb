class AddingDamperFaileAndDamperrepairedFields < ActiveRecord::Migration
  def change
  	add_column :project_completions, :m_total_no_of_dampers_failed, :string
  	add_column :project_completions, :m_total_no_of_dampersrepaired, :string
  end
end
