module DoorInspectionReport
  class PhotoPage
  	include Report::PhotoPageWritable

    def initialize(record, options = {}, group_name, facility_name)
      @record = record
      @options = options
      @group_name = group_name
      @facility_name = facility_name
    end

    def write(pdf)
      super
      pdf.indent(250) do
        draw_location_description(pdf)
        draw_door_number(pdf)
        draw_floor(pdf)
        draw_door_inspection_result(pdf)
        pdf.font_size 15
        pdf.move_down 10
        if @record.u_door_inspection_result == "Non-Conforming"
          draw_firedoor_deficiency_codes(pdf)
        end
      end
      draw_secured_image(pdf)
      draw_unsecured_image(pdf)
    end

  private

    def draw_location_description(pdf)
      pdf.font_size 20
      pdf.text(@record.u_location_desc, inline_format: true)
      pdf.move_down 25
    end

    def draw_door_number(pdf)
      pdf.font_size 15
      pdf.text("<b>Asset # : </b> #{@record.u_tag}", inline_format: true)
      #pdf.text("<b>Door Number : </b> #{@record.u_tag}", inline_format: true)
    end

    def draw_floor(pdf)
      pdf.text("<b>Floor : </b> #{@record.u_floor}", inline_format: true)
    end

    def draw_door_inspection_result(pdf)
      pdf.move_down 10
      pdf.fill_color 'f39d27'
      pdf.text("<b>Inspection Result : </b> #{@record.u_door_inspection_result}", inline_format: true)
    end

    def draw_firedoor_deficiency_codes(pdf)
      pdf.move_down 5
      pdf.fill_color 'c6171e'
      pdf.text("<b>#{I18n.t('ui.door_inspection_report_pdf.report_data_pages.' + 'reason_for_non_compliance')} : </b>", inline_format: true)
      @codes = FiredoorDeficiency.where(:firedoor_service_sysid => @record.u_service_id, :firedoor_asset_sysid => @record.u_asset_id)
      pdf.indent(10) do
        @codes.each do |code|
          pdf.text("<b>#{code.firedoor_deficiencies_code}, #{code.firedoor_deficiencies_codename}</b>", inline_format: true) 
        end
      end
    end

    def draw_secured_image(pdf)
      pdf.fill_color '202020'
      pdf.font_size 12
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 521])#536
      image =  @record.pdf_image1.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [30 - pdf.bounds.absolute_left, 506], fit: [225, 225])#521
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 389])#404
      end
      pdf.draw_text(I18n.t('ui.door_inspection_report_pdf.report_data_pages.door_secured'), at: [30 - pdf.bounds.absolute_left, 265])#283

      # unless @record.u_image1.blank?
      #    pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at:  [30 - pdf.bounds.absolute_left, 521], fit: [225, 225]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 404])
      # end
    end

    def draw_unsecured_image(pdf)
      pdf.fill_color '202020'
      pdf.font_size 12
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 261])
      image =  @record.pdf_image2.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [30 - pdf.bounds.absolute_left, 246], fit: [225, 225])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 129])
      end 
      pdf.move_down 100
      pdf.draw_text(I18n.t('ui.door_inspection_report_pdf.report_data_pages.door_unsecured'), at: [30 - pdf.bounds.absolute_left, 8])

      # unless @record.u_image2.blank?
      #    pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 246], fit: [225, 225]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 129])
      # end
    end

    # def splitBase64(uri)
    #   if uri.match(%r{^data:(.*?);(.*?),(.*)$})
    #    return {
    #       type:      $1, # "image/png"
    #       encoder:   $2, # "base64"
    #       data:      $3, # data string
    #       extension: $1.split('/')[1] # "png"
    #     }
    #   end
    # end

    def title
      I18n.t('ui.door_inspection_report_pdf.report_data_pages.heading')
    end
  end
end
