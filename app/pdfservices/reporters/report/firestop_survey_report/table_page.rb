module FirestopSurveyReport
  class TablePage
  	include DataPageWritable

    def initialize(records, building_section, tech)
      @records = records
      @building_section = building_section
      @tech = tech
    end

    def write(pdf)
      super
      columns = ['Asset #', 'Floor', 'Location', 'Penetration Type', 'Issue', 'Corrected On Site', 'Suggested Corrective Action']

      inspection_data = [columns]
      @records.each do |record|
        record_data = [
          #record.u_inspected_on.strftime('%m-%d-%Y'),
          record.u_tag,
          record.u_floor,
          record.u_location_desc,
          record.u_penetration_type,
          record.u_issue_type,
          if record.u_service_type == "Fixed On Site"
            'YES'
          else
            'NO'
          end,
          record.u_suggested_ul_system
        ]
        inspection_data << record_data
      end
      #create the table & write it into the PDF
      pdf.font_size 10
      pdf.table(inspection_data, :column_widths => { 0 => 50 },
                header: true,
                cell_style: { align: :center, size: 10 }) do |table|

        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style background_color: '444444',
                           text_color:       'ffffff'
      end
    end

  private

    def owner
      @job ||= @records.first
    end

    def building
      @building ||= @building_section
    end
  end
end