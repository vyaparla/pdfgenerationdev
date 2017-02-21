module FirestopSurveyReport
  module DataPageWritable
    include Report::DataPageWritable

  private

    def draw_heading(pdf)
      pdf.indent(15) do
        pdf.font_size 12
        pdf.fill_color '202020'
        [[:contracted_by, owner.u_group_name],
         [place_key     , place_name         ],
         [date_key      , owner.work_dates   ]].each do |key, value|
          pdf.move_down 3
          pdf.text("#{label(key)} #{value}", :inline_format => true)
        end
        pdf.move_down 3
        pdf.text(
          "#{label(technician_key)} #{owner.u_job_scale_rep}", :inline_format => true)
      end
      pdf.move_down 30
    end

    def date_key
      :survey_date
    end

    def technician_key
      :surveyed_by
    end

  end
end