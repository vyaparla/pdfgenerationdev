module DamperComprehensiveReport
    class ProjectSummaryPage
    include Report::InspectionDataPageWritable

    def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      Report::DamperComprehensiveProjectSummary.new(@job).draw(pdf)
    end
  end
end