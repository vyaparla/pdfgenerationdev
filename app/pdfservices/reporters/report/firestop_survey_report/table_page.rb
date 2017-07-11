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
      #columns = ['Date', 'Asset #', 'Floor', 'Location', 'Penetration Type', 'Issue', 'Corrected On Site', 'Suggested Corrective Action']
      columns = ['Date', 'Asset #', 'Floor', 'Location', "Barrier Type", 'Penetration Type', 'Issue', 'Corrected On Site', "Suggested Corrective Action", "Corrected with UL System"]

      inspection_data = [columns]
      @records.each do |record|
        record_data = [
          record.u_inspected_on.localtime.strftime('%m/%d/%Y'),
          record.u_tag,
          record.u_floor.to_i,
          record.u_location_desc,
          record.u_barrier_type,
          record.u_penetration_type,
          record.u_issue_type,
          if record.u_service_type == "Fixed On Site"
            'YES'
          else
            'NO'
          end,
          record.u_suggested_ul_system,
          record.u_corrected_url_system
        ]
        inspection_data << record_data
      end
      #create the table & write it into the PDF
      pdf.font_size 10
      pdf.table(inspection_data, :column_widths => { 0 => 55 },
                header: true,
                cell_style: { align: :center, size: 8 }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style background_color: '444444',
                           text_color:       'ffffff'
        table.column(0).style { |c| c.width = 60 } # Date
        table.column(1).style { |c| c.width = 60 } # Asset #
        table.column(2).style { |c| c.width = 40 } # Floor
        table.column(3).style { |c| c.width = 70 } # Location
        # table.column(4).style { |c| c.width = 55 } # Barrier Type
        # table.column(5).style { |c| c.width = 55 } # Penetration Type
        # table.column(6).style { |c| c.width = 60 } # Issue
        # table.column(7).style { |c| c.width = 60 } # Corrected On Site
        # table.column(8).style { |c| c.width = 80 } # Corrected with UL System      
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