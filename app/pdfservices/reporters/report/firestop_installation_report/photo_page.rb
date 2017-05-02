module FirestopInstallationReport
  class PhotoPage
    include Report::PhotoPageWritable
    
    def write(pdf)
      super
      pdf.indent(250) do
        draw_location_description(pdf)
        draw_penetration_number(pdf)
        draw_floor(pdf)
        pdf.move_down 10
        pdf.font_size 15
        draw_issue(pdf)
        pdf.move_down 10
        #pdf.text("<b>Issue : #{@record.u_issue_type}</b>", inline_format: true)
        if @record.u_service_type == "Fixed On Site"
          pdf.text("<b>Corrected with UL system : </b> #{@record.u_corrected_url_system}", inline_format: true)
          pdf.text("<b>Suggested UL System : </b> #{@record.u_suggested_ul_system}</b>", inline_format: true)
        end
        pdf.move_down 5
        pdf.text("<b>Barrier type : </b> #{@record.u_barrier_type}", inline_format: true)
      end
      pdf.fill_color '202020'
      #pdf.font_size 12
      if @record.u_service_type != "Fixed On Site"
        draw_before_image(pdf)
      else
        draw_before_image(pdf)
        draw_after_image(pdf)
      end
    end

  private
    
    def draw_location_description(pdf)
      pdf.font_size 20
      pdf.text(@record.u_location_desc, inline_format: true)
      pdf.move_down 25
    end

    def draw_penetration_number(pdf)
      pdf.font_size 15
      pdf.text("<b>Asset # :</b> #{@record.u_tag}", inline_format: true)
      #pdf.text("<b>Penetration Number :</b> #{@record.u_tag}", inline_format: true)
    end

    def draw_floor(pdf)
      pdf.text("<b>Floor :</b> #{@record.u_floor}", inline_format: true)
    end
    
    def draw_issue(pdf)
      pdf.fill_color 'c1171d'
      pdf.text("<b>Issue : </b> #{@record.u_issue_type}", inline_format: true)
      pdf.fill_color '202020'
    end

    def title
      'Firestop Installation Report'
    end

    def draw_before_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 536])
      image = @record.pdf_image1.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [30 - pdf.bounds.absolute_left, 521], fit: [225, 225])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12,  at: [90 - pdf.bounds.absolute_left, 404])
      end
      pdf.draw_text("Before Installation", at: [30 - pdf.bounds.absolute_left, 280])

      # unless @record.u_image1.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64, #{@record.u_image1}")[:data])), at:  [30 - pdf.bounds.absolute_left, 521], fit: [225, 225]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12,  at: [90 - pdf.bounds.absolute_left, 404])
      # end
    end

    def draw_after_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 270])
      image = @record.pdf_image2.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [30 - pdf.bounds.absolute_left, 255], fit: [225, 225])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 135])
      end
      pdf.draw_text("After Installation", at: [30 - pdf.bounds.absolute_left, 15])

      # unless @record.u_image2.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64, #{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 246], fit: [225, 225]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 129])
      # end
    end

    # def splitBase64(uri)
    #   if uri.match(%r{^data:(.*?);(.*?),(.*)$})
    #     return {
    #       type:      $1, # "image/png"
    #       encoder:   $2, # "base64"
    #       data:      $3, # data string
    #       extension: $1.split('/')[1] # "png"
    #     }
    #   end
    # end
  end
end