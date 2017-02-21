class PdfjobsController < ApplicationController

  def index
  	@pdfjobs = Lsspdfasset.all.where(:u_delete => false).order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
  	@pdfjobs_count = Lsspdfasset.where(:u_delete => false).count
  end

  def destroy
  	@pdfjob = Lsspdfasset.find(params[:id])
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

  def clear_index_list_view
    @pdfjobs = Lsspdfasset.all
    # @pdfjobs.each do |job|
    #   job.delete
    # end
    @pdfjobs.destroy_all

    redirect_to root_path
  end

end