module DoorInspectionReport
  class LetterPage
  	include Report::InspectionDataPageWritable
  	
  	def initialize(job, model, address, facility_type)
      @job = job
      @model = model
      @address = address
      @facility_type = facility_type
    end

    def write(pdf)
      super
      Report::Letter.new(@job, @model, @address, @facility_type, :door_inspection_report).draw(pdf)
    end
  end
end