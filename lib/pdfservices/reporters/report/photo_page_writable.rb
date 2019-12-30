module Report
  module PhotoPageWritable
  	include PageWritable
    

  	def initialize(record, group_name, facility_name)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
    end

  private

    def bold(string)
      "<b>#{string}</b>"
    end

    def draw_heading(pdf)
      # [[[12, '202020'], title],
      #  #[[12, 'f39d27'], "#{@record.u_building}: #{@record.u_facility_name}"],
      #  [[12, 'c6171e'], "#{@record.u_facility_name}"],
      #  [[12, 'c6171e'], "#{@record.u_building}"],
      #  [[10, '202020'], @record.work_dates]].each do |(size, color), content|
      #   pdf.font_size size
      #   pdf.fill_color color
      #   pdf.indent(0) { pdf.text(bold(content), :inline_format => true) }
      #   #pdf.text(bold(content), :inline_format => true)
      # end
      # pdf.move_down 45

      pdf.font_size 12
      pdf.fill_color '202020'
      # if @record.u_report_type == "DAMPERINSPECTION"
      #   unless @group_name.blank?
      #     [["Contracted By :", "#{@group_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Inspection Date :", @record.work_dates],
      #     ["Inspected By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end   
      #   else
      #     [["Contracted By :", "#{@facility_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Inspection Date :", @record.work_dates],
      #     ["Inspected By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end
      #   end
      # elsif @record.u_report_type == "DAMPERREPAIR"
      #   unless @group_name.blank?
      #     [["Contracted By :", "#{@group_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Repair Date :", @record.work_dates],
      #     ["Repaired By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end   
      #   else
      #     [["Contracted By :", "#{@facility_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Repair Date :", @record.work_dates],
      #     ["Repaired By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end
      #   end
      if @record.u_report_type == "FIREDOORINSPECTION"
        unless @group_name.blank?
          [["Contracted By :", "#{@group_name}"],
          ["Facility :", "#{@facility_name}"],
          ["Building :" , "#{@record.u_building}"],
          ["Inspection Date :", @record.work_dates],
          ["Inspected By :", "#{@record.u_inspector}"]].each do |key, value|
            pdf.move_down 3
            pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
          end   
        else
          [["Contracted By :", "#{@facility_name}"],
          ["Facility :", "#{@facility_name}"],
          ["Building :" , "#{@record.u_building}"],
          ["Inspection Date :", @record.work_dates],
          ["Inspected By :", "#{@record.u_inspector}"]].each do |key, value|
            pdf.move_down 3
            pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
          end
        end
      # elsif @record.u_report_type == "FIRESTOPINSTALLATION"
      #   unless @group_name.blank?
      #     [["Contracted By :", "#{@group_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Installation Date :", @record.work_dates],
      #     ["Installed By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end   
      #   else
      #     [["Contracted By :", "#{@facility_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Installation Date :", @record.work_dates],
      #     ["Installed By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end
      #   end
      # elsif @record.u_report_type == "FIRESTOPSURVEY"
      #   unless @group_name.blank?
      #     [["Contracted By :", "#{@group_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Survey Date :", @record.work_dates],
      #     ["Surveyed By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end   
      #   else
      #     [["Contracted By :", "#{@facility_name}"],
      #     ["Facility :", "#{@facility_name}"],
      #     ["Building :" , "#{@record.u_building}"],
      #     ["Survey Date :", @record.work_dates],
      #     ["Surveyed By :", "#{@record.u_inspector}"]].each do |key, value|
      #       pdf.move_down 3
      #       pdf.text("<b>#{key}</b> #{value}", :inline_format => true)
      #     end
      #   end
      end
      pdf.move_down 18
    end

    def relative_background_path
      'three_hundred_dpi/final_graphic_page_new.jpg'
    end
  end
end