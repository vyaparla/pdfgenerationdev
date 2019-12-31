module FirestopComprehensiveReport
  module DataPageWritable
    include Report::DataPageWritable

  private

    def draw_heading(pdf)
      # pdf.indent(15) do
      #   pdf.font_size 12
      #   pdf.fill_color '202020'
      #   [[:contracted_by, owner.u_group_name],
      #    [place_key     , place_name         ],
      #    [date_key      , owner.work_dates   ]].each do |key, value|
      #     pdf.move_down 3
      #     pdf.text("#{label(key)} #{value}", :inline_format => true)
      #   end
      #   pdf.move_down 3
      #   pdf.text("#{label(technician_key)} #{technician}", :inline_format => true)
      # end
      pdf.font_size 12
      pdf.fill_color '202020'
      [[:contracted_by, group_name],
      [place_key     , place_name],
      [building_key  , build_name],
      [date_key      , owner.work_dates]].each do |key, value|
        pdf.move_down 3
        pdf.text("#{label(key)} #{value}", :inline_format => true)
      end
        pdf.move_down 3
        pdf.text("#{label(technician_key)} #{technician}", :inline_format => true)
      #pdf.move_down 30
      pdf.move_down 15
    end

    def date_key
      :survey_date
    end

    def technician_key
      :surveyed_by
    end

    def technician
      @tech
    end

    def relative_background_path
      'three_hundred_dpi/final_data_page_new.jpg'
    end
  end
end
