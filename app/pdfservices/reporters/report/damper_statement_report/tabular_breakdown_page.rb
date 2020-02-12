module DamperStatementReport
  class TabularBreakdownPage
  	include Report::RepairDataPageWritable

 def initialize(records, damper_type, building_section, tech)
      @records = records
      @damper_type = damper_type
      @building_section = building_section
      @tech = tech
    end

    def write(pdf)
      return if @records.empty?
      super
      pdf.font_size 10
      pdf.text("<b>#{title}</b>", :inline_format => true)
      attributes = summary_table_attributes
      draw_summary_table(pdf, summary_table_data(attributes), attributes)
    end

  private

    def owner
      @job ||= @records.first
    end

    def building
      @building ||= @building_section
    end    

    def title
      DamperInspectionReporting.translate(@damper_type)
    end

    def contains_all_results
      @damper_type == :pass_dampers
    end

    def summary_table_attributes
      attributes = []
      attributes += [[:damper_number, nil]]
      attributes += [[:floor, nil],
                     [:damper_location, contains_all_results ? 85 : 60],
                     [:damper_type, 55],
                     [:status, 60]]
      attributes   <<  [:deficiency_s, 75]
      attributes   +=  [[:repair_action, 60]]

      attributes += [[:date, nil]]
    
      attributes
    end

    def summary_table_data(attributes)
      [attributes.map do |column, _|
           DamperInspectionReporting.column_heading(column)
      end] +
      if @damper_type == :pass_dampers
        @records.map do |record|
          if record.u_report_type == "DAMPERREPAIR"
            if record.u_dr_passed_post_repair == "Pass"
              @post_status = "Pass"
            else
             @post_status = "Fail" 
            end
            @deficiency = record.u_reason2
            @action = record.u_dr_description
          else
            @post_status = record.u_status
            @deficiency = record.u_reason
            @action = record.u_repair_action_performed
          end  
        floor = record.u_floor == "other" ? record.u_other_floor : record.u_floor

          data = {            
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :status    => @post_status,
            :deficiency_s        => @deficiency,
            :repair_action => @action
          }
          attributes.map { |column, | data[column] }
        end 
      elsif @damper_type == :failed_dampers
        @records.map do |record|
          if record.u_report_type == "DAMPERREPAIR"
            if record.u_dr_passed_post_repair == "Pass"
              @post_status = "Pass"
            else
             @post_status = "Fail" 
            end
            @deficiency = record.u_reason2
            @action = record.u_dr_description
          else
            @post_status = record.u_status
            @deficiency = record.u_reason
            @action = record.u_repair_action_performed
          end  
          
          floor = record.u_floor == "other" ? record.u_other_floor : record.u_floor 

          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :status    =>  @post_status,
            :deficiency_s        => @deficiency,
            :repair_action => @action
          }
          attributes.map { |column, | data[column] }
        end
      elsif @damper_type == :na_dampers        
        @records.map do |record|

          floor = record.u_floor == "other" ? record.u_other_floor : record.u_floor
          status = record.u_status == "NA" ? "Non-Accessible" : " "


          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :status    => status,
            :deficiency_s        => record.u_non_accessible_reasons
          }
          attributes.map { |column, | data[column] }
        end
      else
        @records.map do |record|
          if record.u_di_installed_access_door == "true"
            @di_installedaccess_door = "YES"
          else
            @di_installedaccess_door = ""
          end
    floor = record.u_floor == "other" ? record.u_other_floor : record.u_floor
          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => floor,
            :damper_location   => record.u_location_desc,
            :status    => record.u_status,
            :damper_type       => record.u_damper_name
          }
          attributes.map { |column, | data[column] }
        end
      end
    end
    
    def draw_summary_table(pdf, data, attributes)
      pdf.table(data, :header => true, :cell_style => { :size => 7, :padding => 4, :align => :center }) do |table|
        last = table.row_length - 1
        table.row_colors = %w(ffffff eaeaea)
        table.row(0).style :border_color     => '888888',
                           :background_color => '444444',
                           :text_color       => 'ffffff'
        table.rows(1..last).style :border_color => 'cccccc'
        attributes.each_with_index do |pair, index|
          table.column(index).style :width => pair.last unless pair.last.nil?
        end
        result_index = attributes.find_index do |pair|
          pair.first == :inspection_result
        end
        result_index && table.column(result_index).rows(1..last).each do |cell|
          cell.text_color = case cell.content
          when DamperInspectionReporting.translate(:fail)
            'c1171d'
          when DamperInspectionReporting.translate(:na)
            'f39d27'
          else
            '202020'
          end
        end
      end
    end
  end
end
