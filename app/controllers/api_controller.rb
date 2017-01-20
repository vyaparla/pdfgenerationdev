class ApiController < ApplicationController
  
  def save_pdf
    if params[:status] == "insert"
      @pdfjob = Pdfjob.new(pdfjob_params)
  	  @pdfjob.save
  	  render json: {message: "Save Success"}
    else
      if params[:status] == "update"
      	@pdfjob = Pdfjob.find_by(sys_id: params[:sys_id])
      	if @pdfjob.update(pdfjob_params)
      	  render json: {message: "Update Success"}
      	else
      	  render json: {message: "Unable to Update the record!"}
        end
      else
      	@pdfjob = Pdfjob.find_by(sys_id: params[:sys_id])
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

  private

  def pdfjob_params
    params.require(:api).permit(:sys_id, :u_job_id, :u_pdf_number, :u_openimage_base64code, :u_close_image_base64code)
  end
end