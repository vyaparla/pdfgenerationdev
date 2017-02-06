module DoorInspectionReport
  class PhotoPage
  	include Report::PhotoPageWritable

    def write(pdf)
      super
      pdf.indent(250) do
        draw_location_description(pdf)
        draw_door_number(pdf)
        draw_floor(pdf)
        pdf.move_down 10
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
      pdf.text("<b>Door Number :</b> #{@record.u_tag}", inline_format: true)
    end

    def draw_floor(pdf)
      pdf.text("<b>Floor :</b> #{@record.u_floor}", inline_format: true)
    end

    def draw_secured_image(pdf)
      pdf.fill_color '202020'
      pdf.font_size 12
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 536])

      unless @record.u_image1.blank?
      	 pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at:  [30 - pdf.bounds.absolute_left, 521], fit: [225, 225]
      else
      	pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 404])
      end
      pdf.draw_text(I18n.t('ui.door_inspection_report_pdf.report_data_pages.door_secured'), at: [30 - pdf.bounds.absolute_left, 283])
    end

    def draw_unsecured_image(pdf)
      pdf.fill_color '202020'
      pdf.font_size 12
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 261])

      unless @record.u_image2.blank?
      	 pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 246], fit: [225, 225]
      else
      	pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 129])
      end
      pdf.move_down 100
      pdf.draw_text(I18n.t('ui.door_inspection_report_pdf.report_data_pages.door_unsecured'), at: [30 - pdf.bounds.absolute_left, 8])
    end

    def splitBase64(uri)
      if uri.match(%r{^data:(.*?);(.*?),(.*)$})
       return {
          type:      $1, # "image/png"
          encoder:   $2, # "base64"
          data:      $3, # data string
          extension: $1.split('/')[1] # "png"
        }
      end
    end

    def title
      I18n.t('ui.door_inspection_report_pdf.report_data_pages.heading')
    end
  end
end