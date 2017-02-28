module Report
  module SectionWritable
  	def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
      #Rails.logger.debug("Section Writable JOb : #{@job.inspect}")
      #Rails.logger.debug("Section Writable Building : #{@building.inspect}")
    end

  private

    def records
      @records ||= @job.building_records(@building, @job.u_service_id)
      #@records = Lsspdfasset.where(:u_building => building, :u_service_id => job.u_service_id)
    end

    def building_section
      @building_section = @building
    end
  end
end