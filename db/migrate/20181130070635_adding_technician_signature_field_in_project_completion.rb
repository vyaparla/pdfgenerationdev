class AddingTechnicianSignatureFieldInProjectCompletion < ActiveRecord::Migration
  def change
  	add_column :project_completions, :m_technician_signature_base64, :text, :limit => 4294967295
  	add_attachment :project_completions, :m_technician_signature
  	add_column :project_completions, :m_total_no_of_ceiling_hatches_installed, :string
  end
end
