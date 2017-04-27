module Report
  module DataPageWritable
  	include PageWritable

  private

    def bold(string)
      "<b>#{string}</b>"
    end

    # def bottom_margin
    #   150
    # end

    def draw_heading(pdf)
      # pdf.indent(5) do
      #   pdf.font_size 12
      #   pdf.fill_color '202020'
      #   [[:contracted_by, owner.u_group_name],
      #    [place_key     , place_name],
      #    [date_key      , owner.work_dates],
      #    [technician_key, technician]].each do |key, value|
      #      pdf.move_down 3
      #      pdf.text("#{label(key)} #{value}", :inline_format => true)
      #   end 
      # end
      
      pdf.font_size 12
      pdf.fill_color '202020'
      [[:contracted_by, owner.u_group_name],
      [place_key     , place_name],
      [date_key      , owner.work_dates],
      [technician_key, technician]].each do |key, value|
        pdf.move_down 3
        pdf.text("#{label(key)} #{value}", :inline_format => true)
      end
      pdf.move_down 30
    end

    def label(key)
      "<b>#{I18n.t("pdf.data_page.heading_label.#{key}")}:</b>"
    end

    def needs_new_page?(pdf)
      pdf.cursor < 295
    end

    def owner
      @job
    end

    def technician
      @tech
    end

    def place_key
      respond_to?(:building, true) ? :building_name : :location_name
    end

    def place_name
      if respond_to?(:building, true)
        "#{building} . #{owner.u_facility_name}"
      else
        owner.u_facility_name
      end
    end

    def relative_background_path
      'three_hundred_dpi/final_data_page_new.jpg'
    end
  end
end