module DamperInspectionReport
  class LetterPage
  	include Report::InspectionDataPageWritable

    def initialize(job, model, address, facility_type)
      @job = job
      @model = model
      # @group_name = group_name
      # @facility_name = facility_name
      @address = address
      @facility_type = facility_type
    end

    def write(pdf)
      super
      Report::Letter.new(@job, @model, @address, @facility_type, :damper_inspection_report).draw(pdf)
    end
  end
end