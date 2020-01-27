module DamperStatementReport
  class TablePage
  	include Report::RepairDataPageWritable

    def initialize(job, building, tech, group_name, facility_name, with_picture)
      @job = job
      @building = building
      @tech = tech
      @with_picture = with_picture
    end

    def write(pdf)
      return if records.empty?
      super
      draw_table_title(pdf)
      draw_repair_table(pdf)
    end

  private

    def draw_table_title(pdf)
      pdf.font_size 30
      pdf.fill_color 'f39d27'
      pdf.text("Passed Dampers", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def table_param
       floor = @job.u_floor == "other" ? @job.u_other_floor : @job.u_floor
       repair_action = @job.u_repair_action_performed == "Damper Repaired" ? @job.u_dr_description : @job.u_repair_action_performed
         #              record.u_dr_description
         #            else
         #              record.u_repair_action_performed
          
      { asset: @job.u_tag ,
        floor: floor,
        location: @job.u_location_desc,
        damper_type: @job.u_damper_name,
        status: @job.u_dr_passed_post_repair,
        dificiancy: @job.u_reason,
        repair_action: repair_action,
        date: @job.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
 
      }
        
    end

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
      columns = ['Asset #', 'Floor', 'Location', 'Damper Type', 'Status',
        ' Deficiency(s)', 'Repair Action', 'Date']
      repair_data = []
      repair_data << columns
      records.each do |record|
        data = []
        data += [table_param[:asset], table_param[:floor], table_param[:location], 
        table_param[:damper_type], table_param[:status], table_param[:deficiancy], 
        table_param[:repair_action], table_param[:date]]
         # record.u_tag, record.u_location_desc, record.u_dr_passed_post_repair, 
         #         "#{if record.u_repair_action_performed == "Damper Repaired"
         #              record.u_dr_description
         #            else
         #              record.u_repair_action_performed
         #            end}"]
        repair_data << data
      end
      repair_data
    end
  end
end
