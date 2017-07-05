class DamperInspectionJob < ActiveRecord::Base
  #include Reportable
  
  class << self
    def reporter_class
      DamperInspectionReporter
    end

    def projectcompletion_reporter_class
      DamperInspectionProjectCompletionReporter
    end
  end

  # def full_report_path
  #   File.join(pdf_path, 'inspection_report.pdf')
  # end

  # private

  # def pdf_path
  #   File.join(Rails.root, %w(public content damper_inspection_jobs pdf_reports), "#{id}")
  # end

end
