module DamperInspectionReport
  class BuildingSection
  	include Report::SectionWritable
    
    def write(pdf)
      return if records.empty?
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      BuildingSummaryPage.new(@job, @building, @tech, @watermark).write(pdf)
      write_breakdown_pages(pdf, building_section, @tech, @watermark)
      @records = records.where.not(u_type: "")
      @records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture, @watermark).write(pdf)}
    end

  private

    def pass_records
      @pass_records ||= records.where(:u_status => "Pass").where.not(u_type: "").order('updated_at desc')
    end

    def failed_records
      @failed_records ||= records.where(:u_status => "Fail").where.not(u_type: "").order('updated_at desc')
    end

    def na_records
      @na_records ||= records.where(:u_status => "NA").where.not(u_type: "").order('updated_at desc')
    end
    
    def remove_records
      @remove_records ||= records.where(:u_status => "Removed").where.not(u_type: "").order('updated_at desc')
    end

    def write_breakdown_pages(pdf, building_section, tech, watermark)
      TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(na_records, :na_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(remove_records, :removed_dampers, building_section, tech, watermark).write(pdf)
    end
  end
end
