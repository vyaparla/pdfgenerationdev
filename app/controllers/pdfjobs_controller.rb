class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Pdfjob.all
  end

end
