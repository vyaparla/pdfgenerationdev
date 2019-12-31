class ReportGeneration
  
  require 'pdfjob'
  require 'damper_inspection_job'


  def initialize(owner, model_name, address1, address2, csz, facility_type, tech, group_name, facility_name, facility_id=nil, service=nil, report_type=nil, with_picture)
    @owner = owner    
    @model_name = model_name
    @address1 = address1
    @address2 = address2
    @csz = csz
    @facility_type = facility_type
    @tech = tech
    @group_name = group_name
    @facility_name = facility_name
    @facility_id = facility_id
    @with_picture = with_picture
    @service = service
    @report_type = report_type
  end

  def generate_full_report
    try_create_full_report
  end

  def generate_summary_report
    reporter.summary_report(@owner, @model_name, @address1, @address2, @csz, @tech, @group_name, @facility_name)
  end

  def generate_report_facility_wise
    if @service.upcase == "FIRESTOP"	  
       FirestopComprehensiveJob.reporter_class.new.comprehensive_report(@owner, @model_name, @address1, @address2, @csz, @facility_type,
      @tech, @group_name, @facility_name, @facility_id, @with_picture)
    else
    end   
  end	  

  private

  def create_full_report
    #reporter.report(@owner)
    reporter.report(@owner, @model_name, @address1, @address2, @csz, @facility_type, 
      @tech, @group_name, @facility_name, @with_picture)
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
    #begin
      create_full_report
  end
end
