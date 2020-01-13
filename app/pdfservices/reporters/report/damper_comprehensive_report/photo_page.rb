module DamperComprehensiveReport
  class PhotoPage
    include Report::PhotoPageWritable
    
    def initialize(record, group_name, facility_name, with_picture)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
      @with_picture = with_picture
    end

    # def write(pdf)
    #   super
    #   pdf.indent(250) do
    #     draw_location_description(pdf)
    #     draw_damper_tag(pdf)
    #     draw_damper_type(pdf)
    #     draw_floor(pdf)
    #     # unless @record.u_access_size.blank?
    #     #   draw_access_door_installation(pdf)
    #     # end
    #     draw_status(pdf)
    #     draw_repairs(pdf)
    #   end
    #   if @record.u_repair_action_performed == "Damper Repaired"
    #     draw_open_after_install_image(pdf)
    #     draw_closed_after_install_image(pdf)
    #     draw_reopened_after_install_image(pdf)
    #   else
    #     draw_open_after_install_image(pdf)
    #     draw_closed_after_install_image(pdf)
    #     draw_reopened_after_install_image(pdf)
    #     draw_new_install_image(pdf)
    #   end
    # end

    def write(pdf)
      super

      draw_table1(pdf)
      draw_table2(pdf)
      draw_table3(pdf)
      draw_table4(pdf)
      pdf.move_down 20

      if @with_picture

        if @record.u_repair_action_performed == "Damper Repaired"
          draw_open_after_install_image(pdf)
          draw_closed_after_install_image(pdf)
          draw_reopened_after_install_image(pdf)
        else
          draw_open_after_install_image(pdf)
          draw_closed_after_install_image(pdf)
          draw_reopened_after_install_image(pdf)
          draw_new_install_image(pdf)
        end
      end
    end

  private

  def table_params
      contracted_by = @group_name.blank? ? @facility_name : @group_name
      floor = @record.u_floor == "other" ? @record.u_other_floor : @record.u_floor
          
      { contracted_by: contracted_by ,
        facility: @facility_name,
        building: @record.u_building,
        installation_date: @record.work_dates,
        installed_by: @record.u_inspector,
        floor: floor,
        location: @record.u_location_desc,
        technician: @record.u_inspector,
        dept_area: @record.u_department_str_firestopinstall
      }
        
    end

    def draw_table1(pdf)
      if @record.u_status.upcase == "PASS" 
        status_content = "<font size='12'><b>Pass</b></font>"
        cell_color = '13db13'
      elsif @record.u_status.upcase == "FAIL" || @record.u_status.upcase == "NA"
        status_details = @record.u_status.upcase == "FAIL" ? "Fail" : "Non-Accessible"
        status_content = "<font size='12'><b>#{status_details}</b></font>"
        cell_color = 'ef3038'
      elsif @record.u_status.upcase == "" 
        status_content = "<font size='12'><b>#{status_details}</b></font>"
        #cell_color = '000000'
    end
      
      pdf.table([
        [
          {:content => "<font size='12'><b>FIRE DAMPER COMPREHENSIVE REPORT</b></font>", :colspan => 3, :width => 225, align: :center },
          {:content => "Status:", :colspan => 1, :width => 75, align: :left },
          {:content => status_content, :background_color=> cell_color,:colspan => 1, :width => 105, 
            :align => :center, :text_color => "ffffff" },
          {:content => "Asset #<br/><b>#{@record.u_tag}</b>", :colspan => 1, :width => 135, 
            :rowspan => 2, align: :right }
        ],
        [  
          { :content => "<font size='12'>Facility:  #{table_params[:facility]}</font>",
            :colspan => 3, :width => 225, align: :left },
          { :content => "<font size='12'>Floor:  #{table_params[:floor]}</font>", 
            :colspan => 2, :width => 180, align: :left }
        ],
        [
          { :content => "<font size='12'>Building:  #{table_params[:building]}</font>", 
            :colspan => 3, :width => 225, :align => :left },
          { :content => "<font size='12'>Damper Location:  #{table_params[:location]}</font>", 
            :colspan => 3, :width => 315, align: :left }          
        ],
        [
          { :content => "<font size='12'>Dept/Area:  #{table_params[:dept_area]}</font>", 
            :colspan => 3, :width => 225, align: :left },
          { :content => "", :colspan => 3, :width => 315 }          
        ],
        [
          { :content => "<font size='12'>Date:</font>", 
            :colspan => 1, :width => 60, align: :right },
          { :content => "<font size='11'>#{@record.u_inspected_on.localtime.strftime('%m/%d/%Y')}</font>", 
            :colspan => 1, :width => 75, align: :left }, 
          { :content => "<font size='12'>Time:</font>", 
            :colspan => 1, :width => 90, align: :right },
          { :content => "<font size='11'>#{@record.u_inspected_on.localtime.strftime('%I:%M:%S %p')}</font>", 
            :colspan => 1, :width => 75, align: :left },
          { :content => "<font size='12'>Technician</font>", 
            :colspan => 1, :width => 105, align: :left },
          { :content => "<font size='12'>#{table_params[:technician]}</font>", 
            :colspan => 1, :width => 135, align: :center }             
        ]
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5
    end

    def draw_table2(pdf)
      if @record.u_damper_name.upcase == "FIRE"
        damper_type = 'Fire Damper (FD)'
      elsif @record.u_damper_name.upcase == "SMOKE"
        damper_type = 'Smoke Damper (SD)'
      else
        damper_type = 'Fire Smoke Damper (FSD)'
      end

      pdf.table([
        [
          { :content => "<font size='14'><b>DAMPER DESCRIPTION:</b></font>", 
            :colspan => 6, :width => 515, align: :center }
        ],
        [ { :content => "<font size='12'>Damper Type:</font>", 
            :colspan => 1, :width => 60, align: :center },
          { :content => "<font size='12'>#{damper_type}</font>", 
            :colspan => 5, :width => 455, align: :left }   
        ]
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5 
    end  

    def draw_table3(pdf)
      deficiencies =  if @record.u_status == "Fail"
        @record.u_reason
      else
        @record.u_non_accessible_reasons
      end
      pdf.table([
       [
         { :content => "<font size='14'><b>DEFICIENCY DESCRIPTION(s):</b></font>", 
           :colspan => 2, :width => 225, align: :left },
         { :content => "<font size='14'><b>COMMENT</b></font>", 
           :colspan => 4, :width => 315, align: :left }  
       ],

       [
         { :content => "<font size='12'>#{deficiencies}</font>", 
           :colspan => 2, :width => 225, align: :left },
         { :content => "<font size='12'>#{@record.u_dr_description}</font>", 
           :colspan => 4, :width => 315, align: :left }  
       ],
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5 
    end  

    def draw_table4(pdf)
      pdf.table([
        [
          { :content => "<font size='12'><b>REPAIR ACTION(s) PERFORMED:</b></font>", 
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='12'><b>SUBSEQUENT FAILURE REASON:</b></font>", 
            :colspan => 4, :width => 315, align: :left }  
        ],
        [
          { :content => "<font size='12'>#{@record.u_repair_action_performed}</font>", 
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='12'>#{@record.u_reason2}</font>", 
            :colspan => 4, :width => 315, align: :left }  
        ],
        
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5 
    end  

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
      pdf.text("<b>Floor : </b> #{@record.u_floor}", inline_format: true)
    end

    def draw_status(pdf)
      if @record.u_dr_passed_post_repair == "Pass"
        pdf.fill_color '137d08'
        @post_status = "Passed Post Repair"
      elsif @record.u_dr_passed_post_repair == "Fail"
        pdf.fill_color 'c1171d'
        @post_status = "Failed Post Repair"
      else
        pdf.fill_color 'f39d27'
      end
      #pdf.text("<b>Status : </b> #{@record.u_dr_passed_post_repair}", inline_format: true)
      pdf.text("<b>Post Repair Status : </b> #{@post_status}", inline_format: true)
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
      pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", 
        at: [60 - pdf.bounds.absolute_left, 275], :width => 123, :height => 123)#530
      image = @record.pdf_image1.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [60 - pdf.bounds.absolute_left, 275], :width => 120, :height => 120)
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size: 10,
          at: [70 - pdf.bounds.absolute_left, 210])#464
      end
      #pdf.font_size 10
      #pdf.draw_text("#{DamperRepairReporting.translate('open_after_installation')}", at: [44, 394])#403
      pdf.draw_text("Open",  at: [100 - pdf.bounds.absolute_left, 140])
      pdf.move_down 5
      # unless @record.u_image1.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at: [ 44, 521], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at:  [49, 464])
      # end
    end

    def draw_closed_after_install_image(pdf)
      # pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", 
      #   at: [380 - pdf.bounds.absolute_left, 275], :width => 123, :height => 123)
      image = @record.pdf_image2.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [380 - pdf.bounds.absolute_left, 275], :width => 120, :height => 120)
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 10, 
      #     at: [395 - pdf.bounds.absolute_left, 210])
      
        pdf.draw_text("Closed",  at: [400 - pdf.bounds.absolute_left, 140])
      end
      pdf.move_down 5
      # unless @record.u_image2.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [ 44, 386], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size:  11, at: [49, 329])
      # end
    end

    def draw_new_install_image(pdf)
      # pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", 
      #   at: [60 - pdf.bounds.absolute_left, 125], :width => 123, :height => 123)
      image = @record.pdf_image4.path(:pdf) 
      unless image.blank?
        pdf.image(image, at: [60 - pdf.bounds.absolute_left, 125], :width => 120, :height => 120)
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 10, 
      #     at: [70 - pdf.bounds.absolute_left, 70])
      # Looped inside - no image no lable
        pdf.draw_text("After Installation",  at: [80 - pdf.bounds.absolute_left, -9])
      end
      # unless @record.u_image3.blank?
      #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image3}")[:data])), at:  [ 44, 251], fit: [105, 105]
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 11, at:    [49, 194])
      # end
    end

    def draw_reopened_after_install_image(pdf)
      #pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", 
      #  at: [380 - pdf.bounds.absolute_left, 125], :width => 123, :height => 123)
      image = @record.pdf_image3.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [380 - pdf.bounds.absolute_left, 125], 
          :width => 120, :height => 120)
      # else
      #   pdf.draw_text('Photo Unavailable', style: :bold, size: 10, 
      #     at: [395 - pdf.bounds.absolute_left, 60])
      # Looped inside - no image no lable
       pdf.draw_text("Operational",  at: [400 - pdf.bounds.absolute_left, -9])
      end
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
      #@options[:comprehensive] == true
      true
    end

    def title
      return 'COMPREHENSIVE FIRE AND SMOKE DAMPER REPORT' if comprehensive?
      DamperRepairReporting.translate(:heading)
    end
  end
end
