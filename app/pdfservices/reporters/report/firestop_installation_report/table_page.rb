module FirestopInstallationReport
  class TablePage
  	include Report::DataPageWritable

    def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
    end


    def write(pdf)
      return if records.empty?
      super
      #columns = ['Date', 'Asset #', "Floor", "Location", "Barrier Type", "Penetration Type", "Corrected with UL System"]
      columns = ['Date', 'Asset #', "Floor", "Location", "Barrier Type", "Penetration Type", "Issue", "Corrected On Site", "Suggested Corrective Action", "Corrected with UL System"]

      inspection_data = [columns]
      records.each do |inspection_record|
        record_data = [
          inspection_record.u_inspected_on.localtime.strftime('%m/%d/%Y'),
          inspection_record.u_tag,
          inspection_record.u_floor.to_i,
          inspection_record.u_location_desc,
          inspection_record.u_barrier_type,
          inspection_record.u_penetration_type,
          inspection_record.u_issue_type,
          if inspection_record.u_service_type == "Fixed On Site"
            'YES'
          else
            'NO'
          end,
          inspection_record.u_suggested_ul_system,
          inspection_record.u_corrected_url_system
        ]
        inspection_data << record_data
      end
      pdf.font_size 10
      pdf.table(inspection_data, :column_widths => { 0 => 55 },
                :header => true,
                :cell_style => {:align => :center, :size => 8}) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style {|r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style :background_color => '444444',
                           :text_color => 'ffffff'
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

    def building
      @building
    end

    def records
      @records ||= @job.building_records(@building, @job.u_service_id)
    end

    def date_key
      :installation_date
    end

    def technician_key
      :installed_by
    end
  end
end