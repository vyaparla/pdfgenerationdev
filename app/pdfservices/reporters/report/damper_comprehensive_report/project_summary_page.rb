module DamperComprehensiveReport
    class ProjectSummaryPage
    include Report::ComprehensiveDataPageWritable

    def initialize(job, tech, report_type, watermark)
      @job = job
      @tech = tech
      @report_type = report_type
      @watermark = watermark
    end

    def write(pdf)
      super
      pdf.stamp_at "watermark", [100, 210]  if @watermark
      Report::DamperComprehensiveProjectSummary.new(@job).draw(pdf)
    end
  end
end