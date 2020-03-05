module DamperStatementReport
  class GraphPage
    include Report::ComprehensiveDataPageWritable

    def initialize(job, tech, report_type, watermark)
      @job = job
      @tech = tech
      @report_type = report_type
      @watermark = watermark
    end

    def write(pdf)
      super
      
       pdf.stamp_at "watermark", [100, 210] if @watermark
      Report::DamperStatementGraph.new(@job).draw(pdf)
      pdf.stamp_at "watermark", [100, 210] if @watermark
    end
  end
end