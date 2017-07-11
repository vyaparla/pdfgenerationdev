module FirestopSurveyReport
  class PhotoPage
  	include Report::PhotoPageWritable

    def write(pdf)
      super
      pdf.indent(250) do
        draw_location_description(pdf)
        draw_penetration_number(pdf)
        draw_floor(pdf)
        pdf.move_down 10
        #pdf.text("<b>Tag #: #{@record.u_tag}</b>", inline_format: true)
        draw_issue(pdf)
        #pdf.text("<b>Issue : #{@record.u_issue_type}</b>", inline_format: true)
        pdf.font_size 15
        pdf.move_down 10
        if @record.u_service_type == "Fixed On Site"
          pdf.text("<b>Corrected with UL system : </b> #{@record.u_corrected_url_system}", inline_format: true)        
          pdf.text("<b>Suggested UL System : </b> #{@record.u_suggested_ul_system}</b>", inline_format: true)
        end
        pdf.move_down 5
        pdf.text("<b>Barrier type : </b>  #{@record.u_barrier_type}", inline_format: true)
      end
      pdf.fill_color '202020'
      #pdf.font_size 15

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
      pdf.text("<b>Floor :</b> #{@record.u_floor.to_i}", inline_format: true)
    end

    def draw_issue(pdf)
      pdf.fill_color 'c1171d'
      pdf.text("<b>Issue : </b> #{@record.u_issue_type}", inline_format: true)
      pdf.fill_color '202020'
    end

    def draw_before_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at:  [35, 530], fit: [123, 123])
      image = @record.pdf_image1.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [44, 521], fit: [105, 105])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  11, at: [49, 464])
      end
      pdf.font_size 10
      pdf.draw_text("Before Installation", at: [44, 403])

      # unless @record.u_image1.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64, #{@record.u_image1}")[:data])), at:  [44, 521], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  11, at: [49, 464])
      # end
    end

    def draw_after_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at:  [35, 400], fit: [123, 123])
      image = @record.pdf_image2.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [44, 391], fit: [105, 105])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 334])
      end
      pdf.font_size 10
      pdf.draw_text("After Installation", at: [44, 272])

      # unless @record.u_image2.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64, #{@record.u_image2}")[:data])), at: [44, 386], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 329])
      # end
    end

    def title
      'Firestop Survey Report'
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
