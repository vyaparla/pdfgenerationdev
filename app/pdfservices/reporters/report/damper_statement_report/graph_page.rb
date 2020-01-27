module DamperStatementReport
  class GraphPage
    include Report::RepairDataPageWritable

    def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      Report::RepairGraphs.new(@job).draw(pdf)
    end
  end
end