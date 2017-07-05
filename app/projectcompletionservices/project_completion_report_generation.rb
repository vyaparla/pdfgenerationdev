class ProjectCompletionReportGeneration

  def initialize(project)
    @project =  project
  end

  def generate_projectcompletion_report    
    try_create_projectcompletion_full_report
  end

  private

  def create_projectcompletion_full_report
  	completionreporter.report(@project)
  end

  def completionreporter
    if @project.m_servicetype == "Damper Inspection"
      DamperInspectionJob.projectcompletion_reporter_class.new
    elsif @project.m_servicetype == "Damper Repair"
      DamperRepairJob.projectcompletion_reporter_class.new
    elsif @project.m_servicetype == "Firedoor Inspection"
      DoorInspectionJob.projectcompletion_reporter_class.new
    elsif @project.m_servicetype == "Firestop Survey"
      FirestopSurveyJob.projectcompletion_reporter_class.new
    else
      FirestopInstallationJob.projectcompletion_reporter_class.new
    end
  end

  def try_create_projectcompletion_full_report
  	begin
      create_projectcompletion_full_report
    rescue => error
      Rails.logger.debug("Error Class :#{error.class.name.inspect}")
      Rails.logger.debug("Error Message :#{error.message.inspect}")
    end
  end  

end