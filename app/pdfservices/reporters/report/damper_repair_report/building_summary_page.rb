module DamperRepairReport
  class BuildingSummaryPage
  	include Report::RepairDataPageWritable

    def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
    end

    def write(pdf)
      super
      Report::RepairBuildingSummary.new(@job, @building).draw(pdf)
    end
    
  private

    def building
      @building
    end
  end
end