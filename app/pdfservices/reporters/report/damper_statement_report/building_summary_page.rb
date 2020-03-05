module DamperStatementReport
  class BuildingSummaryPage
  	include Report::RepairDataPageWritable

    def initialize(job, building, tech, watermark)
      @job = job
      @building = building
      @tech = tech
      @watermark = watermark
    end

    def write(pdf)
      super
       pdf.stamp_at "watermark", [100, 210] if @watermark
       DamperStatementBuildingSummary.new(@job, @building).draw(pdf)
    end
    
  private

    def building
      @building
    end
  end
end
