module Report
  module SectionWritable
  	def initialize(job, building)
      @job = job
      @building = building
      # Rails.logger.debug("Section Writable JOb : #{@job.inspect}")
      # Rails.logger.debug("Section Writable Building : #{@building.inspect}")
    end

  private

    def records
      @records ||= @job.building_records(@building)
      #@records = Lsspdfasset.where(:u_building => building, :u_service_id => job.u_service_id)
      #Rails.logger.debug("Section Writable Recrds: #{@records.inspect}")
    end
  end
end