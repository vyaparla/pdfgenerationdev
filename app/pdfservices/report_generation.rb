class ReportGeneration
  
  require 'pdfjob'

  def initialize(owner)
  	@owner = owner
  end

  def generate_full_report
    try_create_full_report
  end

  private

  def create_full_report
    reporter.report(@owner)
  end

  def reporter
    @owner.class.reporter_class.new
    #Pdfjob.reporter_class.new
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