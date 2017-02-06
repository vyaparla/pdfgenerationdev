module DoorInspectionReport
  class TablePage
    include Report::InspectionDataPageWritable

    def initialize(records, building_section)
      @records = records
      @building_section = building_section
    end

    def write (pdf)
      super
      inspection_data = []
      inspection_data << [
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.date'
        ), 
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.floor'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_number'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.fire_rating'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_location'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_type'
        )
      ]
      @records.each do |record|
        inspection_data << [record.u_inspected_on.strftime('%m-%d-%Y'), record.u_floor, 
                            record.u_tag, record.u_fire_rating, record.u_location_desc,
                            record.u_door_type]
      end
      #create the table & write it into the PDF
      pdf.font_size 10
      pdf.table(inspection_data, header:     true,
                                 cell_style: { align: :center,
                                               size:  8}) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style :background_color => '444444',
                           :text_color => 'ffffff'
        table.column(0).style { |c| c.width = 60 } # floor column width
        table.column(1).style { |c| c.width = 50 } # damper tag column
        table.column(2).style { |c| c.width = 40 } # Fire rating
        table.column(3).style { |c| c.width = 70 } # door location
        table.column(4).style { |c| c.width = 40 } # door handing
        table.column(5).style { |c| c.width = 80 } # reason for NC
      end
    end

  private

    def owner
      @job ||= @records.first
    end

    # def building
    #   @building ||= @records.first
    # end

    def building
      @building ||= @building_section
    end
  end
end
