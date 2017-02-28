module DamperInspectionReport
  class GraphPage
  	include Report::InspectionDataPageWritable

    def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      Report::DamperGraphs.new(@job).draw(pdf)
    end
  end
end