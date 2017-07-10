class ApiController < ApplicationController
  
  # def save_pdf
  #   if params[:status] == "insert"
  #     @pdfjob = Pdfjob.new(pdfjob_params)
  # 	  @pdfjob.save
  # 	  render json: {message: "Save Success"}
  #   else
  #     if params[:status] == "update"
  #     	@pdfjob = Pdfjob.find_by(sys_id: params[:sys_id])
  #     	if @pdfjob.update(pdfjob_params)
  #     	  render json: {message: "Update Success"}
  #     	else
  #     	  render json: {message: "Unable to Update the record!"}
  #       end
  #     else
  #     	@pdfjob = Pdfjob.find_by(sys_id: params[:sys_id])
  #     	@pdfjob.destroy
  #     	render json: {message: "Delete Success"}
  #     end
  #   end
  # end

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

          render json: {message: "Update Success"}
        else
          render json: {message: "Unable to Update the record!"}
        end

        # unless @pdfjob.blank?

        #   if @pdfjob.update(lssassets_job)
        #     unless @pdfjob.u_image1.blank?
        #       @pdf_image1 = StringIO.open(Base64.decode64(@pdfjob.u_image1))
        #       @pdf_image1.class.class_eval { attr_accessor :original_filename, :content_type }
        #       @pdf_image1.original_filename = "#{params[:image_file_name1]}.jpg"
        #       @pdf_image1.content_type = "image/jpeg"
        #       @pdfjob.update_attribute(:pdf_image1, @pdf_image1)
        #     end

        #     unless @pdfjob.u_image2.blank?
        #       @pdf_image2 = StringIO.open(Base64.decode64(@pdfjob.u_image2))
        #       @pdf_image2.class.class_eval { attr_accessor :original_filename, :content_type }
        #       @pdf_image2.original_filename = "#{params[:image_file_name2]}.jpg"
        #       @pdf_image2.content_type = "image/jpeg"
        #       @pdfjob.update_attribute(:pdf_image2, @pdf_image2)
        #     end
      
        #     unless @pdfjob.u_image3.blank?
        #       @pdf_image3 = StringIO.open(Base64.decode64(@pdfjob.u_image3))
        #       @pdf_image3.class.class_eval { attr_accessor :original_filename, :content_type }
        #       @pdf_image3.original_filename = "#{params[:image_file_name3]}.jpg"
        #       @pdf_image3.content_type = "image/jpeg"
        #       @pdfjob.update_attribute(:pdf_image3, @pdf_image3)
        #     end

        #     unless @pdfjob.u_image4.blank?
        #       @pdf_image4 = StringIO.open(Base64.decode64(@pdfjob.u_image4))
        #       @pdf_image4.class.class_eval { attr_accessor :original_filename, :content_type }
        #       @pdf_image4.original_filename = "#{params[:image_file_name4]}.jpg"
        #       @pdf_image4.content_type = "image/jpeg"
        #       @pdfjob.update_attribute(:pdf_image4, @pdf_image4)
        #     end
        #     render json: {message: "Update Success"}
        #   else
        #     render json: {message: "Unable to Update the record!"}
        #   end

        # else
          
        #   @pdfjob = Lsspdfasset.new(lssassets_job)
        #   @pdfjob.save
      
        #   unless @pdfjob.u_image1.blank?
        #     @pdf_image1 = StringIO.open(Base64.decode64(@pdfjob.u_image1))
        #     @pdf_image1.class.class_eval { attr_accessor :original_filename, :content_type }
        #     @pdf_image1.original_filename = "#{params[:image_file_name1]}.jpg"
        #     @pdf_image1.content_type = "image/jpeg"
        #     @pdfjob.pdf_image1 = @pdf_image1
        #   end

        #   unless @pdfjob.u_image2.blank?
        #     @pdf_image2 = StringIO.open(Base64.decode64(@pdfjob.u_image2))
        #     @pdf_image2.class.class_eval { attr_accessor :original_filename, :content_type }
        #     @pdf_image2.original_filename = "#{params[:image_file_name2]}.jpg"
        #     @pdf_image2.content_type = "image/jpeg"
        #     @pdfjob.pdf_image2 = @pdf_image2
        #   end
      
        #   unless @pdfjob.u_image3.blank?
        #     @pdf_image3 = StringIO.open(Base64.decode64(@pdfjob.u_image3))
        #     @pdf_image3.class.class_eval { attr_accessor :original_filename, :content_type }
        #     @pdf_image3.original_filename = "#{params[:image_file_name3]}.jpg"
        #     @pdf_image3.content_type = "image/jpeg"
        #     @pdfjob.pdf_image3 = @pdf_image3
        #   end

        #   unless @pdfjob.u_image4.blank?
        #     @pdf_image4 = StringIO.open(Base64.decode64(@pdfjob.u_image4))
        #     @pdf_image4.class.class_eval { attr_accessor :original_filename, :content_type }
        #     @pdf_image4.original_filename = "#{params[:image_file_name4]}.jpg"
        #     @pdf_image4.content_type = "image/jpeg"
        #     @pdfjob.pdf_image4 = @pdf_image4
        #   end
      
        #   @pdfjob.save
        #   render json: {message: "Save Success"}
        # end
      else
        @pdfjob = Lsspdfasset.find_by(u_asset_id: params[:u_asset_id])
        @pdfjob.destroy
        render json: {message: "Delete Success"}
      end
    end
  end

  # def update_pdf
  # 	@pdfjob = Pdfjob.find(params[:sys_id])
  # 	if @pdfjob.update(pdfjob_params)
  # 	  render json: {message: "Success"}
  #   else
  #     render json: {message: "Unable to Update the record!"}
  #   end
  # end

  def pdf_generation
    # @group_name    = params[:groupname]
    # @facility_name = params[:facilityname]
    # @group_url     = params[:groupurl]
    # @facility_url  = params[:facilityurl]
    # @nfpa_url      = params[:nfpaurl]
    #@serviceID     = params[:serviceID]
    @model_name    = params[:service].delete(' ').upcase + params[:type].upcase
    @address       = params[:address]
    @facility_type = params[:facilitytype]
    @tech          = params[:tech]
  
  	@pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).first
    unless @pdfjob.blank?
      #ReportGeneration.new(@pdfjob, @group_name, @facility_name, @group_url, @facility_url).generate_full_report
      ReportGeneration.new(@pdfjob, @model_name, @address, @facility_type, @tech).generate_full_report
  	  render json: {message: "Success"}
    else
      render json: {message: "Unsuccess"}
    end
  end

  def download_full_pdf_report
    @pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).first
    @outputfile = @pdfjob.u_job_id + "_" + params[:servicetype] + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "detail_report"
    send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
    
    # @pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID], :u_delete => false).first
    # if @pdfjob.has_full_report?
    #   @outputfile = @pdfjob.u_job_id + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "full_report"
    #   send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
    # else
    #   render json: {message: "The PDF yet not generated to download the full pdf report"}
    # end
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
      @firedoor_deficiency.firedoor_deficiencies_code              = params[:firedoor_deficiencies_code]
      @firedoor_deficiency.firedoor_deficiencies_codename          = params[:firedoor_deficiencies_codename]
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
    @outputfile = params[:jobID] + "_" + params[:servicetype] + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "spreadsheet_report"
    if params[:servicetype].delete(' ').upcase == "DAMPERINSPECTION"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false).where.not(u_type: "")
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Damper Location", "Damper Type", "Status", "Deficiency", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor, record.u_location_desc, record.u_type, record.u_status, 
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
        csv << ["Asset #", "Facility", "Building", "Floor", "Damper Location", "Damper Type", "Status", "Action Taken", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor, record.u_location_desc, record.u_damper_name, record.u_dr_passed_post_repair,
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
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor, record.u_location_desc, record.u_fire_rating, @firedoor_deficiency_codes, record.u_inspected_on.localtime.strftime('%m/%d/%Y'), record.u_inspector]
        end
      end
    elsif params[:servicetype].delete(' ').upcase == "FIRESTOPSURVEY"
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false)
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Location", "Barrier Type", "Penetration Type", "Issue", "Corrected On Site", "Suggested Corrective Action", "Corrected with UL System", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor, record.u_location_desc, record.u_barrier_type, 
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
      @records = Lsspdfasset.where(u_service_id: params[:serviceid], :u_delete => false)
      csv_data = CSV.generate do |csv|
        csv << ["Asset #", "Facility", "Building", "Floor", "Location", "Barrier Type", "Penetration Type", "Issue", "Corrected On Site", "Suggested Corrective Action", "Corrected with UL System", "Date", "Technician"]
        @records.each do |record|
          csv << [record.u_tag, record.u_facility_name, record.u_building, record.u_floor, record.u_location_desc, record.u_barrier_type, 
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

      # @project_completion.m_date               =  Time.now.utc
      # @project_completion.m_project_start_date =  Time.now.utc

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
        "pdf_url" => "ec2-54-165-215-71.compute-1.amazonaws.com/api/download_project_completion_pdf_report?service_sysid=#{@project_completion.m_service_sysid}",
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
    @project_completion = ProjectCompletion.where(m_service_sysid: params[:service_sysid]).last
    @outputfile = @project_completion.m_job_id + "_" + @project_completion.m_servicetype.delete(' ').upcase + "_" + Time.now.localtime.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "project_completion_report"
    #send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""    
    send_file @project_completion.project_completion_full_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
  end

  private

  # def pdfjob_params
  #   params.require(:api).permit(:sys_id, :u_job_id, :u_pdf_number, :u_openimage_base64code, :u_close_image_base64code)
  # end

  def lssassets_job
    params.require(:api).permit(:u_job_id, :u_asset_id, :u_service_id, :u_location_desc, :u_status, :u_type, :u_floor,
      :u_tag, :u_image1, :u_image2, :u_image3, :u_image4, :u_image5, :u_job_start_date, :u_job_end_date, :u_job_scale_rep,
      :u_building, :u_reason, :u_access_size, :u_inspected_on, :u_inspector, :u_group_name, :u_facility_name, :u_damper_name,
      :u_non_accessible_reasons, :u_penetration_type, :u_barrier_type, :u_service_type, :u_issue_type,
      :u_corrected_url_system, :u_active, :u_delete, :u_suggested_ul_system, :u_repair_action_performed, :u_door_category,
      :u_fire_rating, :u_door_inspection_result, :u_door_type, :u_report_type, :pdf_image1, :pdf_image2, :pdf_image3, :pdf_image4,
      :u_dr_passed_post_repair, :u_dr_description, :u_dr_damper_model, :u_dr_installed_damper_type, :u_dr_installed_damper_height,
      :u_dr_installed_damper_width, :u_dr_installed_actuator_model, :u_dr_installed_actuator_type, :u_dr_actuator_voltage, :u_di_replace_damper, 
      :u_di_installed_access_door, :u_other_failure_reason, :u_other_nonaccessible_reason)
  end


  def project_completion
    params.require(:api).permit(:m_job_id, :m_service_sysid, :m_date, :m_facility, :m_building, :m_servicetype, :m_project_start_date,
                                :m_primary_contact_name, :m_phone, :m_printed_report, :m_autocad, :m_total_no_of_dampers_inspected,
                                :m_total_no_of_dampers_passed, :m_total_no_of_dampers_na, :m_total_no_of_damper_access_door_installed, 
                                :m_total_no_of_dampers_repaired, :m_total_no_of_dr_access_door_installed, :m_total_no_of_dr_actuator_installed,
                                :m_total_no_of_dr_damper_installed, :m_total_no_of_firedoor_inspected, :m_total_no_of_firedoor_conformed,
                                :m_total_no_of_firedoor_nonconformed, :m_total_no_of_firestop_surveyed, :m_total_no_of_firestop_fixedonsite,
                                :m_total_no_of_fsi_surveyed, :m_total_no_of_fsi_fixedonsite, :m_containment_tent_used, :m_base_bid_count,
                                :m_new_total_authorized_damper_bid, :m_technician_name, :m_blueprints_facility, :m_replacement_checklist,
                                :m_facility_items, :m_emailed_reports, :m_daily_basis, :m_authorization_signature_base64, :m_authorization_signature, 
                                :m_instance_url)
  end
end
