class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Pdfjob.all
  end

  def destroy
  	@pdfjob = Pdfjob.find(params[:id])
    @pdfjob.destroy
    redirect_to root_path
  end

end