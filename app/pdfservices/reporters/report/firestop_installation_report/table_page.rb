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
      columns = ['Asset #', "Floor", "Location", "Barrier Type", "Penetration Type", "Corrected with UL System"]
      inspection_data = [columns]
      records.each do |inspection_record|
        record_data = [
          #inspection_record.u_inspected_on.strftime('%m-%d-%Y'),
          inspection_record.u_tag,
          inspection_record.u_floor,
          inspection_record.u_location_desc,
          inspection_record.u_barrier_type,
          inspection_record.u_penetration_type,
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