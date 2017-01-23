class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Pdfjob.all
  	@pdfjobs_count = Pdfjob.count
  end

  def destroy
  	@pdfjob = Pdfjob.find(params[:id])
    @pdfjob.delete
    redirect_to root_path
  end

end