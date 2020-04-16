module DamperStatementReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if statement_records.empty?
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      BuildingSummaryPage.new(@job, @building, @tech, @watermark).write(pdf)
      write_breakdown_pages(pdf, building_section, @tech, @watermark)
      @records = statement_records.where.not(u_type: "", u_status: "Removed")
      @records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture, @watermark).write(pdf)}
      #comprehensive_records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture).write(pdf)}
    end

  private

    def pass_records
      @pass_records ||= statement_records.where(["u_status=? OR u_dr_passed_post_repair = ?", "Pass", "Pass"]).where.not(u_type: "").order("u_updated_date desc")
    end

    def failed_records
      @failed_records ||= statement_records.where(["u_status=? OR u_dr_passed_post_repair = ?", "Fail", "Fail"]).where.not(u_type: "").order("u_updated_date desc")   
    end

    def na_records
      @na_records ||= statement_records.where(:u_status => "NA").where.not(u_type: "").order("u_updated_date desc")
    end
    
    def remove_records
      @remove_records ||= statement_records.where(:u_status => "Removed").where.not(u_type: "").order("u_updated_date desc")
    end

    def write_breakdown_pages(pdf, building_section, tech, watermark)
      TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(na_records, :na_dampers, building_section, tech, watermark).write(pdf)
      TabularBreakdownPage.new(remove_records, :removed_dampers, building_section, tech, watermark).write(pdf)
    end
  end
end
