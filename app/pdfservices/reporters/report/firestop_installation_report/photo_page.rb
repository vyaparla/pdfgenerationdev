module FirestopInstallationReport
  class PhotoPage
    include Report::PhotoPageWritable

    def initialize(record, group_name, facility_name)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
    end
    
    # def write(pdf)
    #   super
    #   pdf.indent(250) do
    #     draw_location_description(pdf)
    #     draw_penetration_number(pdf)
    #     draw_floor(pdf)
    #     pdf.move_down 10
    #     pdf.font_size 15
    #     draw_issue(pdf)
    #     pdf.move_down 10
    #     #pdf.text("<b>Issue : #{@record.u_issue_type}</b>", inline_format: true)
    #     if @record.u_service_type == "Fixed On Site"
    #       pdf.text("<b>Corrected with UL system : </b> #{@record.u_corrected_url_system}", inline_format: true)
    #       pdf.text("<b>Suggested UL System : </b> #{@record.u_suggested_ul_system}</b>", inline_format: true)
    #     end
    #     pdf.move_down 5
    #     pdf.text("<b>Barrier type : </b> #{@record.u_barrier_type}", inline_format: true)
    #   end
    #   pdf.fill_color '202020'
    #   #pdf.font_size 12
    #   if @record.u_service_type != "Fixed On Site"
    #     draw_before_image(pdf)
    #   else
    #     draw_before_image(pdf)
    #     draw_after_image(pdf)
    #   end
    # end

    def write(pdf)
      super
      pdf.indent(250) do
        draw_date(pdf)
        draw_assets(pdf)
        draw_floor(pdf)
        draw_location_description(pdf)
        draw_issue(pdf)
        draw_barrier_type(pdf)
        draw_penetration_type(pdf)
        if @record.u_service_type == "Fixed On Site"
          draw_corrective_action(pdf)
        else
          draw_suggested_corrective_action(pdf)
        end
      end

      if @record.u_service_type != "Fixed On Site"
        draw_before_image(pdf) 
      else
        draw_before_image(pdf)
        draw_after_image(pdf)
      end
    end

  private
    
    def draw_date(pdf)
      pdf.font_size 12
      pdf.text("<b>Date :</b> #{@record.u_inspected_on.localtime.strftime('%m/%d/%Y')}", inline_format: true)
      pdf.move_down 10
    end

    def draw_assets(pdf)
      pdf.font_size 12
      pdf.text("<b>Asset # :</b> #{@record.u_tag}", inline_format: true)
      pdf.move_down 10
    end

    def draw_floor(pdf)      
      if @record.u_floor == "Other"
        pdf.font_size 12
        pdf.text("<b>Floor :</b> #{@record.u_other_floor}", inline_format: true)
        pdf.move_down 10
      else
        pdf.font_size 12
        pdf.text("<b>Floor :</b> #{@record.u_floor}", inline_format: true)
        pdf.move_down 10
      end
    end

    def draw_location_description(pdf)
      pdf.font_size 12
      pdf.text("<b>Location :</b> #{@record.u_location_desc}", inline_format: true)
      pdf.move_down 10
    end

    def draw_issue(pdf)
      pdf.font_size 12
      pdf.text("<b>Issue :</b> #{@record.u_issue_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_barrier_type(pdf)
      pdf.font_size 12
      pdf.text("<b>Barrier Type :</b> #{@record.u_barrier_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_penetration_type(pdf)
      pdf.font_size 12
      pdf.text("<b>Penetration Type :</b> #{@record.u_penetration_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_corrective_action(pdf)
      pdf.font_size 12
      pdf.text("<b>Corrective Action :</b> #{@record.u_corrected_url_system}", inline_format: true)
      pdf.move_down 10
    end
    
    def draw_suggested_corrective_action(pdf)
      pdf.font_size 12
      pdf.text("<b>Suggested Corrective Action :</b> #{@record.u_suggested_ul_system}", inline_format: true)
      pdf.move_down 10
    end

    # def draw_penetration_number(pdf)
    #   pdf.font_size 15
    #   pdf.text("<b>Asset # :</b> #{@record.u_tag}", inline_format: true)
    #   #pdf.text("<b>Penetration Number :</b> #{@record.u_tag}", inline_format: true)
    # end

    def draw_before_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 521])#536
      image = @record.pdf_image1.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [30 - pdf.bounds.absolute_left, 506], fit: [225, 225])#521
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12,  at: [90 - pdf.bounds.absolute_left, 389])#404
      end
      pdf.draw_text("Before Installation", at: [30 - pdf.bounds.absolute_left, 265])#280
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
    end

    def title
      'Firestop Installation Report'
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