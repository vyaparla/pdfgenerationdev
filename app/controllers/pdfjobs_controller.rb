class PdfjobsController < ApplicationController
  
  before_action :authenticate_user!

  def index
  	@damper_inspection = Lsspdfasset.where(:u_delete => false, :u_report_type => "DAMPERINSPECTION").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
  	@damper_inspection_count = Lsspdfasset.where(:u_delete => false, :u_report_type => "DAMPERINSPECTION").count
    $pdfjobs_count = Lsspdfasset.all.where(:u_delete => false).count
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

  def damper_repair
    @damper_repair = Lsspdfasset.where(:u_delete => false, :u_report_type => "DAMPERREPAIR").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @damper_repair_count = Lsspdfasset.where(:u_delete => false, :u_report_type => "DAMPERREPAIR").count
  end

  def firedoor_inspection
    @firedoor_inspection = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIREDOORINSPECTION").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @firedoor_inspection_count = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIREDOORINSPECTION").count
  end

  def firestop_survey
    @firestop_survey = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIRESTOPSURVEY").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @firestop_survey_count = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIRESTOPSURVEY").count
  end

  def firestop_installation
    @firestop_installation = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIRESTOPINSTALLATION").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @firestop_installation_count = Lsspdfasset.where(:u_delete => false, :u_report_type => "FIRESTOPINSTALLATION").count
  end

  def firedoor_deficiency
    @firedoor_deficiency = FiredoorDeficiency.all.where(:firedoor_u_delete => false).order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @firedoor_deficiency_count = FiredoorDeficiency.all.where(:firedoor_u_delete => false).count
  end
end