module DamperInspectionReport
  class ProjectSummaryPage
  	include Report::InspectionDataPageWritable

    def initialize(job)
      @job = job
    end

    def write(pdf)
      super
      Report::ProjectSummary.new(@job).draw(pdf)
    end
  end
end