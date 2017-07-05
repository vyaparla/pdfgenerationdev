class ProjectCompletion < ActiveRecord::Base
  
  has_attached_file :m_authorization_signature
  validates_attachment :m_authorization_signature, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def project_completion_full_path
    File.join(project_completion_pdf_path, 'project_completion_report.pdf')
  end

  private

  def project_completion_pdf_path
  	File.join(Rails.root, %w(public content projectcompletion projectcompletion_pdf_reports), "#{id}")
  end
end
