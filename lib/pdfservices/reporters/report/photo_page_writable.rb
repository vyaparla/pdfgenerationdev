module Report
  module PhotoPageWritable
  	include PageWritable

  	def initialize(record)
      @record = record
    end

  private

    def bold(string)
      "<b>#{string}</b>"
    end

    def draw_heading(pdf)
      [[[12, '202020'], title],
       #[[12, 'f39d27'], "#{@record.u_building}: #{@record.u_facility_name}"],
       [[12, 'f39d27'], "#{@record.u_facility_name}"],
       [[12, 'f39d27'], "#{@record.u_building}"],
       [[10, '202020'], @record.work_dates]].each do |(size, color), content|
        pdf.font_size size
        pdf.fill_color color
        pdf.indent(0) { pdf.text(bold(content), :inline_format => true) }
        #pdf.text(bold(content), :inline_format => true)
      end
      pdf.move_down 45
    end

    def relative_background_path
      'three_hundred_dpi/final_graphic_page_new.jpg'
    end
  end
end