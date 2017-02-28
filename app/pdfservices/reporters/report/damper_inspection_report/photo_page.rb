module DamperInspectionReport
  class PhotoPage
    require "resolv"
    include Report::PhotoPageWritable

    def initialize(record, options = {})
      @record = record
      @options = options
    end

    def write(pdf)
      
      if @record.u_status == "Removed"
      else
        super
        pdf.indent(250) do
      	  draw_location_description(pdf)
          draw_damper_tag(pdf)
          draw_damper_type(pdf)
          draw_floor(pdf)
          draw_access_door_installation(pdf) unless @record.u_access_size.blank?
          draw_status(pdf)
          if @record.u_status == "Fail"
            draw_failure_reasons(pdf)
          end
        end

        if @record.u_status != "Fail"
      	  draw_open_image(pdf)
          draw_closed_image(pdf)
        else
      	  if @record.u_type.upcase != "FD"
      	    draw_open_image(pdf)
            draw_closed_image(pdf)
            draw_actuator_image(pdf)
          else
            draw_open_image(pdf)
            draw_closed_image(pdf)
          end
        end
      end  
    end

    private

      def draw_location_description(pdf)
        pdf.font_size 20
        pdf.text(@record.u_location_desc, inline_format: true)
        pdf.move_down 25
      end

      def draw_damper_tag(pdf)
        pdf.font_size 15
        pdf.text("<b>#{label(:tag_number)}:</b> #{@record.u_tag}", inline_format: true)
      end

      def draw_damper_type(pdf)
        pdf.text("<b>#{label(:damper_type)}:</b>" + "#{@record.u_type}", inline_format: true)
      end 

      def draw_floor(pdf)
        pdf.text("<b>#{label(:floor)}:</b> #{@record.u_floor}", inline_format: true)
      end

      def draw_access_door_installation(pdf)
        pdf.text("<b>Installed Access Door:</b>", inline_format: true)
        pdf.indent(10) do
          pdf.text("• #{@record.u_access_size}")
        end
      end
 
      def draw_status(pdf)
      	if @record.u_status == "Pass"
          pdf.fill_color '137d08'
      	elsif @record.u_status == "Fail"
      	  pdf.fill_color 'c1171d'
        elsif @record.u_status == "NA"
      	  pdf.fill_color 'f39d27'
      	else
      	  pdf.fill_color 'c1171d'
      	end
        pdf.text("<b>#{label(:status)}:</b> #{@record.u_status}",inline_format: true)
        pdf.fill_color '202020'
      end

      def label(i18n_key)
        I18n.t("pdf.photo_page.label.#{i18n_key}")
      end
      
      def draw_failure_reasons(pdf)
      	pdf.move_down 25
        pdf.fill_color 'c1171d'
        pdf.text("<b>#{DamperInspectionReporting.translate(:failure_reasons)}:</b> #{@record.u_reason}", inline_format: true)
      end

      def draw_open_image(pdf)
        top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 771 - top_margin_pic_offset])

        # unless @record.u_image1.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at: [30 - pdf.bounds.absolute_left, 756 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [90 - pdf.bounds.absolute_left, 639 - top_margin_pic_offset])
        # end

        image_data = @record.pdf_image1.path(:pdf)
        if image_data
          pdf.image(image_data, at: [30 - pdf.bounds.absolute_left, 756 - top_margin_pic_offset], fit: [225, 225])
        else
          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [90 - pdf.bounds.absolute_left, 639 - top_margin_pic_offset])
        end
        pdf.draw_text(DamperInspectionReporting.translate(:open), at: [30 - pdf.bounds.absolute_left, 518 - top_margin_pic_offset])
      end

      def draw_closed_image(pdf)
      	top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset])

        # unless @record.u_image2.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        # end
        
        image_data = @record.pdf_image2.path(:pdf)
        if image_data
          pdf.image(image_data, at:  [30 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225])
        else
          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        end
        pdf.move_down 100
        pdf.draw_text(DamperInspectionReporting.translate(:closed), at: [30 - pdf.bounds.absolute_left, 243 - top_margin_pic_offset])
      end

      def draw_actuator_image(pdf)
      	top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        if @record.u_image3
          pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [275 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset])
        end
   
        # unless @record.u_image2.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image3}")[:data])), at:  [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [350 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        # end
        image_data = @record.pdf_image3.path(:pdf)
        if image_data
          pdf.image(image_data, at:  [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225])
        else
          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [350 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        end          
        pdf.move_down 100
        pdf.draw_text(DamperInspectionReporting.translate(:actuator), at: [290 - pdf.bounds.absolute_left, 243 - top_margin_pic_offset])
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
    
      def comprehensive?
        @options[:comprehensive] == true
      end

      def title
        return 'COMPREHENSIVE FIRE AND SMOKE DAMPER REPORT' if comprehensive?
        DamperInspectionReporting.translate(:heading)
      end

  end
end