module DoorInspectionReport
  class TablePage
    include Report::InspectionDataPageWritable

    def initialize(records, building_section, tech)
      @records = records
      @building_section = building_section
      @tech = tech
    end

    def write (pdf)
      super
      inspection_data = []
      inspection_data << [
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.date'
        ),
        I18n.t(          
          'ui.door_inspection_report_pdf.table_headings_cols.door_number'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.floor'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.fire_rating'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_location'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_type'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.door_status'
        ),
        I18n.t(
          'ui.door_inspection_report_pdf.table_headings_cols.' + 'reasons_for_non_compliance'
        )
      ]
      @records.each do |record|
        @firedoor_deficiency_codes = FiredoorDeficiency.where(:firedoor_service_sysid => record.u_service_id, :firedoor_asset_sysid => record.u_asset_id).collect { |w| w.firedoor_deficiencies_code }.join(", ")
        inspection_data << [record.u_inspected_on.localtime.strftime('%m/%d/%Y'), record.u_tag, record.u_floor.to_i, record.u_fire_rating, record.u_location_desc, record.u_door_type, record.u_door_inspection_result, @firedoor_deficiency_codes]
      end
      #create the table & write it into the PDF
      pdf.font_size 10
      pdf.table(inspection_data, :column_widths => { 0 => 55 },
                                 header:     true,
                                 cell_style: { align: :center, size:  8}) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style :background_color => '444444',
                           :text_color => 'ffffff'
        table.column(0).style { |c| c.width = 60 } # door_date
        table.column(1).style { |c| c.width = 50 } # door_tag
        table.column(2).style { |c| c.width = 50 } # door_floor
        table.column(3).style { |c| c.width = 60 } # door_fire_rating
        table.column(4).style { |c| c.width = 80 } # door_location_desc
        table.column(5).style { |c| c.width = 70 } # door_type
        table.column(6).style { |c| c.width = 80 } # door_inspection_result
        table.column(7).style { |c| c.width = 90 } # door_deficiency_codes
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
