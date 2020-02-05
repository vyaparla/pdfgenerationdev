module DamperComprehensiveReport
    class ProjectSummaryPage
    include Report::ComprehensiveDataPageWritable

    def initialize(job, tech, report_type)
      @job = job
      @tech = tech
      @report_type = report_type
    end

    def write(pdf)
      super
      Report::DamperComprehensiveProjectSummary.new(@job).draw(pdf)
    end
  end
end