class AddingInstanceUrlForProjectCompletionReport < ActiveRecord::Migration
  def change
  	add_column :project_completions, :m_instance_url, :string
  end
end