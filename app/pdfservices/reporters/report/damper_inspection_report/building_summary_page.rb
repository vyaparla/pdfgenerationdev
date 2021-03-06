module DamperInspectionReport
  class BuildingSummaryPage
  	include Report::InspectionDataPageWritable

    def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
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