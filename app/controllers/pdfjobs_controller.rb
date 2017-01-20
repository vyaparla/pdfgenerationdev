class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Pdfjob.all
  end

  def destroy
  	@pdfjob = Pdfjob.find_by(sys_id: params[:sys_id])
    @pdfjob.destroy
    redirect_to root_path
  end

end