class ApiController < ApplicationController
  
  def save_pdf
  	render json: {message: "Success"}
  end
end