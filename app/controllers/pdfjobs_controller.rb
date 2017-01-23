class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Pdfjob.all
  end

  def show
  end

  def destroy
  	@pdfjob = Pdfjob.find(params[:id])
    @pdfjob.delete
    redirect_to root_path
  end

end