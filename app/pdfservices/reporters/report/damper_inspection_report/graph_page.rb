module DamperInspectionReport
  class GraphPage
  	include Report::InspectionDataPageWritable

    def initialize(job)
      @job = job
    end

    def write(pdf)
      super
      Report::DamperGraphs.new(@job).draw(pdf)
    end
  end
end