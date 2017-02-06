module DamperRepairReport
  class ProjectSummaryPage
    include Report::RepairDataPageWritable

    def initialize(job)
      @job = job
    end

    def write(pdf)
      super
      Report::ProjectSummary.new(@job).draw(pdf)
    end
  end
end