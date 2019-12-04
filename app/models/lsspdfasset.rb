class Lsspdfasset < ActiveRecord::Base
  #include Reportable

  #delegate :joint_commission_certified?, to: :id

  class << self
    def reporter_class
      #DamperInspectionReporter
      #PdfGenerationReporter
      PdfjobReporter
    end
  end

  has_attached_file :pdf_image1, styles: { large: "5000x500>", thumb: "50x50#", pdf: "500x500#" }
  has_attached_file :pdf_image2, styles: { large: "5000x500>", thumb: "50x50#", pdf: "500x500#" }
  has_attached_file :pdf_image3, styles: { large: "5000x500>", thumb: "50x50#", pdf: "500x500#" }
  has_attached_file :pdf_image4, styles: { large: "5000x500>", thumb: "50x50#", pdf: "500x500#" }

  validates_attachment :pdf_image1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment :pdf_image2, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment :pdf_image3, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment :pdf_image4, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # # has_many :lsspdfassets
  # # alias_attribute :records, :lsspdfassets
  # belongs_to :lsspdfasset, :foreign_key => 'lsspdfasset_id'

  has_many :firedoor_deficiencies, :foreign_key => :firedoor_service_sysid


  def buildings(serviceID)
    Lsspdfasset.where(:u_service_id => serviceID, :u_delete => false).pluck('DISTINCT u_building')
  end

  def building_records(building, service_ID)
    #Rails.logger.debug("Asset: #{building.inspect}")
    Lsspdfasset.where(:u_building => building, :u_service_id => service_ID, :u_delete => false)
  end

  def full_report_path(with_picture=true)
     report_name  = (with_picture == "true" || with_picture == true) ? "inspection_report.pdf" :  "inspection_report_without_picture.pdf"	  
     File.join(pdf_path, report_name)
  end


  def summary_report_path
    File.join(pdf_path, 'summary_report.pdf')
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

  def installation_top_issue_path
    File.join(graph_path, 'installation_graph_top_issues.png')
  end

  def dr_graph_by_building_path
    File.join(graph_path, 'dr_graph_by_building.png')
  end

  def dr_graph_by_type_path
    File.join(graph_path, 'dr_graph_by_type.png')
  end

  def dr_graph_by_result_path
    File.join(graph_path, 'dr_graph_by_result.png')
  end

  def graph_firedoor_door_by_rating_path
    File.join(graph_path, 'firedoor_graph_door_by_rating.png')
  end

  def work_dates
    unless self.u_job_start_date.blank?
      start_date = self.u_job_start_date.localtime.strftime(I18n.t('date.formats.long'))
    end

    unless self.u_job_end_date.blank?
      end_date = self.u_job_end_date.localtime.strftime(I18n.t('date.formats.long'))
    end
    unless end_date.blank?
      "#{start_date} - #{end_date}"
    else
      "#{start_date}"
    end
  end

  def comperhensive_result(record)
    if record.u_report_type == "DAMPERINSPECTION"
      if record.u_status == "Pass"
        return "PASS"
      elsif record.u_status == "Fail"
        return "FAIL"
      elsif record.u_status == "NA"
        return "NON-ACCESSIBLE"
      else
        return "REMOVED"
      end
    else
      if record.u_report_type == "DAMPERREPAIR"
        if record.u_dr_passed_post_repair == "Pass"
          return "PASS"
        else
          return "FAIL"
        end
      end
    end
  end

  private

  def pdf_path
    File.join(Rails.root, %w(public content pdfjobs pdf_reports), "#{id}")
  end

  def graph_path
    File.join(Rails.root, %w(public content pdfgraph graphs), "#{id}")
  end

end
