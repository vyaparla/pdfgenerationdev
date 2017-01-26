module PdfjobReport
  class PhotoPage
  	include Report::PhotoPageWritable

    def initialize(record)
      @record = record
    end

    def write(pdf)
      super
      pdf.indent(250) do
      	draw_location_description(pdf)
        draw_damper_tag(pdf)
        draw_damper_type(pdf)
        draw_floor(pdf)
        draw_status(pdf)
      end
      draw_open_image(pdf)
      draw_closed_image(pdf)
      draw_actuator_image(pdf)
    end

    private

      def draw_open_image(pdf)
        top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        pdf.image(
          "#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png",
          at: [15 - pdf.bounds.absolute_left, 771 - top_margin_pic_offset]
        )
        
        unless @record.u_image1.blank?
          pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at: [30 - pdf.bounds.absolute_left, 756 - top_margin_pic_offset], fit: [225, 225]
        else
        end
      end

      def draw_closed_image(pdf)
      	top_margin_pic_offset = 235
      	pdf.fill_color '202020'
        pdf.font_size 12
        pdf.image(
          "#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png",
          at: [15 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset]
        )
        
        unless @record.u_image2.blank?
          pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        else
        end
      end

      def draw_actuator_image(pdf)
        top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        pdf.image(
          "#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png",
          at: [275 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset]
        )

        unless @record.u_image3.blank?
          pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image3}")[:data])), at:  [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        else
        end
      end
  
      def draw_location_description(pdf)
        pdf.font_size 20
        pdf.text(@record.u_location_desc, inline_format: true)
        pdf.move_down 25
        #pdf.text(@record.u_pdf_number, inline_format: true)
      end

      def draw_damper_tag(pdf)
        pdf.font_size 15
        #pdf.text("<b>#{label(:tag_number)}:</b> #{@record.u_tag}", inline_format: true)
        pdf.text("<b>Tag:</b> #{@record.u_tag}", inline_format: true)
      end

      def draw_damper_type(pdf)
        #pdf.text("<b>#{label(:damper_type)}:</b> #{@record.u_type}", inline_format: true)
        pdf.text("<b>Type:</b> #{@record.u_type}", inline_format: true)
      end

      def draw_floor(pdf)
        #pdf.text("<b>#{label(:floor)}:</b> #{@record.u_floor}", inline_format: true)
        pdf.text("<b>Floor:</b> #{@record.u_floor}", inline_format: true)
      end

      def draw_status(pdf)
        pdf.fill_color 'c1171d'
        #pdf.text("<b>#{label(:status)}:</b> #{@record.u_status}",inline_format: true)
        pdf.text("<b>status:</b> #{@record.u_status}", inline_format: true)
        pdf.fill_color '202020'
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
  end
end