module DamperInspectionReport
  class BuildingSection
  	include Report::SectionWritable
    
    def write(pdf)
      return if records.empty?
      BuildingSummaryPage.new(@job, @building, @tech).write(pdf)
      write_breakdown_pages(pdf, building_section, @tech)
      records.each { |r| PhotoPage.new(r).write(pdf)}
    end

  private

    def pass_records
      @pass_records ||= records.where(:u_status => "Pass")
    end

    def failed_records
      @failed_records ||= records.where(:u_status => "Fail")
    end

    def na_records
      @na_records ||= records.where(:u_status => "NA")
    end
    
    def remove_records
      @remove_records ||= records.where(:u_status => "Removed")
    end

    def write_breakdown_pages(pdf, building_section, tech)
      TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech).write(pdf)
      TabularBreakdownPage.new(na_records, :na_dampers, building_section, tech).write(pdf)
      TabularBreakdownPage.new(remove_records, :removed_dampers, building_section, tech).write(pdf)
    end
  end
end