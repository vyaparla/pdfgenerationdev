module DamperInspectionReport
  class GraphPage
  	include Report::InspectionDataPageWritable

    def initialize(job, tech, watermark)
      @job = job
      @tech = tech
      @watermark = watermark
    end

    def write(pdf)
      super
      Report::DamperGraphs.new(@job).draw(pdf)
      pdf.stamp_at "watermark", [100, 210] if @watermark 
    end
  end
end
