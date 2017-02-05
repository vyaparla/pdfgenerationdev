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
      render json: {message: "Save Success"}
    else
      if params[:status] == "update"
        @pdfjob = Lsspdfasset.find_by(u_asset_id: params[:u_asset_id])
        if @pdfjob.update(lssassets_job)
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
  
  	@pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID]).first
    unless @pdfjob.blank?
      #ReportGeneration.new(@pdfjob, @group_name, @facility_name, @group_url, @facility_url).generate_full_report
      ReportGeneration.new(@pdfjob, @model_name, @address, @facility_type).generate_full_report
  	  render json: {message: "Success"}
    else
      render json: {message: "Unsuccess"}
    end
  end

  def download_full_pdf_report
    @pdfjob = Lsspdfasset.where(u_service_id: params[:serviceID]).first
    if @pdfjob.has_full_report?
      @outputfile = @pdfjob.u_job_id + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "full_report"
      send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
    else
      render json: {message: "The PDF yet not generated to download the full pdf report"}
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
      :u_corrected_url_system, :u_active, :u_delete, :u_suggested_ul_system)
  end
end
