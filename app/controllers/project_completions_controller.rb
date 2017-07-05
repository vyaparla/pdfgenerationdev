class ProjectCompletionsController < ApplicationController
  
  before_action :authenticate_user!


  # Mobile Project Completion Damaper Inspection
  def index
    @mpc_di = ProjectCompletion.where(:m_servicetype => "Damper Inspection").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @mpc_di_count = ProjectCompletion.all.where(:m_servicetype => "Damper Inspection").count
  end

  # Mobile Project Completion Damaper Inspection
  def mpc_damperrepair
    @mpc_dr = ProjectCompletion.where(:m_servicetype => "Damper Repair").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @mpc_dr_count = ProjectCompletion.all.where(:m_servicetype => "Damper Repair").count
  end

  # Mobile Project Completion Damaper Inspection
  def mpc_firedoorinspection
    @mpc_fdi = ProjectCompletion.where(:m_servicetype => "Firedoor Inspection").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @mpc_fdi_count = ProjectCompletion.all.where(:m_servicetype => "Firedoor Inspection").count
  end

  # Mobile Project Completion Damaper Inspection
  def mpc_firestopsurvey
    @mpc_fss = ProjectCompletion.where(:m_servicetype => "Firestop Survey").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @mpc_fss_count = ProjectCompletion.all.where(:m_servicetype => "Firestop Survey").count
  end

  # Mobile Project Completion Damaper Inspection
  def mpc_firestopinstallation
    @mpc_fsi = ProjectCompletion.where(:m_servicetype => "Firestop Installation").order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    @mpc_fsi_count = ProjectCompletion.all.where(:m_servicetype => "Firestop Installation").count
  end

  def destroy
  	@project_completion = ProjectCompletion.find(params[:id])
    @project_completion.delete
    redirect_to project_completions_path
  end

end
