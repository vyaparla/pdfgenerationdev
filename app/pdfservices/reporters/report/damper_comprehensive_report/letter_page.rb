module DamperComprehensiveReport
  class LetterPage
  	include Report::InspectionDataPageWritable

    def initialize(job, model, address1, address2, csz, facility_type,facility_name, tech, s_date, e_date)
      @job = job
      @model = model
      # @group_name = group_name
      @facility_name = facility_name      
      @facility_type = facility_type
      @tech = tech
      @address1 = address1
      @address2 = address2
      @csz =  csz
      @start_date = s_date
      @end_date = e_date
    end

    def write(pdf)
      super
       draw_letter_title(pdf)
       draw_letter_page_content(pdf)

      #Report::Letter.new(@job, @model, @address1, @address2, @csz, @facility_type, :damper_repair_report, @tech).draw(pdf)
    end  

    private

    def draw_letter_title(pdf)
      pdf.font_size 15
      pdf.text("<b> Damper Repair Report </b>", :inline_format => true, :align => :center)
      pdf.move_down 25
    end  

    def draw_letter_page_content(pdf)
      start_date = @start_date.updated_at.strftime(I18n.t('date.formats.long'))
      end_date = @end_date.updated_at.strftime(I18n.t('date.formats.long'))
      work_dates = "#{start_date} - #{end_date}"
      pdf.move_down 20
      pdf.font_size 12
      pdf.text("LSS Life Safety Services, LLC, in accordance with The National Fire Protection Association’s (NFPA) Code(s) 80, 105, and 101 inspected fire and smoke dampers located in #{@facility_name} during the period of #{work_dates}. The project was managed by #{@tech}, who is an independent inspector and employee of LSS Life Safety Services, LLC, and is not affiliated with any supplier, manufacturer, or distributor of fire dampers, smoke dampers, or affiliated damper components. The following report and supporting documentation provide the result of the inspection for the dampers that were inspected. This report is intended to describe the location and operability of the dampers for the dates in which LSS Life Safety Services’ representatives performed the inspection of the dampers, and is not intended to constitute any warranty as to the continued operation of any damper. Thank you for contracting LSS Life Safety Services for this project and we look forward to the opportunity of working with you in the future on additional projects. 

                


                _____________________________
                #{@tech}
      ",      :inline_format => true)


    end
    

  end
end