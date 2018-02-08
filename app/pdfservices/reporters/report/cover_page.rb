module Report
  class CoverPage
  	include PageWritable

    def initialize(owner, model_name, address1, address2, csz)
      @owner = owner      
      @model_name = model_name
      @address1 = address1
      @address2 = address2
      @csz =  csz.split("_")
      
      # @group_name = group_name
      # @facility_name = facility_name
      # @group_url = group_url
      # @facility_url = facility_url
      # @nfpa_url = nfpa_url
    end

    def write(pdf)
      super
      pdf.fill_color '202020'
      draw_title(pdf)
      draw_subtitle(pdf)
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
      pdf.move_down 5
      pdf.text("<b>#{@address1}</b>", :inline_format => true)
      unless @address2.blank?
        pdf.move_down 5
        pdf.text("<b>#{@address2}</b>", :inline_format => true)
      end
      pdf.move_down 5
      pdf.text("<b>#{@csz[0]}, #{@csz[1]} #{@csz[2]}</b>", :inline_format => true)
      # unless @address.blank?
      #   pdf.text("<b><i>#{@address[0]}, #{@address[1]}, #{@address[2]}</i></b>", :inline_format => true)
      #   pdf.text("<b><i>#{@address[3]}, #{@address[4]}</i></b>", :inline_format => true)
      #   #pdf.text("<b><i>United States</i></b>", :inline_format => true)
      # end
    end

    def relative_background_path
      'three_hundred_dpi/final_report_cover_new.jpg'
    end
  end
end