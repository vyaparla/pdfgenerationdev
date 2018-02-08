module DamperRepairReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if records.empty?
      BuildingSummaryPage.new(@job, @building, @tech).write(pdf)
      write_breakdown_pages(pdf, building_section, @tech)
      @records = records.where.not(u_type: "")
      @records.each { |r| PhotoPage.new(r, @group_name, @facility_name).write(pdf)}
    end

  private

    def pass_records
      @pass_records ||= records.where(:u_dr_passed_post_repair => "Pass").where.not(u_type: "")
    end

    def failed_records
      @failed_records ||= records.where(:u_dr_passed_post_repair => "Fail").where.not(u_type: "")
    end

    def write_breakdown_pages(pdf, building_section, tech)
      TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech).write(pdf)
    end
  end
end