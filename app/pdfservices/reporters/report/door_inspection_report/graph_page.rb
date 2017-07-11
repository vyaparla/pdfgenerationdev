module DoorInspectionReport
  class GraphPage
    include Report::InspectionDataPageWritable

  	def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      Report::DoorGraphs.new(@job).draw(pdf)
    end
  end
end