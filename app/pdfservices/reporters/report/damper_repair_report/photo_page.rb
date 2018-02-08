module DamperRepairReport
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
        draw_damper_tag(pdf)
        draw_damper_type(pdf)
        draw_floor(pdf)
        # unless @record.u_access_size.blank?
        #   draw_access_door_installation(pdf)
        # end
        draw_status(pdf)
        draw_repairs(pdf)
      end
      draw_open_after_install_image(pdf)
      draw_closed_after_install_image(pdf)
      draw_reopened_after_install_image(pdf)
      draw_new_install_image(pdf)
    end

  private

    def draw_location_description(pdf)
      pdf.font_size 20
      pdf.text(@record.u_location_desc, inline_format: true)
      pdf.move_down 25
    end

    def draw_damper_tag(pdf)
      pdf.font_size 15
      pdf.text("<b>Asset # : </b> #{@record.u_tag}",inline_format: true)
      #pdf.text("<b>Tag : </b> #{@record.u_tag}",inline_format: true)
    end

    def draw_damper_type(pdf)
      if @record.u_damper_name.upcase == "FIRE"
        pdf.text("<b>Asset Type  : </b> Fire Damper", inline_format: true)
      elsif @record.u_damper_name.upcase == "SMOKE"
        pdf.text("<b>Asset Type  : </b> Smoke Damper", inline_format: true)
      else
        pdf.text("<b>Asset Type  : </b> Combination", inline_format: true)
      end 
      #pdf.text("<b>Asset Type : </b> #{@record.u_type}", inline_format: true)
      #pdf.text("<b>Damper Type : </b> #{@record.u_type}", inline_format: true)
    end

    def draw_floor(pdf)
      pdf.text("<b>Floor : </b> #{@record.u_floor.to_i}", inline_format: true)
    end

    def draw_status(pdf)
      if @record.u_dr_passed_post_repair == "Pass"
        pdf.fill_color '137d08'
      elsif @record.u_dr_passed_post_repair == "Fail"
        pdf.fill_color 'c1171d'
      else
        pdf.fill_color 'f39d27'
      end
      pdf.text("<b>Status : </b> #{@record.u_dr_passed_post_repair}", inline_format: true)
      pdf.fill_color '202020'
    end

    # def draw_access_door_installation(pdf)
    #   pdf.text("<b>Installed Access Door : </b> #{@record.u_access_size}", inline_format: true)
    #   # pdf.indent(10) do
    #   #   pdf.text("• #{@record.u_access_size}")
    #   # end
    # end
    
    def draw_repairs(pdf)
      pdf.move_down 10
      pdf.text("<b>Repair Performed : </b> #{@record.u_repair_action_performed}", inline_format: true)
      if @record.u_repair_action_performed == "Damper Repaired"
        pdf.indent(10) do
          pdf.text("<b>#{DamperRepairReporting.translate('type_of_repair')} : </b> #{@record.u_dr_description}", inline_format: true)
          #pdf.text("#{@record.u_dr_description}", inline_format: true)
        end 
      elsif @record.u_repair_action_performed == "Damper Installed"
        pdf.indent(10) do
          pdf.text("<b>#{DamperRepairReporting.translate('damper_model')} : </b> #{@record.u_dr_damper_model}", inline_format: true)
          pdf.text("<b>#{DamperRepairReporting.translate('damper_size')}  : </b> #{@record.u_dr_installed_damper_width} x #{@record.u_dr_installed_damper_height}", inline_format: true)
          pdf.text("<b>#{DamperRepairReporting.translate('damper_type')}  : </b> #{@record.u_dr_installed_damper_type}", inline_format: true)
        end
      elsif @record.u_repair_action_performed == "Actuator Installed"
        pdf.indent(10) do
          pdf.text("<b>#{DamperRepairReporting.translate('actuator_model')}   : </b> #{@record.u_dr_installed_actuator_model}", inline_format: true)
          pdf.text("<b>#{DamperRepairReporting.translate('actuator_type')}    : </b> #{@record.u_dr_installed_actuator_type}", inline_format: true)
          pdf.text("<b>#{DamperRepairReporting.translate('actuator_voltage')} : </b> #{@record.u_dr_actuator_voltage}", inline_format: true)
        end
      else
        pdf.indent(10) do
          pdf.text("<b>Installed Access Door : </b> #{@record.u_access_size}", inline_format: true)
        end
      end
    end

    def draw_open_after_install_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [35, 521], fit: [123, 123])#530
      image = @record.pdf_image1.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [44, 512], fit: [105, 105])#521
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 455])#464
      end
      pdf.font_size 10
      pdf.draw_text("#{DamperRepairReporting.translate('open_after_installation')}", at: [44, 394])#403

      # unless @record.u_image1.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at: [ 44, 521], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at:  [49, 464])
      # end
    end

    def draw_closed_after_install_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [35, 395], fit: [123, 123])
      image = @record.pdf_image2.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [44, 386], fit: [105, 105])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 329])
      end
      pdf.font_size 10
      pdf.draw_text("#{DamperRepairReporting.translate('closed_after_installation')}", at: [44, 268])

      # unless @record.u_image2.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [ 44, 386], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  11, at: [49, 329])
      # end
    end

    def draw_reopened_after_install_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [35, 260], fit: [123, 123])
      image = @record.pdf_image3.path(:pdf)      
      unless image.blank?
        pdf.image(image, at:  [44, 251], fit: [105, 105])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 194])
      end
      pdf.font_size 10
      pdf.draw_text("#{DamperRepairReporting.translate('reopened_after_installation')}", at: [44, 133])

      # unless @record.u_image3.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image3}")[:data])), at:  [ 44, 251], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at:    [49, 194])
      # end
    end

    def draw_new_install_image(pdf)
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [35, 125], fit: [123, 123])
      image = @record.pdf_image4.path(:pdf)
      unless image.blank?
        pdf.image(image, at:  [44, 116], fit: [105, 105])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 59])
      end
      pdf.font_size 10
      pdf.draw_text("#{DamperRepairReporting.translate('new_actuator_installed')}", at: [44, -2])

      # unless @record.u_image4.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image4}")[:data])), at:  [ 44, 116], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at: [49, 59])
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

    def comprehensive?
      @options[:comprehensive] == true
    end

    def title
      return 'COMPREHENSIVE FIRE AND SMOKE DAMPER REPORT' if comprehensive?
      DamperRepairReporting.translate(:heading)
    end
  end
end