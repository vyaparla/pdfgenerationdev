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

  has_many :firedoor_deficiencies, :foreign_key => :firedoor_service_sysid


  def buildings(serviceID)
    Lsspdfasset.where(:u_service_id => serviceID, :u_delete => false).order('u_building ASC').pluck('DISTINCT u_building')
  end

  def comprehensive_buildings(facility_id)
    Lsspdfasset.where(:u_facility_id => facility_id, :u_report_type => ["FIRESTOPSURVEY" ,"FIRESTOPINSTALLATION"],  :u_delete => false).order('u_building desc').pluck('DISTINCT u_building')
  end	  

  def damper_comprehensive_buildings(facility_id)
    Lsspdfasset.where(:u_facility_id => facility_id, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"],  :u_delete => false).order('u_building asc').pluck('DISTINCT u_building')
  end 

  def building_records(building, service_ID)
    Lsspdfasset.where(:u_building => building, :u_service_id => service_ID, :u_delete => false)
  end

  def comprehensive_building_records(building, facility_id, report_type)
    Lsspdfasset.where(:u_building => building, :u_facility_id => facility_id, :u_report_type => report_type, :u_delete => false).order('u_updated_date desc')
  end

  def statement_building_records(building, facility_id, report_type)
    records = find_statement_records(building, facility_id, report_type)
    Lsspdfasset.where(:id => records).uniq.order('u_updated_date desc')
  end

  def facility_update(facility_name)
     facility_id  = self.u_facility_id
     records = Lsspdfasset.where(:u_facility_id => facility_id)
     records.update_all(u_facility_name: facility_name)
  end

  def building_update(old_name, new_name)
     facility_id  = self.u_facility_id
     records = Lsspdfasset.where(:u_facility_id => facility_id, :u_building => old_name)
     records.update_all(u_building: new_name)
  end

  def full_report_path(with_picture=true)
     report_name  = (with_picture == "true" || with_picture == true) ? "inspection_report.pdf" :  "inspection_report_without_picture.pdf"	  
     File.join(pdf_path, report_name)
  end

  def full_facilitywise_report_path(with_picture=true, model, report_type)
     name =  model.downcase
     report_type = report_type.downcase  
     report_name  = (with_picture == "true" || with_picture == true) ? name.to_s + "_" +  report_type.to_s +  "_report.pdf" : name.to_s + "_report_without_picture.pdf"
     File.join(facilitywise_pdf_path, report_name)
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

  def dr_graph_na_reasons_path
    File.join(graph_path, 'graph_na_reasons.png')
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

  def comprehensive_dates
    facility_id = self.u_facility_id
    comprehensive_records = Lsspdfasset.select(:id, :u_report_type, :u_job_start_date).where(:u_facility_id => facility_id, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).order('updated_at desc')
    collect_start_dates = comprehensive_records.collect(&:u_job_start_date)
    start_date = collect_start_dates.min
    start_date = start_date.localtime.strftime(I18n.t('date.formats.long'))

    collect_end_dates = comprehensive_records.collect {|date| date.u_job_start_date if date.u_report_type == "DAMPERREPAIR"}
    end_dates =  collect_end_dates - [nil]

     unless end_dates.blank?
       end_date = end_dates.max 
     else
       end_date =  collect_start_dates.max
     end

     end_date = end_date.localtime.strftime(I18n.t('date.formats.long'))

     puts "#{start_date} - #{end_date}" 
     
     return "#{start_date} - #{end_date}"    
  end  

  def statement_dates
    facility_id = self.u_facility_id
    report_type = ["DAMPERREPAIR" ,"DAMPERINSPECTION"]
    repair_ids = unique_statement_records(facility_id, report_type)

    statement_records = Lsspdfasset.select(:id, :u_report_type, :u_job_start_date).where(id: repair_ids).order('updated_at desc')
    collect_start_dates = statement_records.collect(&:u_job_start_date)
    start_date = collect_start_dates.min
    start_date = start_date.localtime.strftime(I18n.t('date.formats.long'))

    collect_end_dates = statement_records.collect {|date| date.u_job_start_date if date.u_report_type == "DAMPERREPAIR"}
    end_dates =  collect_end_dates - [nil]

     unless end_dates.blank?
       end_date = end_dates.max 
     else
       end_date =  collect_start_dates.max
     end

     end_date = end_date.localtime.strftime(I18n.t('date.formats.long'))
     
     return "#{start_date} - #{end_date}"  
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

   def uniq_records(facility_id)
    get_data = Lsspdfasset.select(:id, :u_tag, :u_report_type).where( :u_facility_id => facility_id, :u_report_type => ["FIRESTOPINSTALLATION", "FIRESTOPSURVEY"], :u_delete => false).group(["u_report_type", "u_tag"]).order('u_updated_date desc').count(:u_tag)
    repar_ids = []
    get_data.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => ["FIRESTOPINSTALLATION", "FIRESTOPSURVEY"], :u_delete => false).order('u_updated_date desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => ["FIRESTOPINSTALLATION", "FIRESTOPSURVEY"], :u_delete => false).order('u_updated_date desc').first
        end
      end
     ids = repar_ids.collect(&:id)
  end

  def unique_statement_records(facility_id, report_type)
    get_all = Lsspdfasset.select(:id, :u_tag, :u_report_type).where(:u_facility_id => facility_id, :u_report_type => report_type, :u_delete => false).group(["u_report_type", "u_tag"]).order('u_updated_date desc').count(:u_tag)
    repar_ids = []
    get_all.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('u_updated_date desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('u_updated_date desc').first
        end
      end
     ids = repar_ids.collect(&:id)
  end

  def find_statement_records(building, facility_id, report_type)
    get_all = Lsspdfasset.select(:id, :u_tag, :u_report_type).where(:u_building => building, :u_facility_id => facility_id, :u_report_type => report_type, :u_delete => false).group(["u_report_type", "u_tag"]).order('u_updated_date desc').count(:u_tag)
    repar_ids = []
    get_all.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_building => building, :u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('u_updated_date desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_building => building, :u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('u_updated_date desc').first
        end
      end
     ids = repar_ids.collect(&:id)
  end


  private

  def pdf_path
    File.join(Rails.root, %w(public content pdfjobs pdf_reports), "#{id}")
  end

  def facilitywise_pdf_path
    File.join(Rails.root, %w(public content pdfjobs pdf_reports), "#{u_facility_id}")
  end	  

  def graph_path
    File.join(Rails.root, %w(public content pdfgraph graphs), "#{id}")
  end

#  def find_statement_records(building, facility_id, report_type)
#    get_all = Lsspdfasset.select(:id, :u_tag, :u_report_type).where(:u_building => building, :u_facility_id => facility_id, :u_report_type => report_type, :u_delete => false).group(["u_report_type", "u_tag"]).order('updated_at desc').count(:u_tag)
#    repar_ids = []
#    get_all.each do |key,val|
#        if val > 1
#         repar_ids << Lsspdfasset.select(:id).where(:u_building => building, :u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('updated_at desc').first
#        else
#         repar_ids << Lsspdfasset.select(:id).where(:u_building => building, :u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => report_type, :u_delete => false).order('updated_at desc').first
#        end
#      end
#     ids = repar_ids.collect(&:id)
#  end  

end
