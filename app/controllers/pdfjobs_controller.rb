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

  def generate_full_pdf_report
    @pdfjob = Pdfjob.find(params[:id])
    unless @pdfjob.blank?
      ReportGeneration.new(@pdfjob).generate_full_report
      flash[:success] = "Successfull to generate the Full PDF Report"
    else
      flash[:success] = "Unsuccessfull to generate the Full PDF Report"
    end
    redirect_to root_path
  end

  def download_full_pdf_report
  	@pdfjob = Pdfjob.find(params[:id])
  	@outputfile = @pdfjob.u_job_id + "_" + Time.now.strftime("%m-%d-%Y-%r").gsub(/\s+/, "_") + "_" + "full_report"
    send_file @pdfjob.full_report_path, :type => 'application/pdf', :disposition =>  "attachment; filename=\"#{@outputfile}.pdf\""
  end

end