module DamperRepairReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if records.empty?
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      BuildingSummaryPage.new(@job, @building, @tech, @watermark).write(pdf)
      write_breakdown_pages(pdf, building_section, @tech, @watermark)
      @records = records.where.not(u_type: "").order('u_updated_date desc')
      @records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture, @watermark).write(pdf)}
    end

  private

    def pass_records
      @pass_records ||= records.where(:u_dr_passed_post_repair => "Pass").where.not(u_type: "").order('u_updated_date desc')
    end

    def failed_records
      @failed_records ||= records.where(:u_dr_passed_post_repair => "Fail").where.not(u_type: "").order('u_updated_date desc')
    end

    def write_breakdown_pages(pdf, building_section, tech, watermark)
      TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech, watermark).write(pdf)
    end
  end
end
