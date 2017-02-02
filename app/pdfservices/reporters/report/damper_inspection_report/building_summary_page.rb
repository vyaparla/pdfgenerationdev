module DamperInspectionReport
  class BuildingSummaryPage
  	include Report::InspectionDataPageWritable

    def initialize(job, building)
      @job = job
      @building = building
      #Rails.logger.debug("BuildingSummary : #{@building.inspect}")
    end

    def write(pdf)
      super
      Report::BuildingSummary.new(@job, @building).draw(pdf)
    end

  private

    def building
      @building
    end
  end
end