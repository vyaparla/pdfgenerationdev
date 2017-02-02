module Report
  class Letter
  	def initialize(owner, address, facility_type, i18n_key)
      @owner = owner
      # @group_name = group_name
      # @facility_name = facility_name
      @address = address.split("_")
      @facility_type = facility_type 
      @i18n_key = i18n_key
    end

    def draw(pdf)
      pdf.fill_color '202020'
      draw_letter_title(pdf)
      draw_letter_body(pdf)
    end

    private

    def certified?
      #@owner.respond_to?(:joint_commission_certified?) && @owner.joint_commission_certified?
      @facility_type.upcase == "HEALTHCARE -- JOINT COMMISSION CERTIFIED"
    end

    def certified_letter_copy
      I18n.t("pdf.letter_page.#{@i18n_key}.certified_content",
             :address          => complete_physical_address,
             :technician_list  => @owner.u_job_scale_rep,
             :work_dates       => "#{@owner.u_job_start_date.strftime(I18n.t('date.formats.long'))} - #{@owner.u_job_start_date.strftime(I18n.t('date.formats.long'))}")
    end

    def complete_physical_address
      address = "#{@owner.u_facility_name}"
      address << "\n#{@address[0]}"
      address << "\n#{@address[1]}"
      address << "\n#{@address[2]}"
      address << ", #{@address[3]}"
      address << "  #{@address[4]}"
      address << "\n United States"
    end

    def draw_letter_body(pdf)
      if certified?
        pdf.font_size 10
        pdf.text(certified_letter_copy, :align => :center)
        pdf.move_down 50
        pdf.font_size 10
        pdf.text certified_closing
      else
        pdf.font_size 12
        pdf.text letter_copy
      end
    end

    def certified_closing
      I18n.t('pdf.letter_page.certified_closing')
    end

    def draw_letter_title(pdf)
      pdf.font_size 15
      pdf.text("<b>#{letter_title}</b>", :inline_format => true, :align => :center)
      pdf.move_down 25
    end

    def letter_copy
      I18n.t("pdf.letter_page.#{@i18n_key}.content",
             :location_name    => @owner.u_facility_name,
             :pm_name          => "#{@owner.u_job_scale_rep}",
             :work_dates       => "#{@owner.u_job_start_date.strftime(I18n.t('date.formats.long'))} - #{@owner.u_job_start_date.strftime(I18n.t('date.formats.long'))}",
             :qa_inspected_by  => "#{@owner.u_job_scale_rep}")
    end

    def letter_title
      I18n.t("pdf.letter_page.#{@i18n_key}.title")
    end
  end
end