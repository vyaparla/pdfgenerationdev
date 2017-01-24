module Report
  class CoverPage
  	include PageWritable

    def initialize(owner)
      @owner = owner
    end

    def write(pdf)
      super
      pdf.fill_color '202020'
      draw_title(pdf)
      draw_subtitle(pdf)
    end
    
    def draw_title(pdf)
      pdf.indent 40 do
        pdf.move_down 300
        pdf.font_size 30
        pdf.text("<b><i>Damper Inspection Job</i></b>", :inline_format => true)
        pdf.move_down 25
      end
    end

    def draw_subtitle(pdf)
      pdf.indent 40 do
        pdf.font_size 25
        pdf.fill_color 'c6171e'
        pdf.text("<b><i>#{@owner.u_job_id}</i></b>", :inline_format => true)
      end
    end

    def relative_background_path
      'three_hundred_dpi/final_report_cover.jpg'
    end
  end
end