module DamperInspectionReport
  class LetterPage
  	include Report::InspectionDataPageWritable

    def initialize(job, model, address1, address2, csz, facility_type, tech)
      @job = job
      @model = model
      # @group_name = group_name
      #@facility_name = job.u_facility_name      
      @facility_type = facility_type
      @tech = tech
      @address1 = address1
      @address2 = address2
      @csz =  csz
    end

    def write(pdf)
      super
      Report::Letter.new(@job, @model, @address1, @address2, @csz, @facility_type, :damper_inspection_report, @tech).draw(pdf)
    end  
  end
end