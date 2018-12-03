class ApiController < ApplicationController
  
  def save_pdf
    if params[:status] == "insert"
      @pdfjob = Lsspdfasset.new(lssassets_job)
      @pdfjob.save
      
      unless @pdfjob.u_image1.blank?
        @pdf_image1 = StringIO.open(Base64.decode64(@pdfjob.u_image1))
        @pdf_image1.class.class_eval { attr_accessor :original_filename, :content_type }
        @pdf_image1.original_filename = "#{params[:image_file_name1]}.jpg"
        @pdf_image1.content_type = "image/jpeg"
        @pdfjob.pdf_image1 = @pdf_image1
      end

      unless @pdfjob.u_image2.blank?
        @pdf_image2 = StringIO.open(Base64.decode64(@pdfjob.u_image2))
        @pdf_image2.class.class_eval { attr_accessor :original_filename, :content_type }
        @pdf_image2.original_filename = "#{params[:image_file_name2]}.jpg"
        @pdf_image2.content_type = "image/jpeg"
        @pdfjob.pdf_image2 = @pdf_image2
      end
      
      unless @pdfjob.u_image3.blank?
        @pdf_image3 = StringIO.open(Base64.decode64(@pdfjob.u_image3))
        @pdf_image3.class.class_eval { attr_accessor :original_filename, :content_type }
        @pdf_image3.original_filename = "#{params[:image_file_name3]}.jpg"
        @pdf_image3.content_type = "image/jpeg"
        @pdfjob.pdf_image3 = @pdf_image3
      end

      unless @pdfjob.u_image4.blank?
        @pdf_image4 = StringIO.open(Base64.decode64(@pdfjob.u_image4))
        @pdf_image4.class.class_eval { attr_accessor :original_filename, :content_type }
        @pdf_image4.original_filename = "#{params[:image_file_name4]}.jpg"
        @pdf_image4.content_type = "image/jpeg"
        @pdfjob.pdf_image4 = @pdf_image4
      end

      # @pdfjob.u_job_start_date =  Time.now.utc
      # @pdfjob.u_job_end_date =  Time.now.utc
      # @pdfjob.u_inspected_on =  Time.now.utc
      
      #General Fields
      @pdfjob.u_group_name = HTMLEntities.new.decode params[:u_group_name]
      @pdfjob.u_facility_name = HTMLEntities.new.decode params[:u_facility_name]
      @pdfjob.u_building = HTMLEntities.new.decode params[:u_building]
      @pdfjob.u_location_desc = HTMLEntities.new.decode params[:u_location_desc]
      
      #Damper Inspection Fields
      @pdfjob.u_reason = HTMLEntities.new.decode params[:u_reason]
      @pdfjob.u_other_failure_reason = HTMLEntities.new.decode params[:u_other_failure_reason]
      @pdfjob.u_di_replace_damper = HTMLEntities.new.decode params[:u_di_replace_damper]
      @pdfjob.u_non_accessible_reasons = HTMLEntities.new.decode params[:u_non_accessible_reasons]
      @pdfjob.u_other_nonaccessible_reason = HTMLEntities.new.decode params[:u_other_nonaccessible_reason]
      @pdfjob.u_di_installed_access_door = HTMLEntities.new.decode params[:u_di_installed_access_door]
      
      #Damper Repair Fields
      @pdfjob.u_repair_action_performed = HTMLEntities.new.decode params[:u_repair_action_performed]
      @pdfjob.u_dr_passed_post_repair = HTMLEntities.new.decode params[:u_dr_passed_post_repair]
      @pdfjob.u_dr_description = HTMLEntities.new.decode params[:u_dr_description]
      @pdfjob.u_dr_damper_model = HTMLEntities.new.decode params[:u_dr_damper_model]
      @pdfjob.u_dr_installed_damper_type = HTMLEntities.new.decode params[:u_dr_installed_damper_type]
      @pdfjob.u_dr_installed_damper_width = HTMLEntities.new.decode params[:u_dr_installed_damper_width]
      @pdfjob.u_dr_installed_damper_height = HTMLEntities.new.decode params[:u_dr_installed_damper_height]
      @pdfjob.u_dr_installed_actuator_model = HTMLEntities.new.decode params[:u_dr_installed_actuator_model]
      @pdfjob.u_dr_installed_actuator_type = HTMLEntities.new.decode params[:u_dr_installed_actuator_type]
      @pdfjob.u_dr_actuator_voltage = HTMLEntities.new.decode params[:u_dr_actuator_voltage]

      #Firedoor Inspection Fields
      @pdfjob.u_door_category = HTMLEntities.new.decode params[:u_door_category]
      @pdfjob.u_fire_rating = HTMLEntities.new.decode params[:u_fire_rating]
      @pdfjob.u_door_type = HTMLEntities.new.decode params[:u_door_type]
      
      #Firestop Survey and Installation Fields
      @pdfjob.u_issue_type = HTMLEntities.new.decode params[:u_issue_type]
      @pdfjob.u_barrier_type = HTMLEntities.new.decode params[:u_barrier_type]
      @pdfjob.u_penetration_type = HTMLEntities.new.decode params[:u_penetration_type]
      @pdfjob.u_corrected_url_system = HTMLEntities.new.decode params[:u_corrected_url_system]
      @pdfjob.u_suggested_ul_system = HTMLEntities.new.decode params[:u_suggested_ul_system]

      @pdfjob.save

      render json: {message: "Save Success"}
    else
      if params[:status] == "update"
        @pdfjob = Lsspdfasset.find_by(u_asset_id: params[:u_asset_id])

        if @pdfjob.update(lssassets_job)
          
          unless @pdfjob.u_image1.blank?
            @pdf_image1 = StringIO.open(Base64.decode64(@pdfjob.u_image1))
            @pdf_image1.class.class_eval { attr_accessor :original_filename, :content_type }
            @pdf_image1.original_filename = "#{params[:image_file_name1]}.jpg"
            @pdf_image1.content_type = "image/jpeg"
            @pdfjob.update_attribute(:pdf_image1, @pdf_image1)
          end

          unless @pdfjob.u_image2.blank?
            @pdf_image2 = StringIO.open(Base64.decode64(@pdfjob.u_image2))
            @pdf_image2.class.class_eval { attr_accessor :original_filename, :content_type }
            @pdf_image2.original_filename = "#{params[:image_file_name2]}.jpg"
            @pdf_image2.content_type = "image/jpeg"
            @pdfjob.update_attribute(:pdf_image2, @pdf_image2)
          end
      
          unless @pdfjob.u_image3.blank?
            @pdf_image3 = StringIO.open(Base64.decode64(@pdfjob.u_image3))
            @pdf_image3.class.class_eval { attr_accessor :original_filename, :content_type }
            @pdf_image3.original_filename = "#{params[:image_file_name3]}.jpg"
            @pdf_image3.content_type = "image/jpeg"
            @pdfjob.update_attribute(:pdf_image3, @pdf_image3)
          end

          unless @pdfjob.u_image4.blank?
            @pdf_image4 = StringIO.open(Base64.decode64(@pdfjob.u_image4))
            @pdf_image4.class.class_eval { attr_accessor :original_filename, :content_type }
            @pdf_image4.original_filename = "#{params[:image_file_name4]}.jpg"
            @pdf_image4.content_type = "image/jpeg"
            @pdfjob.update_attribute(:pdf_image4, @pdf_image4)
          end

          #@pdfjob.update_attributes(:u_job_start_date =>  Time.now.utc, :u_job_end_date => Time.now.utc, :u_inspected_on => Time.now.utc)

          gname = HTMLEntities.new.decode params[:u_group_name]
          fname = HTMLEntities.new.decode params[:u_facility_name]
          building = HTMLEntities.new.decode params[:u_building]
          location_desc = HTMLEntities.new.decode params[:u_location_desc]
          reason = HTMLEntities.new.decode params[:u_reason]
          other_failure_reason = HTMLEntities.new.decode params[:u_other_failure_reason]
          di_replace_damper = HTMLEntities.new.decode params[:u_di_replace_damper]
          non_accessible_reasons  = HTMLEntities.new.decode params[:u_non_accessible_reasons]
          other_nonaccessible_reason = HTMLEntities.new.decode params[:u_other_nonaccessible_reason]
          installed_access_door = HTMLEntities.new.decode params[:u_di_installed_access_door]
          repair_action_performed = HTMLEntities.new.decode params[:u_repair_action_performed]
          dr_passed_post_repair =  HTMLEntities.new.decode params[:u_dr_passed_post_repair]
          dr_description =  HTMLEntities.new.decode params[:u_dr_description]
          dr_damper_model =  HTMLEntities.new.decode params[:u_dr_damper_model]
          dr_installed_damper_type = HTMLEntities.new.decode params[:u_dr_installed_damper_type]
          dr_installed_damper_width = HTMLEntities.new.decode params[:u_dr_installed_damper_width]
          dr_installed_damper_height = HTMLEntities.new.decode params[:u_dr_installed_damper_height]
          dr_installed_actuator_model = HTMLEntities.new.decode params[:u_dr_installed_actuator_model]
          dr_installed_actuator_type = HTMLEntities.new.decode params[:u_dr_installed_actuator_type]
          dr_actuator_voltage = HTMLEntities.new.decode params[:u_dr_actuator_voltage]
          door_category = HTMLEntities.new.decode params[:u_door_category]
          fire_rating =  HTMLEntities.new.decode params[:u_fire_rating]
          door_type = HTMLEntities.new.decode params[:u_door_type]
          issue_type =  HTMLEntities.new.decode params[:u_issue_type]
          barrier_type = HTMLEntities.new.decode params[:u_barrier_type]
          penetration_type = HTMLEntities.new.decode params[:u_penetration_type]
          corrected_url_system =  HTMLEntities.new.decode params[:u_corrected_url_system]
          suggested_ul_system = HTMLEntities.new.decode params[:u_suggested_ul_system]
 
          @pdfjob.update_attributes(u_group_name: gname, u_facility_name: fname, u_building: building, u_location_desc: location_desc, 
                                    u_reason:  reason, u_other_failure_reason:  other_failure_reason, u_di_replace_damper: di_replace_damper,
                                    u_non_accessible_reasons: non_accessible_reasons, u_other_nonaccessible_reason: other_nonaccessible_reason,
                                    u_di_installed_access_door:  installed_access_door, u_repair_action_performed: repair_action_performed,
                                    u_dr_passed_post_repair:  dr_passed_post_repair, u_dr_description:  dr_description,
                                    u_dr_damper_model:  dr_damper_model, u_dr_installed_damper_type: dr_installed_damper_type,
                                    u_dr_installed_damper_width: dr_installed_damper_width, u_dr_installed_damper_height: dr_installed_damper_height,
                                    u_dr_installed_actuator_model: dr_installed_actuator_model, u_dr_installed_actuator_type: dr_installed_actuator_type,
                                    u_dr_actuator_voltage: dr_actuator_voltage, u_door_category: door_category, u_fire_rating:  fire_rating,
                                    u_door_type: door_type, u_issue_type: issue_type, u_barrier_type: barrier_type, u_penetration_type: penetration_type,
                                    u_corrected_url_system:  corrected_url_system, u_suggested_ul_system: suggested_ul_system)

          render json: {message: "Update Success"}
        else
          render json: {message: "Unable to Update the record!"}
        end
      else
        @pdfjob = Lsspdfasset.find_by(u_asset_id: params[:u_asset_id])
        @pdfjob.destroy
        render json: {message: "Delete Success"}
      end
    end
  end

  def pdf_generation
    # @group_name    = params[:groupname]
    # @facility_name = params[:facilityname]
    # @group_url     = params[:groupurl]
    # @facility_url  = params[:facilityurl]
    # @nfpa_url      = params[:nfpaurl]
    #@serviceID     = params[:serviceID]
    @model_name    = params[:service].delete(' ').upcase + params[:type].upcase
    @address1      = params[:address1]
    @address2      = params[:address2]
    @csz           = params[:csz]
    @facility_type = params[:facilitytype]
    @tech          = params[:tech]
    @group_name    = HTMLEntities.new.decode params[:groupname]
    @facility_name = HTMLEntities.new.decode params[:facilityname]
  
  	@pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).last
    unless @pdfjob.blank?
      #ReportGeneration.new(@pdfjob, @group_name, @facility_name, @group_url, @facility_url).generate_full_report
      ReportGeneration.new(@pdfjob, @model_name, @address1, @address2, @csz, @facility_type, @tech, @group_name, @facility_name).generate_full_report
  	  render json: {message: "Success"}
    else
      render json: {message: "Unsuccess"}
    end
  end

  def download_full_pdf_report
    @pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).last
    @outputfile = @pdfjob.u_job_id + "_" + params[:servicetype] + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "detail_report"
    send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""    
  end

  def summary_report
    @model_name    = params[:service].delete(' ').upcase + params[:type].upcase
    @address       = params[:address]
    @facility_type = params[:facilitytype]
    @tech          = params[:tech]
     
    @pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).first
    ReportGeneration.new(@pdfjob, @model_name, @address, @facility_type, @tech).generate_summary_report
    @outputfile = @pdfjob.u_job_id + "_" + @model_name +"_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "summary_report"
    send_file @pdfjob.summary_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
  end

  def save_firedoor_deficiency
    if params[:fd_insert] == "insert"
      @firedoor_deficiency = FiredoorDeficiency.new
      @firedoor_deficiency.firedoor_service_sysid                  = params[:firedoor_service_sysid]
      @firedoor_deficiency.firedoor_asset_sysid                    = params[:firedoor_asset_sysid]
      @firedoor_deficiency.firedoor_deficiencies_sysid             = params[:firedoor_deficiencies_sysid]
      @firedoor_deficiency.firedoor_deficiencies_code              = HTMLEntities.new.decode params[:firedoor_deficiencies_code]
      @firedoor_deficiency.firedoor_deficiencies_codename          = HTMLEntities.new.decode params[:firedoor_deficiencies_codename]
      @firedoor_deficiency.firedoor_u_active                       = params[:firedoor_u_active]
      @firedoor_deficiency.firedoor_u_delete                       = params[:firedoor_u_delete]

      @firedoor_deficiency.save
      render json: {message: "Save Success"}
    else
      if params[:fd_insert] == "update"
        @firedoor_deficiency = FiredoorDeficiency.find_by(firedoor_deficiencies_sysid: params[:firedoor_deficiencies_sysid])
        unless @firedoor_deficiency.blank?
          @firedoor_deficiency.update_attributes(:firedoor_service_sysid => params[:firedoor_service_sysid], :firedoor_asset_sysid => params[:firedoor_asset_sysid],
                                                 :firedoor_deficiencies_sysid =>  params[:firedoor_deficiencies_sysid], :firedoor_deficiencies_code => params[:firedoor_deficiencies_code],
                                                 :firedoor_deficiencies_codename => params[:firedoor_deficiencies_codename], :firedoor_u_active => params[:firedoor_u_active],
                                                 :firedoor_u_delete => params[:firedoor_u_delete])

          render json: {message: "Update Success"}
        else
          render json: {message: "Unable to Update the record!"}
        end
      end
    end
  end

  def spreadsheets
    #@outputfile = params[:jobID] + "_" + params[:servicetype] + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "spreadsheet_report"
    @outputfile = params[:servicetype].delete(' ').upcase + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "spreadsheet_report"
    if params[:servicetype].delete(' ').upcase == "DAMPERINSPECTION"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false).where.not(u_type: "")
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Damper Location", "Damper Type", "Status", "Post Repair Status", "Deficiency", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, record.u_location_desc, record.u_type, record.u_status, 
                  if record.u_di_repaired_onsite == "true"
                    record.u_di_passed_post_repair
                  else
                    'Not Repaired'
                  end,
                  if record.u_status == "Fail"
                    record.u_reason
                  else
                    record.u_non_accessible_reasons
                  end,
                  record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')), record.u_inspector
                ]
        end
      end
    elsif params[:servicetype].delete(' ').upcase == "DAMPERREPAIR"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false).where.not(u_type: "")
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Damper Location", "Damper Type", "Post Repair Status", "Action Taken", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, record.u_location_desc, record.u_damper_name, 
                  if record.u_dr_passed_post_repair == "Pass"
                    'Passed Post Repair'
                  else
                    'Failed Post Repair'
                  end,
                  if record.u_repair_action_performed == "Damper Repaired"
                    record.u_repair_action_performed + ":" + record.u_dr_description
                  elsif record.u_repair_action_performed == "Damper Installed"
                    record.u_repair_action_performed + ":" + record.u_dr_damper_model
                  elsif record.u_repair_action_performed == "Actuator Installed"
                    record.u_repair_action_performed + ":" + record.u_dr_installed_actuator_model
                  else
                    record.u_repair_action_performed + ":" + record.u_access_size 
                  end,
                  record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')), record.u_inspector
                ]
        end
      end  
    elsif params[:servicetype].delete(' ').upcase == "FIREDOORINSPECTION"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false)
      csv_data = CSV.generate do |csv|                 
        csv << ["Door No.", "Facility", "Building", "Floor", "Door Location", "Fire Rating", "Door Deficiencies", "Date", "Technician"]
        @records.each do |record|
          @firedoor_deficiency_codes = FiredoorDeficiency.where(:firedoor_service_sysid => record.u_service_id, :firedoor_asset_sysid => record.u_asset_id).collect { |w| w.firedoor_deficiencies_code }.join(", ")
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, record.u_location_desc, record.u_fire_rating, @firedoor_deficiency_codes, record.u_inspected_on.localtime.strftime('%m/%d/%Y'), record.u_inspector]
        end
      end
    elsif params[:servicetype].delete(' ').upcase == "FIRESTOPSURVEY"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false)
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Location", "Barrier Type", "Penetration Type", "Issue", "Corrected On Site", "Suggested Corrective Action", "Corrected with UL System", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, record.u_location_desc, record.u_barrier_type, 
                  record.u_penetration_type, record.u_issue_type,
                  if record.u_service_type == "Fixed On Site"
                    'YES'
                  else
                    'NO'
                  end,
                  record.u_suggested_ul_system, record.u_corrected_url_system, record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')), record.u_inspector
                ]
        end
      end
    elsif params[:servicetype].delete(' ').upcase == "FIRESTOPINSTALLATION"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false)
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Location", "Barrier Type", "Penetration Type", "Issue", "Corrected On Site", "Suggested Corrective Action", "Corrected with UL System", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, record.u_location_desc, record.u_barrier_type, 
                  record.u_penetration_type, record.u_issue_type,
                  if record.u_service_type == "Fixed On Site"
                    'YES'
                  else
                    'NO'
                  end,
                  record.u_suggested_ul_system, record.u_corrected_url_system, record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')), record.u_inspector
                ] 
        end
      end
    else
      @records = Lsspdfasset.where(u_facility_sys_id: params[:facilityid], :u_report_type => "DAMPERINSPECTION", :u_delete => false) + 
                 Lsspdfasset.where(u_facility_sys_id: params[:facilityid], :u_report_type => "DAMPERREPAIR", :u_delete => false)
      csv_data = CSV.generate do |csv|
        csv << ["Date", "Asset #", "Facility", "Building", "Floor", "Damper Location", "Damper Type",  "Service Type", "Technician", "Result", "Issues", "Action Taken", "Current Status"]
        @records.each do |record|
          result_and_current_result = record.comperhensive_result(record)
          csv << [record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')), record.u_tag, record.u_facility_name, record.u_building, record.u_floor.to_i, 
                  record.u_location_desc, record.u_type, record.u_report_type, record.u_inspector, result_and_current_result,
                  if record.u_report_type == "DAMPERINSPECTION"
                    if result_and_current_result == "FAIL"
                      if record.u_reason.delete(' ').upcase == "OTHER"
                        record.u_reason + ":" + record.u_other_failure_reason
                      else
                        record.u_reason
                      end
                    else
                      if record.u_non_accessible_reasons.delete(' ').upcase == "OTHER"
                        record.u_non_accessible_reasons + ":" + record.u_other_nonaccessible_reason
                      else
                        record.u_non_accessible_reasons
                      end
                    end                  
                  end,
                  if record.u_report_type == "DAMPERREPAIR"
                    if record.u_repair_action_performed == "Damper Repaired"
                      record.u_repair_action_performed + ":" + record.u_dr_description
                    elsif record.u_repair_action_performed == "Damper Installed"
                      record.u_repair_action_performed + ":" + record.u_dr_damper_model
                    elsif record.u_repair_action_performed == "Actuator Installed"
                      record.u_repair_action_performed + ":" + record.u_dr_installed_actuator_model
                    else
                      record.u_repair_action_performed + ":" + record.u_access_size 
                    end
                  end, 
                  result_and_current_result
                ]
        end
      end
    end
    send_data csv_data,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=#{@outputfile}.csv"
  end

  def project_completion_save_pdf
    @project_completion = ProjectCompletion.new(project_completion)
    if @project_completion.save

      unless @project_completion.m_authorization_signature_base64.blank?
        @signature = StringIO.open(Base64.decode64(@project_completion.m_authorization_signature_base64))
        @signature.class.class_eval {attr_accessor :original_filename, :content_type}
        @signature.original_filename =  "Authorizationsignature" + "_"  + "#{@project_completion.id}.jpg"
        @signature.content_type = "image/jpeg"
        @project_completion.m_authorization_signature = @signature
      end

      unless @project_completion.m_technician_signature_base64.blank?
        @technician_signature = StringIO.open(Base64.decode64(@project_completion.m_technician_signature_base64))
        @technician_signature.class.class_eval {attr_accessor :original_filename, :content_type}
        @technician_signature.original_filename =  "Authorizationsignature" + "_"  + "#{@project_completion.id}.jpg"
        @technician_signature.content_type = "image/jpeg"
        @project_completion.m_technician_signature = @technician_signature
      end

      #@project_completion.m_date               =  Time.now.utc
      #@project_completion.m_project_start_date =  Time.now.utc

      @project_completion.m_facility = HTMLEntities.new.decode params[:m_facility]      
      @project_completion.m_building = HTMLEntities.new.decode params[:m_building]
      @project_completion.m_servicetype = HTMLEntities.new.decode params[:m_servicetype]
      @project_completion.m_primary_contact_name = HTMLEntities.new.decode params[:m_primary_contact_name]
      @project_completion.m_customer_name = HTMLEntities.new.decode params[:m_customer_name]

      @project_completion.save
      render json: {message: "Save Success"}

      ProjectCompletionReportGeneration.new(@project_completion).generate_projectcompletion_report

      require 'base64'
      require 'json'
      require 'rest_client'
      #url = 'https://dev18567.service-now.com/api/x_68827_lss/project_completion_pdfreport_mobile'
      url =  @project_completion.m_instance_url + '/api/x_68827_lss/project_completion_pdfreport_mobile'
      #Rails.logger.debug("URL: #{url}")
      request_body_map = {
        "sys_id" => "#{@project_completion.m_service_sysid}",
        "project_completion_timestamp" => "#{@project_completion.m_date.strftime("%m-%d-%Y-%I-%M-%p")}",
        "pdf_url" => "ec2-54-165-215-71.compute-1.amazonaws.com/api/download_project_completion_pdf_report?service_sysid=#{@project_completion.id}",
      }.to_json
      
      begin
        response = RestClient.post("#{url}", "#{request_body_map}",
                              {:content_type => 'application/json',
                               :accept => 'application/json'
                              })
        puts "#{response.to_str}"
        puts "Response status: #{response.code}"
        response.headers.each { |k,v|
          puts "Header: #{k}=#{v}"
        }
      rescue => e
         puts "ERROR: #{e}"
      end
    else
      render json: {message: "Unable to Save the record!"}
    end
  end

  def download_project_completion_pdf_report
    #@project_completion = ProjectCompletion.where(m_service_sysid: params[:service_sysid]).last
    @length = params[:service_sysid].length
    if @length == 32
      #Rails.logger.debug("Equal to 32")
      @project_completion = ProjectCompletion.where(m_service_sysid: params[:service_sysid]).order(:m_date).offset(1).last
    else
      #Rails.logger.debug("Not Equal to 32")
      @project_completion = ProjectCompletion.find(params[:service_sysid])
    end

    #@outputfile = @project_completion.m_job_id + "_" + @project_completion.m_servicetype.delete(' ').upcase + "_" + Time.now.strftime("%m-%d-%Y-%I-%M-%p").gsub(/\s+/, "_") + "_" + "project_completion_report"
    @outputfile = @project_completion.m_job_id + "_" + @project_completion.m_servicetype.delete(' ').upcase + "_" + @project_completion.m_date.strftime("%m-%d-%Y-%I-%M-%p").gsub(/\s+/, "_") + "_" + "project_completion_report"
    #send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""    
    send_file @project_completion.project_completion_full_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
  end

  private

  def lssassets_job
    params.require(:api).permit(:u_job_id, :u_asset_id, :u_service_id, :u_location_desc, :u_status, :u_type, :u_floor,
      :u_tag, :u_image1, :u_image2, :u_image3, :u_image4, :u_image5, :u_job_start_date, :u_job_end_date, :u_job_scale_rep,
      :u_building, :u_reason, :u_access_size, :u_inspected_on, :u_inspector, :u_group_name, :u_facility_name, :u_damper_name,
      :u_non_accessible_reasons, :u_penetration_type, :u_barrier_type, :u_service_type, :u_issue_type,
      :u_corrected_url_system, :u_active, :u_delete, :u_suggested_ul_system, :u_repair_action_performed, :u_door_category,
      :u_fire_rating, :u_door_inspection_result, :u_door_type, :u_report_type, :pdf_image1, :pdf_image2, :pdf_image3, :pdf_image4,
      :u_dr_passed_post_repair, :u_dr_description, :u_dr_damper_model, :u_dr_installed_damper_type, :u_dr_installed_damper_height,
      :u_dr_installed_damper_width, :u_dr_installed_actuator_model, :u_dr_installed_actuator_type, :u_dr_actuator_voltage, :u_di_replace_damper, 
      :u_di_installed_access_door, :u_other_failure_reason, :u_other_nonaccessible_reason, :u_facility_sys_id, :u_other_floor, 
      :u_di_repaired_onsite, :u_di_passed_post_repair)
  end


  def project_completion
    params.require(:api).permit(:m_job_id, :m_service_sysid, :m_date, :m_facility, :m_building, :m_servicetype, :m_project_start_date,
                                :m_primary_contact_name, :m_phone, :m_printed_report, :m_autocad, :m_total_no_of_dampers_inspected,
                                :m_total_no_of_dampers_failed, :m_total_no_of_dampers_passed, :m_total_no_of_dampers_na,
                                :m_total_no_of_damper_access_door_installed, :m_total_no_of_dampers_repaired, :m_total_no_of_dampersrepaired,
                                :m_total_no_of_dr_access_door_installed, :m_total_no_of_dr_actuator_installed, :m_total_no_of_dr_damper_installed,
                                :m_total_no_of_firedoor_inspected, :m_total_no_of_firedoor_conformed, :m_total_no_of_firedoor_nonconformed,
                                :m_total_no_of_firestop_surveyed, :m_total_no_of_firestop_fixedonsite, :m_total_no_of_fsi_surveyed,
                                :m_total_no_of_fsi_fixedonsite, :m_containment_tent_used, :m_base_bid_count, :m_new_total_authorized_damper_bid,
                                :m_technician_name, :m_blueprints_facility, :m_replacement_checklist, :m_facility_items, :m_emailed_reports, :m_daily_basis,
                                :m_authorization_signature_base64, :m_authorization_signature, :m_instance_url, :m_customer_name, :m_total_firestop_assets, 
                                :m_technician_signature_base64, :m_technician_signature, :m_total_no_of_ceiling_hatches_installed)
  end
end
