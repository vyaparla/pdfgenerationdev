class Lsspdfasset < ActiveRecord::Base
  include Reportable

  #delegate :joint_commission_certified?, to: :id

  class << self
    def reporter_class
      #DamperInspectionReporter
      #PdfGenerationReporter
      PdfjobReporter
    end
  end

  # # has_many :lsspdfassets
  # # alias_attribute :records, :lsspdfassets
  # belongs_to :lsspdfasset, :foreign_key => 'lsspdfasset_id'


  def buildings(serviceID)
    Lsspdfasset.where(:u_service_id => serviceID).pluck('DISTINCT u_building')
  end

  def building_records(building, service_ID)
    #Rails.logger.debug("Asset: #{building.inspect}")
    Lsspdfasset.where(:u_building => building, :u_service_id => service_ID)
  end

  def full_report_path
    File.join(pdf_path, 'inspection_report.pdf')
  end

  def graph_by_building_path
    File.join(graph_path, 'graph_dampers_by_building.png')
  end

  def graph_by_type_path
    File.join(graph_path, 'graph_dampers_by_type.png')
  end

  def graph_by_result_path
    File.join(graph_path, 'graph_dampers_by_result.png')
  end

  def graph_na_reasons_path
    File.join(graph_path, 'graph_na_reasons.png')
  end

  def graph_top_issues_path
    File.join(graph_path, 'graph_top_issues.png')
  end

  def work_dates
    unless self.u_job_start_date.blank?
      start_date = self.u_job_start_date.strftime(I18n.t('date.formats.long'))
    end

    unless self.u_job_end_date.blank?
      end_date = self.u_job_end_date.strftime(I18n.t('date.formats.long'))
    end
    unless end_date.blank?
      "#{start_date} - #{end_date}"
    else
      "#{start_date}"
    end
    
  end

  private

  def pdf_path
    File.join(Rails.root, %w(public content pdfjobs pdf_reports), "#{id}")
  end

  def graph_path
    File.join(Rails.root,
              %w(public content pdfgraph graphs), "#{id}")
  end

end
