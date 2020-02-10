module Report
  module DamperComprehensiveDataPageWritable
  	include ComprehensivePageWritable

  private

    def bold(string)
      "<b>#{string}</b>"
    end

    def bottom_margin
      150
    end

    def comprehensive_draw_heading(pdf)
      pdf.font_size 12
      pdf.fill_color '202020'
      [[:contracted_by, group_name],
      [place_key     , place_name],
      [building_key  , build_name],
      [date_key      , owner.work_dates],
      [technician_key, technician]].each do |key, value|
        pdf.move_down 3
        pdf.text("#{label(key)} #{value}", :inline_format => true)
      end
      pdf.move_down 30
    end

    def label(key)
      "<b>#{I18n.t("pdf.data_page.heading_label.#{key}")}:</b>"
    end

    def needs_new_page?(pdf)
      pdf.cursor < 295
    end

    def owner
      @job
    end

    def building_names
      owner.damper_comprehensive_buildings(owner.u_facility_id)
    end

    def technician
      @tech
    end

    def place_key
      #respond_to?(:building, true) ? :building_name : :location_name
      :location_name
    end

    def place_name
      # if respond_to?(:building, true)
      #   "#{building} . #{owner.u_facility_name}"
      # else
      #   owner.u_facility_name
      # end
      owner.u_facility_name
    end

    def group_name
      unless owner.u_group_name.blank?
        "#{owner.u_group_name}"
      else        
        "#{owner.u_facility_name}"
      end
    end

    def building_key
      #respond_to?(:building, true) ? :building_name : :location_name
      :building_name
    end

    def build_name
      if respond_to?(:building, true)
        "#{building}"
      else
        "#{building_names.map(&:inspect).join(', ').gsub!('"', '')}"
      end
    end

    def relative_background_path
      'three_hundred_dpi/final_data_page_new.jpg'
    end
  end
end