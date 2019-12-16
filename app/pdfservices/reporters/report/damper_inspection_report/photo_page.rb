module DamperInspectionReport
  class PhotoPage
    require "resolv"
    include Report::PhotoPageWritable

#    def initialize(record, options = {}, group_name, facility_name)
#      @record = record
#      #Rails.logger.debug("Photo Records :#{@record.inspect}")
#      @options = options
#      @group_name = group_name
#      @facility_name = facility_name
#    end


    def initialize(record, group_name, facility_name, with_picture)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
      @with_picture = with_picture
    end

   # def write(pdf)
      # super
      # pdf.indent(250) do
      #   draw_location_description(pdf)
      #   draw_damper_tag(pdf)
      #   draw_damper_type(pdf)
      #   draw_floor(pdf)
      #   draw_access_door_installation(pdf) unless @record.u_access_size.blank?
      #   draw_status(pdf)
      #   if @record.u_status == "Fail"
      #     draw_failure_reasons(pdf)
      #   end
      #   if @record.u_status == "NA"
      #     draw_na_reasons(pdf)
      #   end  
      # end

      # if @record.u_status == "Removed"
      # else
      #   if @record.u_status != "Fail"
      #     draw_open_image(pdf)
      #     draw_closed_image(pdf)
      #   else
      #     if @record.u_type.upcase != "FD"
      #       draw_open_image(pdf)
      #       draw_closed_image(pdf)
      #       draw_actuator_image(pdf)
      #     else
      #       draw_open_image(pdf)
      #       draw_closed_image(pdf)
      #     end
      #   end
      # end
      
   #   if @record.u_status == "Removed"
   #   else
   #     super
   #     pdf.indent(250) do
   #   	  draw_location_description(pdf)
   #       draw_damper_tag(pdf)
  #        draw_damper_type(pdf)
  #        draw_floor(pdf)
  #        #draw_access_door_installation(pdf) #unless @record.u_access_size.blank?
  #        draw_status(pdf)
  #        if @record.u_status == "Fail"
  #          #draw_access_door_installation(pdf)
  #          draw_failure_reasons(pdf)
  #          draw_passed_postrepair(pdf)
  #        end

  #        if @record.u_status == "NA"
  #          draw_access_door_installation(pdf)
  #          draw_na_reasons(pdf)
  #          draw_passed_postrepair(pdf)
  #        end
  #      end

  #      if @record.u_status != "Fail"
  #    	  draw_open_image(pdf)
  #        draw_closed_image(pdf)
  #      else
  #    	  if @record.u_type.upcase != "FD"
  #    	    draw_open_image(pdf)
  #          draw_closed_image(pdf)
  #          draw_actuator_image(pdf)
  #        else
  #          draw_open_image(pdf)
  #          draw_closed_image(pdf)
  #        end
  #      end
  #    end
  #  end

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
      if @record.u_status == "Removed"
      else	    
      super

      draw_table1(pdf)
      draw_table2(pdf)
      draw_table3(pdf)
      draw_table4(pdf)
      pdf.move_down 5

      if @with_picture
	draw_open_image(pdf)
        draw_closed_image(pdf)

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
	pdf.move_down 20     
	if @record.u_status.upcase == "PASS" 
        status_content = "<font size='12'><b>Pass</b></font>"
        cell_color = '13db13'
	elsif @record.u_status.upcase == "FAIL" || @record.u_status.upcase == "NA"
	  status_details = @record.u_status.upcase == "FAIL" ? "Fail" : "Non-Accessible"
        status_content = "<font size='12'><b>#{status_details}</b></font>"
        cell_color = 'ef3038'
       else
        status_content = "<font size='12'><b>Removed</b></font>"
        cell_color = '000000'
       end
      pdf.table([
        [
          {:content => "<font size='12'><b>FIRE DAMPER INSPECTION REPORT</b></font>", :colspan => 3, :width => 225, align: :center },
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
        damper_type = 'Smoke Damper (FSD)'
      else
        damper_type = 'Combination (FSD)'
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
       failure_reason = @record.u_reason.delete(' ').upcase == "OTHER" ? @record.u_other_failure_reason : @record.u_reason
      na_reason = @record.u_non_accessible_reasons.delete(' ').upcase == "OTHER" ? @record.u_other_nonaccessible_reason : @record.u_non_accessible_reasons
      na_reasons_label = "Other Non-Accessible Reason"
      deficiencies =  if @record.u_status == "Fail"
                    failure_reason
                  else
                    na_reason
                  end
      pdf.table([
        [
          { :content => "<font size='14'><b>DEFICIENCY DESCRIPTION(s):</b></font>",
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='14'><b>COMMENT:</b></font>",
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
     # if @record.u_repair_action_performed == "Damper Repaired"
     #                     repair_action = @record.u_dr_description.present? ? @record.u_repair_action_performed + ":" + @record.u_dr_description : @record.u_repair_action_performed
     #             elsif @record.u_repair_action_performed == "Damper Installed"
     #                     repair_action =  r_damper_model.present? ? @record.u_repair_action_performed + ":" + @record.u_dr_damper_model: @record.u_repair_action_performed
     #             elsif @record.u_repair_action_performed == "Actuator Installed"
     #                     repair_action = @record.u_dr_installed_actuator_model.present? ? @record.u_repair_action_performed + ":" + @record.u_dr_installed_actuator_model : @record.u_repair_action_performed
     #             else
     #                  repair_action = @record.u_access_size.present? ? @record.u_repair_action_performed + ":" + @record.u_access_size : @record.u_repair_action_performed
     #             end

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
        pdf.text("<b>#{label(:tag_number)} : </b> #{@record.u_tag}", inline_format: true)
      end

      def draw_damper_type(pdf)
        if @record.u_damper_name.upcase == "FIRE"
          pdf.text("<b>#{label(:damper_type)} : </b> Fire Damper", inline_format: true)
        elsif @record.u_damper_name.upcase == "SMOKE"
          pdf.text("<b>#{label(:damper_type)} : </b> Smoke Damper", inline_format: true)
        else
          pdf.text("<b>#{label(:damper_type)} : </b> Combination", inline_format: true)
        end
        #pdf.text("<b>#{label(:damper_type)} : </b> #{@record.u_damper_name}", inline_format: true)
      end

      def draw_floor(pdf)
        pdf.text("<b>#{label(:floor)} : </b> #{@record.u_floor.to_i}", inline_format: true)
      end

      def draw_access_door_installation(pdf)
        if @record.u_di_installed_access_door == "true"
          pdf.text("<b>Installed Access Door : </b> YES", inline_format: true)  
        else
          pdf.text("<b>Installed Access Door : </b> NO", inline_format: true)
        end
        # pdf.indent(10) do
        #   pdf.text("• #{@record.u_access_size}")
        # end
      end
 
      def draw_status(pdf)
        pdf.move_down 10
      	if @record.u_status == "Pass"
          pdf.fill_color '137d08'
      	elsif @record.u_status == "Fail"
      	  pdf.fill_color 'c1171d'
        elsif @record.u_status == "NA"
      	  pdf.fill_color 'f39d27'
      	else
      	  pdf.fill_color 'c1171d'
      	end
        pdf.text("<b>#{label(:status)} : </b> #{@record.u_status}", inline_format: true)
        pdf.fill_color '202020'
      end

      def label(i18n_key)
        I18n.t("pdf.photo_page.label.#{i18n_key}")
      end
      
      def draw_failure_reasons(pdf)
      	pdf.move_down 10
        pdf.fill_color 'c1171d'
        pdf.text("<b>#{DamperInspectionReporting.translate(:failure_reasons)} : </b> #{@record.u_reason}", inline_format: true)
        if @record.u_reason.delete(' ').upcase == "OTHER"
          pdf.text("<b>Other Failure Reason : </b> #{@record.u_other_failure_reason}", inline_format: true)
          # pdf.indent(10) do
          #   pdf.text("<b>Other Failure Reason : </b> #{@record.u_other_failure_reason}", inline_format: true)
          # end
        end
      end      

      def draw_na_reasons(pdf)
        pdf.move_down 10
        pdf.fill_color 'f39d27'
        pdf.text("<b>Non-Accessible Reason : </b> #{@record.u_non_accessible_reasons}", inline_format: true)
        if @record.u_non_accessible_reasons.delete(' ').upcase == "OTHER"
          pdf.text("<b>Other Non-Accessible Reason  : </b> #{@record.u_other_nonaccessible_reason}", inline_format: true)
          # pdf.indent(10) do
          #   pdf.text("<b>Other Non-Accessible Reason  : </b> #{@record.u_other_nonaccessible_reason}", inline_format: true)
          # end
        end
      end

      def draw_passed_postrepair(pdf)
        pdf.move_down 10
        pdf.fill_color 'f39d27'
        if @record.u_di_repaired_onsite == "true"
          pdf.text("<b>Post Repair Status  : </b> #{@record.u_di_passed_post_repair}", inline_format: true)
        else
          pdf.text("<b>Post Repair Status  : </b> Not Repaired", inline_format: true)
        end
      end

      def draw_open_image(pdf)
      pdf.move_down 20
	      
     # pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png",
     #   at: [60 - pdf.bounds.absolute_left, 215], :width => 250, :height => 230)#536
      #
      image =  @record.pdf_image1.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [50 - pdf.bounds.absolute_left, 255], :width => 220, :height => 220)#521
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 189])#404
      end
      pdf.move_down 5
      pdf.draw_text("Before Inspection",  at: [100 - pdf.bounds.absolute_left, 25])
    end

    def draw_closed_image(pdf)
     unless @record.u_status == "NA"	    
       pdf.move_down 20
	 #   pdf.image "#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", :at => [50,450], :width => 450    
      #pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png",
      #  at: [290 - pdf.bounds.absolute_left, 215], :width => 230, :height => 230)#536
       image =  @record.pdf_image2.path(:pdf)
        unless image.blank?
          pdf.image(image, at: [280 - pdf.bounds.absolute_left, 255], :width => 220, :height => 220)#521
        else
          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 189])#404
        end
        pdf.move_down 5
        pdf.draw_text("After Inspection",  at: [350 - pdf.bounds.absolute_left, 25])
     end
    end


#      def draw_open_image(pdf)
#        top_margin_pic_offset = 250 #235
#        pdf.fill_color '202020'
#        pdf.font_size 12
#        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 771 - top_margin_pic_offset])        
#        image = @record.pdf_image1.path(:pdf)
#        unless image.blank?
#          pdf.image(image, at: [30 - pdf.bounds.absolute_left, 756 - top_margin_pic_offset], fit: [225, 225])
#        else
#          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 639 - top_margin_pic_offset])
#        end
#        pdf.draw_text(DamperInspectionReporting.translate(:open), at: [30 - pdf.bounds.absolute_left, 518 - top_margin_pic_offset])

        # unless @record.u_image1.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image1}")[:data])), at: [30 - pdf.bounds.absolute_left, 756 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [90 - pdf.bounds.absolute_left, 639 - top_margin_pic_offset])
        # end
#      end

#      def draw_closed_image(pdf)
#      	top_margin_pic_offset = 235
#        pdf.fill_color '202020'
#        pdf.font_size 12
#        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [15 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset])
#        image = @record.pdf_image2.path(:pdf)
#        unless image.blank?
#          pdf.image(image, at: [30 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225])
#        else
#          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
#        end
#        pdf.move_down 100
#        pdf.draw_text(DamperInspectionReporting.translate(:closed), at: [30 - pdf.bounds.absolute_left, 243 - top_margin_pic_offset])

        # unless @record.u_image2.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image2}")[:data])), at:  [30 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [90 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        # end
#      end

      def draw_actuator_image(pdf)
      	top_margin_pic_offset = 235
        pdf.fill_color '202020'
        pdf.font_size 12
        if @record.u_image3
          pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [275 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset])
        end        
        image = @record.pdf_image3.path(:pdf)
        unless image.blank?
          pdf.image(image, at: [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225])
        else
          pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [350 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
        end          
        pdf.move_down 100
        pdf.draw_text(DamperInspectionReporting.translate(:actuator), at: [290 - pdf.bounds.absolute_left, 243 - top_margin_pic_offset])

        # unless @record.u_image2.blank?
        #   pdf.image StringIO.new(Base64.decode64(splitBase64("data:image/jpeg;base64,#{@record.u_image3}")[:data])), at:  [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225]
        # else
        #   pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [350 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
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
      
      def draw_heading(pdf)
	pdf.fill_color '202020'
      end

      def title
        return 'COMPREHENSIVE FIRE AND SMOKE DAMPER REPORT' if comprehensive?
        DamperInspectionReporting.translate(:heading)
      end

  end
end
