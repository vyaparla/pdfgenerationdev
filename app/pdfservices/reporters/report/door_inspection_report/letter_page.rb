module DoorInspectionReport
  class LetterPage
  	include Report::InspectionDataPageWritable
  	
  	def initialize(job, address, facility_type)
      @job = job
      @address = address
      @facility_type = facility_type
    end

    def write(pdf)
      super
      Report::Letter.new(@job, @address, @facility_type, :door_inspection_report).draw(pdf)
    end
  end
end