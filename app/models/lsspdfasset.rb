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

  def building_records(building)
    #Rails.logger.debug("Asset: #{building.inspect}")
    Lsspdfasset.where(:u_building => building)
  end

  def buildings(serviceID)
    Lsspdfasset.where(:u_service_id => serviceID).pluck('DISTINCT u_building')
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

  def work_dates
    "#{self.u_job_start_date.strftime(I18n.t('date.formats.long'))} - #{self.u_job_end_date.strftime(I18n.t('date.formats.long'))}"
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
