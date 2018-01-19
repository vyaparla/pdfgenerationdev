module DoorInspectionReport
  class LetterPage
  	include Report::InspectionDataPageWritable
  	
  	def initialize(job, model, address1, address2, csz, facility_type, tech)
      @job = job
      @model = model
      @address1 = address1
      @address2 = address2
      @csz = csz
      @facility_type = facility_type
      @tech = tech
    end

    def write(pdf)
      super
      Report::Letter.new(@job, @model, @address1, @address2, @csz, @facility_type, :door_inspection_report, @tech).draw(pdf)
    end
  end
end