class Lsspdfasset < ActiveRecord::Base
  include Reportable

  class << self
    def reporter_class
      #DamperInspectionReporter
      #PdfGenerationReporter
      PdfjobReporter
    end
  end

  def full_report_path
    File.join(pdf_path, 'inspection_report.pdf')
  end

  private

  def pdf_path
    File.join(Rails.root, %w(public content pdfjobs pdf_reports), "#{sys_id}")
  end

end
