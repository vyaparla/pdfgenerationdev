class ReportGeneration
  
  require 'pdfjob'
  require  'damper_inspection_job'


  def initialize(owner, model_name, address, facility_type, tech)
    # @group_name = group_name
    # @facility_name = facility_name
    # @group_url = group_url
    # @facility_url = facility_url
    # @nfpa_url = nfpa_url
    @owner = owner
    @model_name = model_name
    @address = address
    @facility_type = facility_type
    @tech = tech
  end

  def generate_full_report
    try_create_full_report
  end

  def generate_summary_report
    reporter.summary_report(@owner, @model_name, @address, @tech)
  end

  private

  def create_full_report
    #reporter.report(@owner)
    reporter.report(@owner, @model_name, @address, @facility_type, @tech)
  end

  def reporter
    #@owner.class.reporter_class.new
    #Pdfjob.reporter_class.new
    if @model_name == "DAMPERINSPECTION"
      DamperInspectionJob.reporter_class.new
    elsif @model_name == "DAMPERREPAIR"
      DamperRepairJob.reporter_class.new
    elsif @model_name == "FIREDOORINSPECTION"
      DoorInspectionJob.reporter_class.new
    elsif @model_name == "FIRESTOPINSTALLATION"
      FirestopInstallationJob.reporter_class.new
    elsif @model_name == "FIRESTOPSURVEY"
      FirestopSurveyJob.reporter_class.new
    end
  end

  def try_create_full_report
    begin
      create_full_report
    rescue => error
      Rails.logger.debug("Error Class :#{error.class.name.inspect}")
      Rails.logger.debug("Error Message :#{error.message.inspect}")
    end
  end
end