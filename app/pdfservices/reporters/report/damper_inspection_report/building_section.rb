module DamperInspectionReport
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
      @pass_records ||= records.where(:u_status => "Pass").where.not(u_type: "").order('u_updated_date desc')
    end

    def failed_records
      @failed_records ||= records.where(:u_status => "Fail").where.not(u_type: "").order('u_updated_date desc')
    end

    def na_records
      @na_records ||= records.where(:u_status => "NA").where.not(u_type: "").order('u_updated_date desc')
    end
    
    def remove_records
      @remove_records ||= records.where(:u_status => "Removed").where.not(u_type: "").order('u_updated_date desc')
    end

 #   def write_breakdown_pages(pdf, building_section, tech, watermark)
 #     TabularBreakdownPage.new(pass_records, :pass_dampers, building_section, tech, watermark).write(pdf)
 #      TabularBreakdownPage.new(failed_records, :failed_dampers, building_section, tech, watermark).write(pdf)
 #     TabularBreakdownPage.new(na_records, :na_dampers, building_section, tech, watermark).write(pdf)
 #     TabularBreakdownPage.new(remove_records, :removed_dampers, building_section, tech, watermark).write(pdf)
 #   end
  
    def write_breakdown_pages(pdf, building_section, tech, watermark)
      asset_status_wise_breakdown(pdf, building_section, tech, watermark, pass_records, :pass_dampers)
      asset_status_wise_breakdown(pdf, building_section, tech, watermark, failed_records, :failed_dampers)
      asset_status_wise_breakdown(pdf, building_section, tech, watermark, na_records, :na_dampers,)
      asset_status_wise_breakdown(pdf, building_section, tech, watermark, remove_records, :removed_dampers)
    end

    def asset_status_wise_breakdown(pdf, building_section, tech, watermark, s_records, dampers)
      records_count = s_records.count
      if records_count <= 25
        TabularBreakdownPage.new(s_records, dampers, building_section, tech, watermark).write(pdf)
      else
        records_to_be_displayed =  s_records.limit(25)
        remaining =  s_records - records_to_be_displayed
        TabularBreakdownPage.new(records_to_be_displayed, dampers, building_section, tech, watermark).write(pdf)
	while remaining.count > 25
	  records_to_be_displayed  = remaining[0..24]
          remaining =  remaining - records_to_be_displayed
          TabularBreakdownPage.new(records_to_be_displayed, dampers, building_section, tech, watermark).write(pdf)
        end
        TabularBreakdownPage.new(remaining, dampers, building_section, tech, watermark).write(pdf)
      end

    end	    

  end
end
