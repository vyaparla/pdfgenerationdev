module DamperRepairReport
  class TablePage
  	include Report::RepairDataPageWritable

    def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
    end

    def write(pdf)
      return if records.empty?
      super
      draw_repair_table(pdf)
    end

  private

    def building
      @building
    end

    def records
      @records ||= @job.building_records(@building, @job.u_service_id)
    end

    def draw_repair_table(pdf)
      pdf.font_size 8
      pdf.table(repair_data,
                :header => true,
                :cell_style => { :align => :center }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style :background_color => '444444',
                           :text_color => "FFFFFF"
      end
    end

    def repair_data
      columns = [DamperRepairReporting.column_heading('damper_number'), DamperRepairReporting.column_heading('damper_location'), 
                 DamperRepairReporting.column_heading('status'), DamperRepairReporting.column_heading('corrective_action')]
      repair_data = []
      repair_data << columns
      records.each do |record|
        data = []
        data += [record.u_tag, record.u_location_desc, record.u_dr_passed_post_repair, 
                 "#{if record.u_repair_action_performed == "Damper Repaired"
                      record.u_dr_description
                    else
                      record.u_repair_action_performed
                    end}"]
        repair_data << data
      end
      repair_data
    end
  end
end