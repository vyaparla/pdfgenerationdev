module Report
  module SectionWritable

 	  def initialize(job, building, tech, group_name, facility_name, with_picture)
      @job = job
      @building = building
      @tech = tech
      @group_name = group_name
      @facility_name = facility_name
      @with_picture = with_picture
      #Rails.logger.debug("Section Writable JOb : #{@job.inspect}")
      #Rails.logger.debug("Section Writable Building : #{@building.inspect}")
    end

  private

    def records
      @records ||= @job.building_records(@building, @job.u_service_id)
      #@records = Lsspdfasset.where(:u_building => building, :u_service_id => job.u_service_id)
    end
 
    def comprehensive_records
      if @job.u_report_type == "DAMPERREPAIR" || "DAMPERINSPECTION"
        report_type = ["DAMPERREPAIR", "DAMPERINSPECTION"]
      else
        report_type = ["FIRESTOPSURVEY" ,"FIRESTOPINSTALLATION"]
      end 
      @comprehensive_records ||= @job.comprehensive_building_records(@building, @job.u_facility_id, report_type)
      #@records = Lsspdfasset.where(:u_building => building, :u_service_id => job.u_service_id)
    end

    def building_section
      @building_section = @building
    end
  end
end
