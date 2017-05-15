module DamperInspectionReport
  class TabularBreakdownPage
  	include Report::InspectionDataPageWritable
   
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
      attributes += [[:date, nil],
                     [:damper_number, nil]]

      attributes += [[:floor, nil],
                     [:damper_location, contains_all_results ? 85 : 60],
                     [:damper_type, 55], 
                     [:current_status, 60]]

      #attributes   <<  [:service_type, 60]
      #attributes   <<  [:current_status, 60]
      attributes   <<  [:deficiency, 75]
      attributes   +=  [[:corrective_action, 60]]
      
      attributes   +=  [[:installed_access_door, 60]]
        # attributes <<  [:fpm_reading, 60]
        # attributes += [[:corrective_action, 60],
        #                  [:forty_five_days, 29],
        #                  [:pfi, 22],
        #                  [:ilsm, 25]]
    
      attributes
    end

    def summary_table_data(attributes)
      [attributes.map do |column, _|
           DamperInspectionReporting.column_heading(column)
      end] +
      if @damper_type == :pass_dampers
        @records.map do |record|
          if record.u_di_installed_access_door == "true"
            @di_installedaccess_door = "YES"
          else
            @di_installedaccess_door = ""
          end
          data = {            
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => record.u_floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :current_status    => record.u_status,
            :installed_access_door    => @di_installedaccess_door

            #:service_type      => "Inspection",
            #:deficiency        => "Issue",
            # :inspection_result => record.u_status,
            # :reason_for_fail_or_na => record.u_reason
            # :fpm_reading           => '  ',
            # :corrective_action     => '  ',
            # :forty_five_days       => '  ',
            # :pfi                   => '  ',
            # :ilsm                  => '  '
          }
          attributes.map { |column, | data[column] }
        end 
      elsif @damper_type == :failed_dampers
        @records.map do |record|
          if record.u_di_installed_access_door == "true"
            @di_installedaccess_door = "YES"
          else
            @di_installedaccess_door = ""
          end
          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => record.u_floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :current_status    => record.u_status,
            :deficiency        => record.u_reason,
            :corrective_action => record.u_di_replace_damper,
            :installed_access_door    => @di_installedaccess_door

            #:service_type      => "Inspection",
            # :inspection_result => record.u_status,
            # :reason_for_fail_or_na => record.u_reason
            # :fpm_reading           => '  ',
            # :corrective_action     => '  ',
            # :forty_five_days       => '  ',
            # :pfi                   => '  ',
            # :ilsm                  => '  '
          }
          attributes.map { |column, | data[column] }
        end
      elsif @damper_type == :na_dampers        
        @records.map do |record|
          if record.u_di_installed_access_door == "true"
            @di_installedaccess_door = "YES"
          else
            @di_installedaccess_door = ""
          end
          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => record.u_floor,
            :damper_location   => record.u_location_desc,
            :damper_type       => record.u_damper_name,
            :current_status    => record.u_status,
            :deficiency        => record.u_non_accessible_reasons,
            :installed_access_door    => @di_installedaccess_door

            #:service_type      => "Inspection",
            # :inspection_result => record.u_status,
            # :reason_for_fail_or_na => record.u_reason
            # :fpm_reading           => '  ',
            # :corrective_action     => '  ',
            # :forty_five_days       => '  ',
            # :pfi                   => '  ',
            # :ilsm                  => '  '
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
          data = {
            :date              => record.u_inspected_on.localtime.strftime(I18n.t('time.formats.mdY')),
            :damper_number     => record.u_tag,
            :floor             => record.u_floor,
            :damper_location   => record.u_location_desc,
            :current_status    => record.u_status,
            :damper_type       => record.u_damper_name,
            :installed_access_door    => @di_installedaccess_door

            #:service_type      => "Inspection",
            #:deficiency        => record.u_non_accessible_reasons,
            # :inspection_result => record.u_status,
            # :reason_for_fail_or_na => record.u_reason
            # :fpm_reading           => '  ',
            # :corrective_action     => '  ',
            # :forty_five_days       => '  ',
            # :pfi                   => '  ',
            # :ilsm                  => '  '
          }
          attributes.map { |column, | data[column] }
        end
      end
            
      # @records.map do |record|
      # 	  data = {            
      # 	    :date              => record.u_inspected_on.strftime(I18n.t('time.formats.mdY')),
      #       :damper_number     => record.u_tag,
      # 	    :floor             => record.u_floor,
      #       :damper_location   => record.u_location_desc,
      # 	    :damper_type       => record.u_damper_name,
      #       #:service_type      => "Inspection",
      #       :deficiency        => "Issue",
      #       :current_status    => record.u_status

      # 	    # :inspection_result => record.u_status,
      # 	    # :reason_for_fail_or_na => record.u_reason
      #       # :fpm_reading           => '  ',
      #       # :corrective_action     => '  ',
      #       # :forty_five_days       => '  ',
      #       # :pfi                   => '  ',
      #       # :ilsm                  => '  '
      # 	  }
      # 	  attributes.map { |column, | data[column] }
      # end
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