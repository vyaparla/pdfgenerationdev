module DamperInspectionReport
  class BuildingSection
  	include Report::SectionWritable
    
    def write(pdf)
      return if records.empty?
      BuildingSummaryPage.new(@job, @building).write(pdf)
      write_breakdown_pages(pdf)
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

    def write_breakdown_pages(pdf)
      TabularBreakdownPage.new(records, :all_dampers).write(pdf)
      TabularBreakdownPage.new(failed_records, :failed_dampers).write(pdf)
      TabularBreakdownPage.new(na_records, :na_dampers).write(pdf)
      TabularBreakdownPage.new(remove_records, :removed_dampers).write(pdf)
    end
  end
end