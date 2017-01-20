class ApiController < ApplicationController
  
  def save_pdf
  	@pdfjob = Pdfjob.new(pdfjob_params)
  	@pdfjob.save
  	render json: {message: "Success"}
  end

  private

  def pdfjob_params
    params.require(:api).permit(:sys_id, :u_job_id, :u_pdf_number, :u_openimage_base64code, :u_close_image_base64code)
  end
end