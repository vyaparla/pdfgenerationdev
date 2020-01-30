module Report
  class CoverPage
  	include PageWritable

    def initialize(owner, model_name, address1, address2, csz, facility_name, tech)
      @owner = owner      
      @model_name = model_name
      @address1 = address1
      @address2 = address2
      @csz =  csz.split("_")
      
      # @group_name = group_name
       @facility_name = facility_name
       @tech = tech
      # @group_url = group_url
      # @facility_url = facility_url
      # @nfpa_url = nfpa_url
    end

    def write(pdf)
      super
      pdf.fill_color '202020'
      draw_title(pdf)
      draw_subtitle(pdf)
     # summary_text(pdf)
    end
  
  private

    def draw_title(pdf)
      # pdf.indent 40 do
      #   pdf.move_down 300
      #   pdf.font_size 30
      #   if @model_name == "DAMPERINSPECTION"
      #     pdf.text("<b><i>Damper Inspection Report</i></b>", :inline_format => true)
      #   elsif @model_name == "DAMPERREPAIR"
      #     pdf.text("<b><i>Damper Repair Report</i></b>", :inline_format => true)
      #   elsif @model_name == "FIREDOORINSPECTION"
      #     pdf.text("<b><i>Fire Door Inspection Report</i></b>", :inline_format => true)
      #   elsif @model_name == "FIRESTOPINSTALLATION"
      #     pdf.text("<b><i>Firestop Installation Report</i></b>", :inline_format => true)
      #   elsif @model_name == "FIRESTOPSURVEY"
      #     pdf.text("<b><i>Firestop Survey Report</i></b>", :inline_format => true) 
      #   end
      #   pdf.move_down 25
      # end
      pdf.move_down 300
      pdf.font_size 30
      
      if @model_name == "DAMPERINSPECTION"
        pdf.text("<b><i>Damper Inspection Report</i></b>", :inline_format => true)
      elsif @model_name == "DAMPERREPAIR"
        pdf.text("<b><i>Damper Repair Report</i></b>", :inline_format => true)
      elsif @model_name == "FIREDOORINSPECTION"
        pdf.text("<b><i>Fire Door Inspection Report</i></b>", :inline_format => true)
      elsif @model_name == "FIRESTOPINSTALLATION"
        pdf.text("<b><i>Firestop Installation Report</i></b>", :inline_format => true)
      elsif @model_name == "FIRESTOPSURVEY"
        pdf.text("<b><i>Firestop Survey Report</i></b>", :inline_format => true)
      elsif @model_name == "DAMPER"
        pdf.text("<b><i>Damper Comprehensive Report</i></b>", :inline_format => true)
      elsif @model_name == "Firestop Comprehensive"
        pdf.text("<b><i>Firestop Comprehensive Report</i></b>", :inline_format => true)
      elsif @model_name == "Damper Statement"
        pdf.text("<b><i>Damper Statement Report</i></b>", :inline_format => true)  
      elsif @model_name == "Firestop Statement"
        pdf.text("<b><i>Firestop Statement Report</i></b>", :inline_format => true)
	
      end
      pdf.move_down 25
    end

    def draw_subtitle(pdf)
      # pdf.indent 40 do
      #   pdf.font_size 25
      #   pdf.fill_color 'c6171e'
      #   #pdf.text("<b><i>#{@owner.u_job_id}</i></b>", :inline_format => true)
      #   pdf.text("<b><i>#{@owner.u_facility_name}</i></b>", :inline_format => true)
      #   pdf.move_down 20
      #   unless @address.blank?
      #     pdf.text("<b><i>#{@address[0]}, #{@address[1]}, #{@address[2]}</i></b>", :inline_format => true)
      #     pdf.text("<b><i>#{@address[3]}, #{@address[4]}</i></b>", :inline_format => true)
      #     pdf.text("<b><i>United States</i></b>", :inline_format => true)
      #   end
      # end
      pdf.font_size 25
      #pdf.fill_color 'c6171e'
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{@owner.u_facility_name}</b>", :inline_format => true)
      unless @address1.blank?
        pdf.move_down 5
        pdf.text("<b>#{@address1}</b>", :inline_format => true)
      end
      unless @address2.blank?
        pdf.move_down 5
        pdf.text("<b>#{@address2}</b>", :inline_format => true)
      end
      pdf.move_down 5
      unless @csz.blank?
        pdf.text("<b>#{@csz[0]}, #{@csz[1]} #{@csz[2]}</b>", :inline_format => true)
      end
      # unless @address.blank?
      #   pdf.text("<b><i>#{@address[0]}, #{@address[1]}, #{@address[2]}</i></b>", :inline_format => true)
      #   pdf.text("<b><i>#{@address[3]}, #{@address[4]}</i></b>", :inline_format => true)
      #   #pdf.text("<b><i>United States</i></b>", :inline_format => true)
      # end
    end

    def summary_text(pdf)
        pdf.move_down 15
        pdf.fill_color '#000000'
        pdf.font_size 12
        if @model_name == "DAMPERREPAIR"
          pdf.text("LSS Life Safety Services, LLC, in accordance with The National Fire Protection Association’s (NFPA) Code(s) 80, 105, and 101 inspected fire and smoke dampers located in <b> #{@facility_name} </b> during the period of <b>#{@owner.work_dates} </b>. The project was managed by <b> #{@tech} </b>, who is an independent inspector and employee of LSS Life Safety Services, LLC, and is not affiliated with any supplier, manufacturer, or distributor of fire dampers, smoke dampers, or affiliated damper components. The following report and supporting documentation provide the result of the inspection for the dampers that were inspected. This report is intended to describe the location and operability of the dampers for the dates in which LSS Life Safety Services’ representatives performed the inspection of the dampers, and is not intended to constitute any warranty as to the continued operation of any damper. Thank you for contracting LSS Life Safety Services for this project and we look forward to the opportunity of working with you in the future on additional projects.", 
            :inline_format => true)

          pdf.move_down 25
          pdf.text("<b> #{@tech}</b>", :inline_format => true)
          pdf.stroke_horizontal_rule
          pdf.move_down 3
          pdf.text("<i> Signature </i>",:inline_format => true)
          pdf.move_down 20
        end  

   end  

    def relative_background_path
      'three_hundred_dpi/final_report_cover_new.jpg'
    end
  end
end
