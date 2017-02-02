module DamperInspectionReport
  class BuildingSection
  	include Report::SectionWritable
    
    def write(pdf)
      return if records.empty?
      BuildingSummaryPage.new(@job, @building).write(pdf)
      write_breakdown_pages(pdf, building_section)
      records.each { |r| PhotoPage.new(r).write(pdf)}
    end

  private

    def failed_records
      @failed_records ||= records.where(:u_status => "Fail")
    end

    def na_records
      @na_records ||= records.where(:u_status => "NA")
    end
    
    def remove_records
      @remove_records ||= records.where(:u_status => "Removed")
    end

    def write_breakdown_pages(pdf, building_section)
      TabularBreakdownPage.new(records, :all_dampers, building_section).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section).write(pdf)
      TabularBreakdownPage.new(na_records, :na_dampers, building_section).write(pdf)
      TabularBreakdownPage.new(remove_records, :removed_dampers, building_section).write(pdf)
    end
  end
end