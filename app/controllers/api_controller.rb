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
    @outputfile = @pdfjob.u_job_id + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "full_report"
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
    @outputfile = @pdfjob.u_job_id + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "summary_report"
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
      :u_fire_rating, :u_door_inspection_result, :u_door_type, :u_report_type, :pdf_image1, :pdf_image2, :pdf_image3, :pdf_image4)
  end
end
