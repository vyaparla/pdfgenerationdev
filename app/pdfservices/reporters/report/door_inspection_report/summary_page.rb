module DoorInspectionReport
  class SummaryPage
  	include Report::InspectionDataPageWritable

    def initialize(job, tech)
      @job = job
      @tech = tech
    end

   def write(pdf)
   	 super
   	 draw_facility_title(pdf)
   	 Report::Table.new(facility_summary_table_content).draw(pdf)
   end
  
  private

    def draw_facility_title(pdf)
      pdf.font_size 40
      pdf.fill_color 'f39d27'
      pdf.text("<b>Facility Summary</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def facility_summary_table_headings
      ["Building", "Total # Deficiencies Found", "Total # Deficiencies Addressed This Project", "Total # Deficiencies Remaining"]
    end

    def facility_summary_table_content
      [facility_summary_table_headings] +  facility_summary_table_data
    end

    def facility_summary_table_data
      [["Main Building", 20, 15, 5]]
    end
  end
end