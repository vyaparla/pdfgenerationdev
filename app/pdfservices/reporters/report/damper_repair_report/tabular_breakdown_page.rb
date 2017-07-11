module DamperRepairReport
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

    def owner
      @job ||= @records.first
    end

    def building
      @building ||= @building_section
    end

    def title
      DamperInspectionReporting.translate(@damper_type)
    end

    def summary_table_attributes
      attributes = []
      attributes += [[:date, nil],
                     [:damper_number, nil],
                     [:floor, nil],
                     [:damper_location, 85],
                     [:status, 60],
                     [:corrective_action, 100]] 

      attributes
    end

    def summary_table_data(attributes)
       [attributes.map do |column, _|
           DamperRepairReporting.column_heading(column)
      end] +
      @records.map do |record|
      	if record.u_repair_action_performed == "Damper Repaired"
      	  data = {
      	    :date => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
      	    :damper_number     => record.u_tag,
            :floor             => record.u_floor.to_i,
      	    :damper_location   => record.u_location_desc,
            :status            => record.u_dr_passed_post_repair,
            :corrective_action => record.u_dr_description
      	  }
      	  attributes.map { |column, | data[column] }
      	else
      	  data = {
      	    :date => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
      	    :damper_number     => record.u_tag,
            :floor             => record.u_floor.to_i,
      	    :damper_location   => record.u_location_desc,
            :status            => record.u_dr_passed_post_repair,
            :corrective_action => record.u_repair_action_performed
      	  }
      	  attributes.map { |column, | data[column] }
        end
      end
    end

    def draw_summary_table(pdf, data, attributes)
      pdf.table(data, :header => true, :cell_style => { :size => 8, :padding => 4, :align => :center }) do |table|
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